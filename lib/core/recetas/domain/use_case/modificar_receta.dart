
import 'package:comet/core/recetas/domain/receta.entity.dart';
import 'package:comet/core/recetas/domain/receta.repository.dart';
import 'package:comet/utils/Error/failure.dart';
import 'package:dartz/dartz.dart';

class ModificarRecetaUseCase {
  final RecetaRepository repository;

  ModificarRecetaUseCase({required this.repository});
  
  Future<Either<Failure, RecetaEntity>> call(RecetaEntity recetaEntity) {
    return repository.modificarReceta(recetaEntity);
  }
}