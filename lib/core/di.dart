
import 'package:comet/core/recetas/data/data_sorce/recetas_data_source.dart';
import 'package:comet/core/recetas/data/repository/receta_repository_impl.dart';
import 'package:comet/core/recetas/domain/receta.repository.dart';
import 'package:comet/core/recetas/domain/use_case/agregar_receta.dart';
import 'package:comet/core/recetas/domain/use_case/buscador_de_recetas.dart';
import 'package:comet/core/recetas/domain/use_case/modificar_receta.dart';
import 'package:comet/core/recetas/presentation/blocks/agregar_receta_bloc.dart';
import 'package:comet/core/recetas/presentation/blocks/buscador_receta_bloc.dart';
import 'package:get_it/get_it.dart';

final di = GetIt.instance;

Future<void> init() async {

  //Bloc
  di.registerFactory(() => AgregarRecetaBloc(di()));
  di.registerFactory(() => BuscadorRecetaBloc(di()));


  //useCase
  di.registerLazySingleton(() => AgregarRecetaUseCase(repository: di()));
  di.registerLazySingleton(() => ModificarRecetaUseCase(repository: di()));
  di.registerLazySingleton(() => BuscadorDeRecetasUseCase(repository: di()));

  //repository
  di.registerLazySingleton<RecetaRepository>(() => RecetaRepositoryImpl(recetasRemoteDataSource: di()));

  //datasorce
  di.registerLazySingleton<RecetasRemoteDataSource>( () => RecetasDataSourceImpl());


}