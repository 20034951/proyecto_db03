// Importar módulos
const express = require("express");
const mysql = require("mysql2/promise");
const mongoose = require("mongoose");
require("dotenv").config();

// Modelos de MongoDB
const { Transaccion, HistorialProducto, Comentario } = require("./models/mongoModels");

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

// Rutas CRUD para productos
app.post("/productos", async (req, res) => {
    try {
      const { codigo, nombre, descripcion, precio, stock, ubicacion_id } = req.body;
      await pool.query("CALL InsertarProducto(?, ?, ?, ?, ?, ?)", [codigo, nombre, descripcion, precio, stock, ubicacion_id]);
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
        res.json({ message: "Producto actualizado" });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

app.delete("/productos/:id", async (req, res) => {
    try {
        const { id } = req.params;
        await pool.query("CALL EliminarProducto(?)", [id]);
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

/*
  
  app.post("/productos", async (req, res) => {
    try {
      const { nombre, descripcion, precio, stock } = req.body;
      await pool.query("CALL InsertarProducto(?, ?, ?, ?)", [nombre, descripcion, precio, stock]);
      res.status(201).json({ message: "Producto agregado" });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  });
  
  app.put("/productos/:id", async (req, res) => {
    try {
      const { id } = req.params;
      const { nombre, descripcion, precio, stock } = req.body;
      await pool.query("CALL ActualizarProducto(?, ?, ?, ?, ?)", [id, nombre, descripcion, precio, stock]);
      res.json({ message: "Producto actualizado" });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  });
  
  app.delete("/productos/:id", async (req, res) => {
    try {
      const { id } = req.params;
      await pool.query("CALL EliminarProducto(?)", [id]);
      res.json({ message: "Producto eliminado" });
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
  */
  
// Rutas para transacciones (Historial en MongoDB)
app.post("/transaccion", async (req, res) => {
try {
    const { producto_id, usuario_id, tipo, cantidad } = req.body;
    const nuevaTransaccion = new Transaccion({ producto_id, usuario_id, tipo, cantidad });
    await nuevaTransaccion.save();
    res.status(201).json(nuevaTransaccion);
} catch (error) {
    res.status(500).json({ error: error.message });
}
});
  

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
   GET http://localhost:3000/productos
   POST http://localhost:3000/transaccion (enviar JSON con producto_id, usuario_id, tipo, cantidad)
*/
