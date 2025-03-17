SHOW DATABASES;

-- Creación de Base de Datos
CREATE DATABASE IF NOT EXISTS InventarioDB;
USE InventarioDB;

-- Creación de Tablas
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

-- Creación de Store Procedures

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
    IN p_ubicacion_id INT
)
BEGIN
	-- Verificación de duplicados por código 
    IF EXISTS (SELECT 1 FROM productos WHERE codigo = p_codigo) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Código de producto duplicado';
	ELSE
		INSERT INTO productos (codigo, nombre, descripcion, precio, stock, ubicacion_id)
        VALUES (p_codigo, p_nombre, p_descripcion, p_precio, p_stock, p_ubicacion_id);
	END IF;
END $$
DELIMITER ;

-- Actualizar Producto
DELIMITER $$
CREATE PROCEDURE ActualizarProducto(
	IN p_id_producto INT,
    IN p_codigo VARCHAR(50),
    IN p_nombre VARCHAR(100),
    IN p_descripcion TEXT,
    IN p_precio DECIMAL(10,2),
    IN p_stock INT,
    IN p_ubicacion_id INT
)
BEGIN
	UPDATE productos 
    SET 
    codigo = p_codigo, 
    nombre = p_nombre, 
    descripcion = p_descripcion, 
    precio = p_precio, 
    stock = p_stock, 
    ubicacion_id = p_ubicacion_id
    WHERE id_producto = p_id_producto;
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


-- Creación de Registros simulador
DELIMITER $$
CREATE PROCEDURE InsertarDatosSimulados ()
BEGIN
	DECLARE i INT DEFAULT 1;
    WHILE i <= 5 DO
		CALL InsertarUbicacion(CONCAT('Almacén ', i));
        SET i = i + 1;
	END WHILE;
    
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
DELIMITER ;

-- CALL InsertarDatosSimulados();

-- Pruebas
SELECT * FROM ReporteInventarioGeneral;

CALL ReporteProductosPorIdUbicacion(1);
CALL ReporteProductosPorIdUbicacion(2);
CALL ReporteProductosPorIdUbicacion(3);
CALL ReporteProductosPorIdUbicacion(4);
CALL ReporteProductosPorIdUbicacion(5);

CALL ReporteProductosBajoStock(20);

CALL ReporteProductosPorRangoDePrecio(50.00, 100.00);