
import 'package:comet/core/recetas/domain/receta.entity.dart';
import 'package:comet/core/recetas/domain/receta.repository.dart';
import 'package:comet/utils/Error/failure.dart';
import 'package:dartz/dartz.dart';

class EliminarRecetaUseCase {
   final RecetaRepository repository;

  EliminarRecetaUseCase({required this.repository});

  Future<Either<Failure, RecetaEntity>> call(String id) {
    return repository.eliminarReceta(id);
  }


}