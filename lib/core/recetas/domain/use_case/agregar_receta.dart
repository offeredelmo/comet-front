
import 'package:comet/core/recetas/domain/receta.entity.dart';
import 'package:comet/utils/Error/failure.dart';
import 'package:dartz/dartz.dart';

import '../receta.repository.dart';

class AgregarRecetaUseCase {
  final RecetaRepository repository;

  AgregarRecetaUseCase({required this.repository});

  Future<Either<Failure, RecetaEntity>> call(RecetaEntity recetaEntity) {
    return repository.agregarReceta(recetaEntity);
  }
}