import 'package:comet/core/recetas/data/model/ingrediente_model.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/receta.entity.dart';

class RecetaModel {
  final String? id;
  final String title;
  final String? imgUrl; // Cambié el nombre para seguir convención camelCase
  final List<String> preparation;
  final List<IngredienteModel> ingredients; // Corregí el typo aquí
  final String? urlYoutube; // Cambié para seguir convención camelCase
  final String userId; // Cambié para seguir convención camelCase
  final List<String> tags;
  final ImagePicker? img;

  RecetaModel(
      {this.id,
      required this.title,
      this.imgUrl,
      required this.preparation,
      required this.ingredients,
      this.urlYoutube,
      required this.userId,
      required this.tags,
      this.img});

  // Recibe un objeto JSON desde la API y retorna una instancia de RecetaModel
  factory RecetaModel.fromJson(Map<String, dynamic> json) {
    return RecetaModel(
      id: json["_id"],
      title: json["title"],
      imgUrl: json["img_url"],
      preparation: List<String>.from(json["preparation"]),
      ingredients: (json["ingredients"] as List)
          .map((e) => IngredienteModel.fromJson(e))
          .toList(),
      urlYoutube: json["url_youtube"],
      userId: json["user_id"],
      tags: List<String>.from(json["tags"]),
    );
  }

  // Convierte una instancia de RecetaEntity en RecetaModel
  factory RecetaModel.fromEntity(RecetaEntity entity) {
    return RecetaModel(
      id: entity.id,
      title: entity.title,
      imgUrl: entity.imgUrl,
      preparation: entity.preparation,
      ingredients: entity.ingredients
          .map((e) => IngredienteModel.fromEntity(e))
          .toList(),
      urlYoutube: entity.urlYoutube,
      userId: entity.userId,
      tags: entity.tags,
    );
  }

  // Convierte una instancia de RecetaModel a un objeto JSON
  Map<String, dynamic> aJsonCrearReceta() {
    return {
      "title": title,
      "preparation": preparation,
      "ingredients": ingredients.map((e) => e.toJson()).toList(),
      "url_youtube": urlYoutube,
      "user_id": userId,
      "tags": tags,
    };
  }

  static RecetaEntity fromJsontoRecetaEntity(Map<String, dynamic> json) {
    return RecetaEntity(
      id: json["_id"],
      title: json["title"],
      imgUrl: json["img_url"],
      preparation: List<String>.from(json["preparation"]),
      ingredients: (json["ingredients"] as List)
          .map((e) => IngredienteModel.fromJsonToIngredienteEntity(e))
          .toList(),
      userId: json["user_id"],
      tags: List<String>.from(json["tags"]),
    );
  }
}
