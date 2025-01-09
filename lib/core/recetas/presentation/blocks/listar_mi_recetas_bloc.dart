import 'package:bloc/bloc.dart';
import 'package:comet/core/recetas/domain/receta.entity.dart';
import 'package:comet/core/recetas/domain/use_case/listar_mis_recetas.dart';
import 'package:meta/meta.dart';

class ListarMiRecetasBloc
    extends Bloc<ListarMiRecetasEvent, ListarMiRecetasState> {
  final ListarMisRecetasUseCase listarMisRecetasUseCase;
  ListarMiRecetasBloc(this.listarMisRecetasUseCase)
      : super(ListarMiRecetasInitial()) {
    on<ListarMiRecetasEvent>((event, emit) async {
      final resp = await listarMisRecetasUseCase(
          event.userId, event.pagina, event.cantidadPorPaguina);
      resp.fold((l) => emit(ListarMiRecetasError()),
          (r) => emit(ListarMiRecetasSucces(recetas: r)));
    });
  }
}

class ListarMiRecetasEvent {
  final String userId;
  final int pagina;
  final int cantidadPorPaguina;

  ListarMiRecetasEvent(
      {required this.userId,
      required this.pagina,
      required this.cantidadPorPaguina});
}

@immutable
sealed class ListarMiRecetasState {}

final class ListarMiRecetasInitial extends ListarMiRecetasState {}

final class ListarMiRecetasLoading extends ListarMiRecetasState {}

final class ListarMiRecetasError extends ListarMiRecetasState {}

final class ListarMiRecetasSucces extends ListarMiRecetasState {
  final List<RecetaEntity> recetas;

  ListarMiRecetasSucces({required this.recetas});
}
