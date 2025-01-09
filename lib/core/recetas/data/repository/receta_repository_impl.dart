import 'package:comet/core/recetas/data/data_sorce/recetas_data_source.dart';
import 'package:comet/core/recetas/domain/receta.entity.dart';
import 'package:comet/core/recetas/domain/receta.repository.dart';
import 'package:comet/utils/Error/failure.dart';
import 'package:dartz/dartz.dart';

class RecetaRepositoryImpl implements RecetaRepository {
  final RecetasRemoteDataSource recetasRemoteDataSource;

  RecetaRepositoryImpl({required this.recetasRemoteDataSource});

  @override
  Future<Either<Failure, RecetaEntity>> agregarReceta(
      RecetaEntity recetaEntity) async {
    try {
      final resp = await recetasRemoteDataSource.agregarReceta(recetaEntity);
      return right(resp);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<RecetaEntity>>> buscadorDeRecetas(String texto) async{
try {
    final resp = await recetasRemoteDataSource.buscadorDeRecetas(texto);
    return Right(resp);
} catch (e) {
  return Left(ServerFailure());
}
  }

  @override
  Future<Either<Failure, List<RecetaEntity>>> listarMisRecetas(String userId, int pagina, int cantidadPorPaguina) async{
   try {
     final resp = await recetasRemoteDataSource.listarMisRecetas(userId, pagina, cantidadPorPaguina);
     return Right(resp);
   } catch (e) {
     return Left(ServerFailure());
   }
  }

  @override
  Future<Either<Failure, RecetaEntity>> eliminarReceta(String id) {
    // TODO: implement eliminarReceta
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<RecetaEntity>>> listarRecetasAleatorias(
      List<RecetaEntity> recetas) {
    // TODO: implement listarRecetasAleatorias
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<RecetaEntity>>> listarRecetasPorTags(
      List<RecetaEntity> recetas) {
    // TODO: implement listarRecetasPorTags
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, RecetaEntity>> modificarReceta(
      RecetaEntity recetaEntity) {
    // TODO: implement modificarReceta
    throw UnimplementedError();
  }
  
  
}
