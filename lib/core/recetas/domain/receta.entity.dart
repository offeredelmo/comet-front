import 'dart:io';

import 'package:comet/core/recetas/data/model/receta_model.dart';
import 'package:comet/core/recetas/domain/ingrdiente.entity.dart';

class RecetaEntity {
  final String? id;
  final String title;
  final String? imgUrl;
  final File? imgfile;
  final List<String> preparation;
  final List<IngredienteEntity> ingredients;
  final String? urlYoutube;
  final String userId;
  final List<String> tags;

  RecetaEntity(
      {
         this.id,
      required this.title,
       this.imgUrl,
       this.imgfile,
      required this.preparation,
      required this.ingredients,
      this.urlYoutube,
      required this.userId,
      required this.tags});

}
