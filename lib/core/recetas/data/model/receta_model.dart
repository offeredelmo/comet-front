import 'dart:ffi';

import 'package:comet/core/recetas/data/model/ingrediente_model.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/receta.entity.dart';

class RecetaModel {
  final String? id;
  final String title;
  final String? imgUrl;
  final String? keyImgUrl;
  final List<String> preparation;
  final List<IngredienteModel> ingredients;
  final int timePreparationInMinutes;
  final int? ingredientsQuantity;
  final String? urlYoutube;
  final String userId;
  final List<String> tags;
  final ImagePicker? img;

  RecetaModel(
      {this.id,
      required this.title,
      this.imgUrl,
      this.keyImgUrl,
      required this.preparation,
      required this.ingredients,
      this.ingredientsQuantity,
      required this.timePreparationInMinutes,
      this.urlYoutube,
      required this.userId,
      required this.tags,
      this.img});

  // Recibe un objeto JSON desde la API y retorna una instancia de RecetaModel
  factory RecetaModel.fromJson(Map<String, dynamic> json) {
    print(json["ingredients_quantity"]);
    print(int.parse(json["ingredients_quantity"]));

    return RecetaModel(
      id: json["_id"],
      title: json["title"],
      imgUrl: json.containsKey("img_url") ? json["img_url"] : null,
      keyImgUrl: json.containsKey("key_img_url") ? json["key_img_url"] : null,
      preparation: List<String>.from(json["preparation"]),
      ingredients: (json["ingredients"] as List)
          .map((e) => IngredienteModel.fromJson(e))
          .toList(),
      timePreparationInMinutes: json["time_preparation_in_minutes"],
      ingredientsQuantity: json.containsKey("ingredients_quantity")
          ? json["ingredients_quantity"]
          : null,
      urlYoutube: json.containsKey("key_img_url") ? json["key_img_url"] : null,
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
      timePreparationInMinutes: entity.timePreparationInMinutes,
      ingredientsQuantity: entity.ingredientsQuantity,
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
      "time_preparation_in_minutes": timePreparationInMinutes,
      "url_youtube": urlYoutube,
      "user_id": userId,
      "tags": tags,
    };
  }

  static RecetaEntity fromJsontoRecetaEntity(Map<String, dynamic> json) {
    print(json["ingredients_quantity"]);
    return RecetaEntity(
      id: json["_id"],
      title: json["title"],
      imgUrl: json.containsKey("img_url") ? json["img_url"] : null,
      keyImgUrl: json.containsKey("key_img_url") ? json["key_img_url"] : null,
      preparation: List<String>.from(json["preparation"]),
      ingredients: (json["ingredients"] as List)
          .map((e) => IngredienteModel.fromJsonToIngredienteEntity(e))
          .toList(),
      timePreparationInMinutes: json["time_preparation_in_minutes"],
      ingredientsQuantity: json["ingredients_quantity"],
      urlYoutube: json.containsKey("key_img_url") ? json["key_img_url"] : null,
      userId: json["user_id"],
      tags: List<String>.from(json["tags"]),
    );
  }
}
