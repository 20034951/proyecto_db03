SHOW DATABASES;

-- Creación de Base de Datos
CREATE DATABASE IF NOT EXISTS InventarioDB;
USE InventarioDB;

-- Creación de Tablas
CREATE TABLE roles (
	id_rol INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE usuarios(
	id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombres VARCHAR(120) NOT NULL,
    apellidos VARCHAR(120) NOT NULL,
    correo VARCHAR(120) UNIQUE NOT NULL,
    clave VARBINARY(255) NOT NULL,
    rol_id INT NOT NULL,
    FOREIGN KEY(rol_id) REFERENCES roles(id_rol)
);

CREATE TABLE ubicaciones (
	id_ubicacion INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE productos (
	id_producto INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(50) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    ubicacion_id INT NOT NULL,
    FOREIGN KEY (ubicacion_id) REFERENCES ubicaciones(id_ubicacion)
);

CREATE TABLE tipos_transaccion (
	id_tipo INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(60) UNIQUE NOT NULL
);


CREATE TABLE transacciones (
	id_transaccion INT AUTO_INCREMENT PRIMARY KEY,
    producto_id INT NOT NULL,
    cambio_stock INT NOT NULL,
    tipo_id INT NOT NULL,
    usuario_id INT NOT NULL,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (producto_id) REFERENCES productos(id_producto),
    FOREIGN KEY (tipo_id) REFERENCES tipos_transaccion(id_tipo),
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id_usuario)
);

-- Implementación de Partición Horizontal para reporteria y para replicación en MongoDB
DROP TABLE transacciones_reportes_historia;
CREATE TABLE transacciones_reportes_historia (
	id_transaccion INT ,
    producto_id INT NOT NULL,
    cambio_stock INT NOT NULL,
    tipo_id INT NOT NULL,
    usuario_id INT NOT NULL,
    fecha DATE NOT NULL,
    PRIMARY KEY (id_transaccion, fecha)
) PARTITION BY RANGE (YEAR(fecha)) (
	PARTITION p2021 VALUES LESS THAN (2022),
    PARTITION p2022 VALUES LESS THAN (2023),
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION p2025 VALUES LESS THAN (2026)
);

-- Creación de Store Procedures

-- Tabla usuarios
-- Registrar Usuario
DELIMITER $$
CREATE PROCEDURE InsertarUsuario (
	IN p_nombres VARCHAR(120),
    IN p_apellidos VARCHAR(120),
    IN p_correo VARCHAR(120),
    IN p_clave VARBINARY(255),
    IN p_rol_id INT
)
BEGIN
	-- Encriptar la clave de usuario
    DECLARE clave_encriptada VARBINARY(255);
    SET clave_encriptada = AES_ENCRYPT(contrasenia, '$3cr3t4');
    
    -- Insertar el usuario con la clave encriptada
    INSERT INTO usuarios (nombres, apellidos, correo, clave, rol_id)
    VALUES (p_nombres, p_apellidos, p_correo, clave_encriptada, p_rol_id);
END $$

DELIMITER ;


-- Tabla ubicaciones
-- Registrar Ubicacion
DELIMITER $$
CREATE PROCEDURE InsertarUbicacion (
	IN p_descripcion VARCHAR(100)
)
BEGIN
	INSERT INTO ubicaciones (descripcion)
	VALUES (p_descripcion);

END $$
DELIMITER ;

-- Actualizar Ubicacion
DELIMITER $$
CREATE PROCEDURE ActualizarUbicacion (
	IN p_id_ubicacion INT,
    IN p_descripcion VARCHAR(100)
)
BEGIN
	UPDATE ubicaciones 
    SET 
    descripcion = p_descripcion
    WHERE id_ubicacion = p_id_ubicacion;
END $$
DELIMITER ;


-- Eliminar Ubicacion
DELIMITER $$
CREATE PROCEDURE EliminarUbicacion(
	IN p_id_ubicacion INT
)
BEGIN
	DELETE FROM ubicaciones
    WHERE id_ubicacion = p_id_ubicacion;
END $$
DELIMITER ;



-- Tabla productos
-- Registrar Producto
DELIMITER $$
CREATE PROCEDURE InsertarProducto(
	IN p_codigo VARCHAR(50),
    IN p_nombre VARCHAR(100),
    IN p_descripcion TEXT,
    IN p_precio DECIMAL(10,2),
    IN p_stock INT,
    IN p_ubicacion_id INT,
    OUT p_id_producto INT
)
BEGIN
	-- Verificación de duplicados por código 
    IF EXISTS (SELECT 1 FROM productos WHERE codigo = p_codigo) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Código de producto duplicado';
	ELSE
		INSERT INTO productos (codigo, nombre, descripcion, precio, stock, ubicacion_id)
        VALUES (p_codigo, p_nombre, p_descripcion, p_precio, p_stock, p_ubicacion_id);
        
        SET p_id_producto = LAST_INSERT_ID();
	END IF;
END $$
DELIMITER ;

-- DROP PROCEDURE ActualizarProducto;

-- Actualizar Producto
DELIMITER $$
CREATE PROCEDURE ActualizarProducto(
	IN p_id_producto INT,
    IN p_codigo VARCHAR(50),
    IN p_nombre VARCHAR(100),
    IN p_descripcion TEXT,
    IN p_precio DECIMAL(10,2),
    IN p_stock INT,
    IN p_ubicacion_id INT,
    IN p_usuario_id INT
)
BEGIN
	DECLARE stock_anterior INT;
    DECLARE tipo_transaccion INT;
    DECLARE stock_cambio INT;
    DECLARE v_transaccion_id INT; -- Variable para almacenar el ID de la transacción
    
    SELECT stock INTO stock_anterior FROM productos WHERE id_producto = p_id_producto;
    
    IF stock_anterior < p_stock THEN
		SET tipo_transaccion = 1;
        SET stock_cambio = p_stock - stock_anterior;
	ELSEIF stock_anterior > p_stock THEN
		SET tipo_transaccion = 2;
		SET stock_cambio = stock_anterior - p_stock;
	END IF;

	UPDATE productos 
    SET 
    codigo = p_codigo, 
    nombre = p_nombre, 
    descripcion = p_descripcion, 
    precio = p_precio, 
    stock = p_stock, 
    ubicacion_id = p_ubicacion_id
    WHERE id_producto = p_id_producto;
    
    IF stock_anterior <> p_stock THEN
		-- Registro de Transacción
        CALL InsertarTransaccion(p_id_producto, stock_cambio, tipo_transaccion, p_usuario_id, v_transaccion_id);
        
        -- Replicación de Registro para Reporteria y Replicación en MongoDB
        CALL InsertarTransaccionReportesHistoria(v_transaccion_id, p_id_producto, stock_cambio, tipo_transaccion, p_usuario_id);
	END IF;
    
END $$
DELIMITER ;

-- Insertar Transacción
DELIMITER $$

CREATE PROCEDURE InsertarTransaccion(
    IN p_id_producto INT,
    IN p_stock_cambio INT,
    IN p_tipo_transaccion INT,
    IN p_usuario_id INT,
    OUT p_transaccion_id INT
)
BEGIN
    INSERT INTO transacciones (producto_id, cambio_stock, tipo_id, usuario_id)
    VALUES (p_id_producto, p_stock_cambio, p_tipo_transaccion, p_usuario_id);
    
    SET p_transaccion_id = LAST_INSERT_ID();
END $$

DELIMITER ;


-- Insertar Transacción para Reporteria y Replicación en MongoDB
DELIMITER $$

CREATE PROCEDURE InsertarTransaccionReportesHistoria(
    IN p_id_transaccion INT,
    IN p_id_producto INT,
    IN p_stock_cambio INT,
    IN p_tipo_transaccion INT,
    IN p_usuario_id INT
)
BEGIN
    INSERT INTO transacciones_reportes_historia (id_transaccion, producto_id, cambio_stock, tipo_id, usuario_id, fecha)
    VALUES (p_id_transaccion, p_id_producto, p_stock_cambio, p_tipo_transaccion, p_usuario_id, CURDATE());
END $$

DELIMITER ;





-- Eliminar Producto
DELIMITER $$
CREATE PROCEDURE EliminarProducto(
	IN p_id_producto INT
)
BEGIN
	DELETE FROM productos
    WHERE id_producto = p_id_producto;
END $$
DELIMITER ;


-- Reportes
-- Reporte de Inventarios General
CREATE VIEW ReporteInventarioGeneral AS
SELECT 
	p.id_producto, p.codigo, p.nombre, p.stock, p.precio, (p.stock * p.precio) AS valor_total, u.descripcion AS ubicacion
FROM productos p
LEFT JOIN ubicaciones u ON p.ubicacion_id = u.id_ubicacion;


-- Reporte de Productos por Ubicacion(id)
DELIMITER $$
CREATE PROCEDURE ReporteProductosPorIdUbicacion (
	IN p_ubicacion_id INT
)
BEGIN
	SELECT u.id_ubicacion, u.descripcion AS ubicacion, GROUP_CONCAT(CONCAT(p.nombre, ' (', p.stock, ') ') SEPARATOR ', ') AS productos
    FROM productos p
    JOIN ubicaciones u ON p.ubicacion_id = u.id_ubicacion
    WHERE p.ubicacion_id = p_ubicacion_id
    GROUP BY p.ubicacion_id;
END $$
DELIMITER ;


-- Reporte de Productos por rango de precio
DELIMITER $$
CREATE PROCEDURE ReporteProductosPorRangoDePrecio (
	IN p_precio_min DECIMAL(10,2),
    IN p_precio_max DECIMAL(10,2)
)
BEGIN
	SELECT p.id_producto, p.codigo, p.nombre, p.stock, p.precio, (p.stock * p.precio) AS valor_total, u.descripcion AS ubicacion
    FROM productos p
    JOIN ubicaciones u ON p.ubicacion_id = u.id_ubicacion
    WHERE p.precio BETWEEN p_precio_min AND p_precio_max;
END $$
DELIMITER ;

-- Reporte de Productos con bajo stock
DELIMITER $$
CREATE PROCEDURE ReporteProductosBajoStock (
	IN p_nivel_stock INT
)
BEGIN
	SELECT p.id_producto, p.codigo, p.nombre, p.stock, p.precio, (p.stock * p.precio) AS valor_total, u.descripcion AS ubicacion
    FROM productos p
    JOIN ubicaciones u ON p.ubicacion_id = u.id_ubicacion
    WHERE p.stock <= p_nivel_stock;
END $$
DELIMITER ;

-- Reporte de Productos por rango de precio
DELIMITER $$
CREATE PROCEDURE ReporteProductosPorRangoDePrecio (
	IN p_precio_min DECIMAL(10,2),
    IN p_precio_max DECIMAL(10,2)
)
BEGIN
	SELECT p.id_producto, p.codigo, p.nombre, p.stock, p.precio, (p.stock * p.precio) AS valor_total, u.descripcion AS ubicacion
    FROM productos p
    JOIN ubicaciones u ON p.ubicacion_id = u.id_ubicacion
    WHERE p.precio BETWEEN p_precio_min AND p_precio_max;
END $$
DELIMITER ;

-- Reporte de Transacciones
DELIMITER $$
CREATE PROCEDURE ReporteTransacciones ()
BEGIN
	SELECT p.codigo, p.nombre, p.stock, t.cambio_stock, tt.nombre
    FROM transacciones t
    LEFT JOIN productos p ON p.id_producto = t.producto_id
    LEFT JOIN tipos_transaccion tt ON tt.id_tipo = t.tipo_id;
END $$
DELIMITER ;




-- Creación de Registros simulados
DELIMITER $$
CREATE PROCEDURE InsertarDatosSimulados ()
BEGIN
	DECLARE i INT DEFAULT 1;
    WHILE i <= 5 DO
		CALL InsertarUbicacion(CONCAT('Almacén ', i));
        SET i = i + 1;
	END WHILE;
    
    INSERT INTO roles (nombre) VALUES ('admin'), ('almacen'), ('vendedor');
    INSERT INTO tipos_transaccion(nombre) VALUES ('entrada'), ('salida');
    
    SET i = 1;
    WHILE i <= 500 DO
		CALL InsertarProducto(
			CONCAT('P-000', i),
            CONCAT('Producto ', i),
            CONCAT('Descripción ', i),
            ROUND(RAND() * 100, 2),
            FLOOR(RAND() * 100),
            FLOOR(1 + RAND() * 5)
		);
        SET i = i + 1;
	END WHILE;
END $$
DELIMITER ;ReporteTransacciones

-- CALL InsertarDatosSimulados();

-- Pruebas

CALL InsertarUsuario('Pablo Alfonso', 'Vargas Melgar', '20034951@galileo.edu', 'clavedb', 1);

SELECT * FROM ReporteInventarioGeneral;

CALL ReporteProductosPorIdUbicacion(1);
CALL ReporteProductosPorIdUbicacion(2);
CALL ReporteProductosPorIdUbicacion(3);
CALL ReporteProductosPorIdUbicacion(4);
CALL ReporteProductosPorIdUbicacion(5);

CALL ReporteProductosBajoStock(20);

CALL ReporteProductosPorRangoDePrecio(50.00, 100.00);



SELECT * FROM productos LIMIT 5;


CALL ActualizarProducto(1, 'P-0001', 'Producto 1', 'Descripción 1', 70.61, 22, 5, 1);
CALL ActualizarProducto(1, 'P-0001', 'Producto 1', 'Descripción 1', 70.61, 20, 5, 1);

CALL ActualizarProducto(2, 'P-0002', 'Producto 2', 'Descripción 2', 54.55, 30, 4, 1);
CALL ActualizarProducto(2, 'P-0002', 'Producto 2', 'Descripción 2', 54.55, 28, 4, 1);

CALL ActualizarProducto(3, 'P-0003', 'Producto 3', 'Descripción 3', 57.51, 80, 3, 1);
CALL ActualizarProducto(3, 'P-0003', 'Producto 3', 'Descripción 3', 57.51, 90, 3, 1);


CALL ReporteTransacciones();


SELECT * FROM transacciones;
SELECT * FROM transacciones_reportes_historia PARTITION(p2025) WHERE fecha = CURDATE();