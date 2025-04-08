// Importar módulos
const express = require("express");
const swaggerJSDoc = require('swagger-jsdoc');
const swaggerUi = require('swagger-ui-express');
const mysql = require("mysql2/promise");
const mongoose = require("mongoose");
require("dotenv").config();

// Modelos de MongoDB
const { Transaccion, Producto, Comentario } = require("./models/mongoModels");

// Configuración de MySQL
const pool = mysql.createPool({
  host: process.env.MYSQL_HOST,
  user: process.env.MYSQL_USER,
  password: process.env.MYSQL_PASSWORD,
  database: process.env.MYSQL_DATABASE,
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
});

// Conectar a MongoDB
mongoose.connect(process.env.MONGO_URI, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});

const app = express();
app.use(express.json());

const getRandomInt = (min, max) => {
  return Math.floor(Math.random() * (max - min + 1)) + min;
}

// Rutas CRUD para productos
app.post("/productos", async (req, res) => {
  try {
    // Crear registro de producto en MySQL
    const { codigo, nombre, descripcion, precio, stock, ubicacion_id } = req.body;
    
    // Crear el registro de producto y obtener id_producto
    const[rows] = await pool.query("CALL InsertarProducto(?, ?, ?, ?, ?, ?, @id_producto)", [codigo, nombre, descripcion, precio, stock, ubicacion_id]);
    const[[{id_producto}]] = await pool.query("SELECT @id_producto AS id_producto");
    
    const nuevoProducto = new Producto({ id_producto, codigo, nombre, descripcion, precio, stock, ubicacion_id });
    await nuevoProducto.save();

    res.status(201).json({ message: "Producto agregado" });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});
  
app.put("/productos/:id", async (req, res) => {
    try {
        const { id } = req.params;
        const { codigo, nombre, descripcion, precio, stock, ubicacion_id, usuario_id } = req.body;
        await pool.query("CALL ActualizarProducto(?, ?, ?, ?, ?, ?, ?, ?)", [id, codigo, nombre, descripcion, precio, stock, ubicacion_id, usuario_id]);

        //Temporal solo para proposito de demostración
        const id_transaccion = getRandomInt(1, 100);
        const nuevaTransaccion = new Transaccion({id_transaccion, producto_id : id, cambio_stock : stock, tipo : "entrada", usuario_id});
        await nuevaTransaccion.save();


        res.json({ message: "Producto actualizado" });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

app.delete("/productos/:id", async (req, res) => {
    try {
        const { id } = req.params;
        await pool.query("CALL EliminarProducto(?)", [id]);

        const productoEliminado = await Producto.findByIdAndDelete({id_producto : id});

        res.json({ message: "Producto eliminado" });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Rutas CRUD para ubicaciones
app.post("/ubicaciones", async (req, res) => {
    try {
        const { descripcion } = req.body;
        await pool.query("CALL InsertarUbicacion(?)", [descripcion]);
        res.status(201).json({ message: "Ubicación agregada" });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

app.put("/ubicaciones/:id", async (req, res) => {
    try {
        const { id } = req.params;
        const { descripcion } = req.body;
        await pool.query("CALL ActualizarUbicacion(?, ?)", [id, descripcion]);
        res.json({ message: "Ubicación actualizada" });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

app.delete("/ubicaciones/:id", async (req, res) => {
try {
    const { id } = req.params;
    await pool.query("CALL EliminarUbicacion(?)", [id]);
    res.json({ message: "Ubicación eliminada" });
} catch (error) {
    res.status(500).json({ error: error.message });
}
});

// Rutas para reportes
app.get("/reportes/inventario", async (req, res) => {
    try {
        const [reporte] = await pool.query("SELECT * FROM ReporteInventarioGeneral");
        res.json(reporte);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

app.get("/reportes/productos/ubicacion/:id", async (req, res) => {
    try {
        const { id } = req.params;
        const [reporte] = await pool.query("CALL ReporteProductosPorIdUbicacion(?)", [id]);
        res.json(reporte[0]);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

app.get("/reportes/productos/precio", async (req, res) => {
    try {
        const { min, max } = req.query;
        const [reporte] = await pool.query("CALL ReporteProductosPorRangoDePrecio(?, ?)", [min, max]);
        res.json(reporte[0]);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

app.get("/reportes/productos/bajo-stock", async (req, res) => {
    try {
        const { nivel } = req.query;
        const [reporte] = await pool.query("CALL ReporteProductosBajoStock(?)", [nivel]);
        res.json(reporte[0]);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

app.get("/reportes/transacciones", async (req, res) => {
    try {
        const [reporte] = await pool.query("CALL ReporteTransacciones()");
        res.json(reporte[0]);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
  
// Rutas CRUD para usuarios
app.get("/usuarios", async (req, res) => {
  try {
    const [usuarios] = await pool.query("CALL ObtenerUsuarios()");
    res.json(usuarios[0]);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.post("/usuarios", async (req, res) => {
  try {
    const { nombre, correo } = req.body;
    await pool.query("CALL InsertarUsuario(?, ?)", [nombre, correo]);
    res.status(201).json({ message: "Usuario agregado" });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});
  

// Consultas a MongoDB
// Obtener todas las transacciones
app.get("/transacciones", async (req, res) => {
  try {
    const transacciones = await Transaccion.find();
    res.json(transacciones);
  } catch (error) {
    res.status(500).json({ error: "Error al obtener transacciones" });
  }
});

// Obtener todas las transacciones de un producto específico
app.get("/transacciones/producto/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const transacciones = await Transaccion.find({ producto_id: id });
    res.json(transacciones);
  } catch (error) {
    res.status(500).json({ error: "Error al obtener transacciones del producto" });
  }
});


// Obtener todos los productos
/**
 * @swagger
 * /productos:
 *   get:
 *     description: Obtiene todos los productos
 *     responses:
 *       200:
 *         description: Lista de productos obtenida con éxito
 *       500:
 *         description: Error al obtener los productos
 */
app.get("/productos", async (req, res) => {
  try {
    const productos = await Producto.find();
    res.json(productos);
  } catch (error) {
    res.status(500).json({ error: "Error al obtener productos" });
  }
});

// Obtener un producto por ID
app.get("/productos/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const producto = await Producto.findOne({ id_producto: id });
    if (!producto) {
      return res.status(404).json({ error: "Producto no encontrado" });
    }
    res.json(producto);
  } catch (error) {
    res.status(500).json({ error: "Error al obtener el producto" });
  }
});

app.post("/comentarios", async (req, res) => {
  try {
      const { producto_id, usuario_id, comentario } = req.body;
      const nuevoComentario = new Comentario({ producto_id, usuario_id, comentario });
      await nuevoComentario.save();
      res.status(201).json(nuevoComentario);
  } catch (error) {
      res.status(500).json({ error: error.message });
  }
  });

// Obtener comentarios de un producto específico
app.get("/comentarios/producto/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const comentarios = await Comentario.find({ producto_id: id });
    res.json(comentarios);
  } catch (error) {
    res.status(500).json({ error: "Error al obtener comentarios" });
  }
});

// Obtener todos los comentarios
app.get("/comentarios", async (req, res) => {
  try {
    const comentarios = await Comentario.find();
    res.json(comentarios);
  } catch (error) {
    res.status(500).json({ error: "Error al obtener comentarios" });
  }
});


// Configuración de Swagger
const swaggerDefinition = {
  openapi: '3.0.0',
  info: {
    title: 'Proyecto Final DB 3',
    version: '1.0.0',
    description: 'Documentación API',
  },
  servers: [
    {
      url: 'http://localhost:3000', // URL de tu API
    },
  ],
};

const options = {
  swaggerDefinition,
  apis: ['./index.js'], // Ruta a tus archivos de rutas (puede ser un patrón como ./routes/*.js)
};

const swaggerSpec = swaggerJSDoc(options);

// Configura Swagger UI para servir la documentación en una ruta
app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerSpec));



// Iniciar servidor
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Servidor corriendo en http://localhost:${PORT}`);
});

// Instrucciones para instalar dependencias e iniciar la API
/*
INSTRUCCIONES:

1. Iniciar el servidor:
   node index.js

2. Probar las rutas:
   Ejemplo
   GET http://localhost:3000/productos
   POST http://localhost:3000/transaccion (enviar JSON con producto_id, usuario_id, tipo, cantidad)
*/
