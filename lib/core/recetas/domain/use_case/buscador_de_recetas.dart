

import 'package:comet/core/recetas/domain/receta.entity.dart';
import 'package:comet/core/recetas/domain/receta.repository.dart';
import 'package:comet/utils/Error/failure.dart';
import 'package:dartz/dartz.dart';

class BuscadorDeRecetasUseCase {
  final RecetaRepository repository;

  BuscadorDeRecetasUseCase({required this.repository});

  Future<Either<Failure, List<RecetaEntity>>> call(String texto) {
    return repository.buscadorDeRecetas(texto);
  }
  
}