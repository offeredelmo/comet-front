import 'dart:convert';

import 'package:comet/core/recetas/data/model/receta_model.dart';
import 'package:comet/utils/Error/failure.dart';
import 'package:dio/dio.dart';

import '../../domain/receta.entity.dart';

abstract class RecetasRemoteDataSource {
  Future<RecetaEntity> agregarReceta(RecetaEntity recetaEntity);
  Future<RecetaEntity> modificarReceta(RecetaEntity recetaEntity);
  Future<RecetaEntity> eliminarReceta(String id);
  Future<List<RecetaEntity>> listarRecetasAleatorias(
      List<RecetaEntity> recetas);
  Future<List<RecetaEntity>> listarRecetasPorTags(List<RecetaEntity> recetas);
  Future<List<RecetaEntity>> buscadorDeRecetas(String texto);
  Future<List<RecetaEntity>> listarMisRecetas(
      String userId, int pagina, int cantidadPorPaguina);
}

class RecetasDataSourceImpl implements RecetasRemoteDataSource {
  var dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 40),
      receiveTimeout: const Duration(seconds: 40),
      sendTimeout: const Duration(seconds: 40),
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  @override
  Future<RecetaEntity> agregarReceta(RecetaEntity recetaEntity) async {
    try {
      print("entro al datasource");
      const headers = {'Content-Type': 'application/json'};
      final data = RecetaModel.fromEntity(recetaEntity).aJsonCrearReceta();
      
      print(json.encode(data));

      var response = await dio.request(
        'http://10.0.2.2:8080/api/v1/recipe/add',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: json.encode(data),
      );
      if (response.statusCode == 201) {
        if (recetaEntity.imgfile != null) {
          final data = FormData.fromMap({
            "file": await MultipartFile.fromFile(
              recetaEntity.imgfile?.path ??
                  "", //verificar si esto puede ocacionar un error
              filename: recetaEntity.imgfile?.path.split('/').last,
            ),
            "_id": "${(response.data["_id"])}"
          });
          var responseurlImg = await dio.request(
            'http://10.0.2.2:8080/api/v1/recipe/add-photo',
            options: Options(
              method: 'POST',
            ),
            data: data,
          );
          if (response.statusCode == 201) {
            return recetaEntity;
          } else {
            throw ServerFailure(response.statusMessage);
          }
        }
        return recetaEntity;
      } else {
        throw ServerFailure(response.statusMessage);
      }
    } on DioException catch (dioError) {
      final failure = handleDioError(dioError);
      throw failure; // relanzar
    } catch (e) {
      print("error: ${e}");
      throw ServerFailure();
    }
  }

  @override
  Future<List<RecetaEntity>> buscadorDeRecetas(String texto) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var data = json.encode({"text": "${texto}"});
      var response = await dio.request(
        'http://10.0.2.2:8080/api/v1/recipe/search',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
        data: data,
      );
      if (response.statusCode == 200) {
        final recetas = (response.data as List<dynamic>)
            .map((receta) => RecetaModel.fromJsontoRecetaEntity(
                receta as Map<String, dynamic>))
            .toList();
        return recetas;
      } else {
        print(response.statusMessage);
        throw ServerFailure();
      }
    } on DioException catch (dioError) {
      final failure = handleDioError(dioError);
      throw failure; // relanzar
    } catch (e) {
      print("error: ${e}");
      throw ServerFailure();
    }
  }

  @override
  Future<RecetaEntity> eliminarReceta(String id) {
    // TODO: implement eliminarReceta
    throw UnimplementedError();
  }

  @override
  Future<List<RecetaEntity>> listarRecetasAleatorias(
      List<RecetaEntity> recetas) {
    // TODO: implement listarRecetasAleatorias
    throw UnimplementedError();
  }

  @override
  Future<List<RecetaEntity>> listarRecetasPorTags(List<RecetaEntity> recetas) {
    // TODO: implement listarRecetasPorTags
    throw UnimplementedError();
  }

  @override
  Future<RecetaEntity> modificarReceta(RecetaEntity recetaEntity) {
    // TODO: implement modificarReceta
    throw UnimplementedError();
  }

  @override
  Future<List<RecetaEntity>> listarMisRecetas(
      String userId, int pagina, int cantidadPorPaguina) async {
    try {
      var response = await dio.request(
        'http://10.0.2.2:8080/api/v1/recipe/my-recipes/675e0640d6b7a3ae20ccfcc3/1/20',
        options: Options(
          method: 'GET',
        ),
      );
      if (response.statusCode == 200) {
        print(json.encode(response.data));
        final recetas = (response.data as List<dynamic>)
            .map((receta) => RecetaModel.fromJsontoRecetaEntity(
                receta as Map<String, dynamic>))
            .toList();
        return recetas;
      } else {
        print(response.statusMessage);
        throw ServerFailure();
      }
    } on DioException catch (dioError) {
      final failure = handleDioError(dioError);
      throw failure; // relanzar
    } catch (e) {
      print("error: ${e}");
      throw ServerFailure();
    }
  }

  //manejo de errores dio

  ServerFailure handleDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        print("Error de connectionTimeout: ${dioError.message}");
        return ServerFailure("Error de connectionTimeout: ${dioError.message}");
      case DioExceptionType.sendTimeout:
        print("Error de sendTimeout: ${dioError.message}");
        return ServerFailure("Error de sendTimeout: ${dioError.message}");

      case DioExceptionType.receiveTimeout:
        print("Error de receiveTimeout: ${dioError.message}");
        return ServerFailure("Error de receiveTimeout: ${dioError.message}");

      case DioExceptionType.badCertificate:
        print("Error de badCertificate: ${dioError.message}");
        return ServerFailure("Error de badCertificate: ${dioError.message}");

      case DioExceptionType.badResponse:
        print("Error de badResponse: ${dioError.message}");
        return ServerFailure("Error de badResponse: ${dioError.message}");

      case DioExceptionType.cancel:
        print("Error de cancel: ${dioError.message}");
        return ServerFailure("Error de cancel: ${dioError.message}");

      case DioExceptionType.connectionError:
        print("Error de connectionError: ${dioError.message}");
        return ServerFailure("Error de connectionError: ${dioError.message}");

      case DioExceptionType.unknown:
        print("Error de unknown: ${dioError.message}");
        return ServerFailure("Error de unknown: ${dioError.message}");
    }
  }
}
