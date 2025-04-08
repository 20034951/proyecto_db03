const mongoose = require("mongoose");

const transaccionSchema = new mongoose.Schema({
  id_transaccion: { type: Number, required: true }, // Referencia al ID de la transacción de MySQL
  producto_id: { type: Number, required: true }, // Referencia al ID del producto de MySQL
  cambio_stock: { type: Number, required: true },
  tipo: { type: String, enum: ["entrada", "salida"], required: true },
  usuario_id: { type: Number, required: true }, // Referencia al ID del usuario en MySQL
  fecha: { type: Date, default: Date.now }, // Fecha de registro
});

const productoSchema = new mongoose.Schema({
  id_producto: { type: Number, required: true },
  codigo: { type: String, required: true },
  nombre: { type: String, required: true },
  descripcion: { type: String, required: true },
  precio: { type: Number, required: true },
  stock: { type: Number, required: true },
  ubicacion_id: { type: Number, required: true }
});

const comentarioSchema = new mongoose.Schema({
  producto_id: { type: Number, required: true },
  usuario_id: { type: Number, required: true },
  comentario: { type: String, required: true },
  fecha: { type: Date, default: Date.now },
});

const Transaccion = mongoose.model("Transaccion", transaccionSchema);
const Producto = mongoose.model("Producto", productoSchema);
const Comentario = mongoose.model("Comentario", comentarioSchema);

module.exports = { Transaccion, Producto, Comentario };
