const mongoose = require("mongoose");

const transaccionSchema = new mongoose.Schema({
  producto_id: { type: Number, required: true }, // Referencia al ID de MySQL
  usuario_id: { type: Number, required: true }, // ID del usuario en MySQL
  tipo: { type: String, enum: ["entrada", "salida"], required: true },
  cantidad: { type: Number, required: true },
  fecha: { type: Date, default: Date.now },
});

const historialProductoSchema = new mongoose.Schema({
  producto_id: { type: Number, required: true },
  usuario_id: { type: Number, required: true },
  cambios: { type: String, required: true }, // Resumen de cambios
  fecha: { type: Date, default: Date.now },
});

const comentarioSchema = new mongoose.Schema({
  producto_id: { type: Number, required: true },
  usuario_id: { type: Number, required: true },
  comentario: { type: String, required: true },
  fecha: { type: Date, default: Date.now },
});

const Transaccion = mongoose.model("Transaccion", transaccionSchema);
const HistorialProducto = mongoose.model("HistorialProducto", historialProductoSchema);
const Comentario = mongoose.model("Comentario", comentarioSchema);

module.exports = { Transaccion, HistorialProducto, Comentario };
