import 'package:comet/core/recetas/domain/ingrdiente.entity.dart';

class IngredienteModel {
  final String nombre;
  final double cantidad; // Cambié de Float a double
  final String medida;

  IngredienteModel({
    required this.nombre,
    required this.cantidad,
    required this.medida,
  });

  // Recibe un objeto JSON desde la API y retorna una instancia de IngredienteModel
  factory IngredienteModel.fromJson(Map<String, dynamic> json) {
    return IngredienteModel(
      nombre: json["name"],
      cantidad: (json["quantity"] as num).toDouble(), // Convertimos a double
      medida: json["unit"],
    );
  }

  // Método estático para convertir un IngredienteEntity a IngredienteModel
  static IngredienteModel fromEntity(IngredienteEntity ingredienteEntity) {
    return IngredienteModel(
      nombre: ingredienteEntity.nombre,
      cantidad: ingredienteEntity.cantidad,
      medida: ingredienteEntity.medida,
    );
  }

  // Método para convertir un IngredienteModel a IngredienteEntity
  IngredienteEntity toEntity() {
    return IngredienteEntity(
      nombre: nombre,
      cantidad: cantidad,
      medida: medida,
    );
  }

  // Método para convertir un IngredienteModel a JSON
   Map<String, dynamic> toJson() {
    return {
      "name": nombre,
      "quantity": cantidad,
      "unit": medida,
    };
  }

  static IngredienteEntity fromJsonToIngredienteEntity(Map<String, dynamic> json) {
    return IngredienteEntity(
      nombre: json["name"],
      cantidad: (json["quantity"] as num).toDouble(), // Convertimos a double
      medida: json["unit"],
    );
  }
}
