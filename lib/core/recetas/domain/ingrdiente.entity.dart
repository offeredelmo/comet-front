import 'dart:ffi';

class IngredientEntity {
  final String nombre;
  final Float cantidad;
  final String medida;

  IngredientEntity(
      {required this.nombre, required this.cantidad, required this.medida});
}
