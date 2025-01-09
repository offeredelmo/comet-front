
import 'package:dartz/dartz.dart';

import '../../../../utils/Error/failure.dart';
import '../receta.entity.dart';
import '../receta.repository.dart';

class ListarMisRecetasUseCase {
  final RecetaRepository repository;

  ListarMisRecetasUseCase({required this.repository});

  Future<Either<Failure, List<RecetaEntity>>> call (String userId, int pagina, int cantidadPorPaguina) {
    return repository.listarMisRecetas(userId, pagina, cantidadPorPaguina);
  }
  
}