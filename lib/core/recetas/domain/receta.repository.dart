import 'package:dartz/dartz.dart'; // Importación de Dartz
import 'package:comet/core/recetas/domain/receta.entity.dart';

import '../../../utils/Error/failure.dart';


abstract class RecetaRepository {
  Future<Either<Failure, RecetaEntity>> agregarReceta(RecetaEntity recetaEntity);
  Future<Either<Failure, RecetaEntity>> modificarReceta(RecetaEntity recetaEntity);
  Future<Either<Failure, RecetaEntity>> eliminarReceta(String id);
  Future<Either<Failure, List<RecetaEntity>>> listarRecetasAleatorias(List<RecetaEntity> recetas);
  Future<Either<Failure, List<RecetaEntity>>> listarRecetasPorTags(List<RecetaEntity> recetas);
  Future<Either<Failure, List<RecetaEntity>>> listarMisRecetas(String userId, int pagina, int cantidadPorPaguina);
  Future<Either<Failure, List<RecetaEntity>>> buscadorDeRecetas(String texto);
}
