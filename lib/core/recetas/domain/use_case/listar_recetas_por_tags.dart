

import 'package:comet/core/recetas/domain/receta.entity.dart';
import 'package:comet/core/recetas/domain/receta.repository.dart';
import 'package:comet/utils/Error/failure.dart';
import 'package:dartz/dartz.dart';

class ListarRecetasPorTagUseCase {
  final RecetaRepository repository;

  ListarRecetasPorTagUseCase({required this.repository});

  Future<Either<Failure,List<RecetaEntity>>> call (List<RecetaEntity> recetas) {
    return repository.listarRecetasPorTags(recetas);
  }
}