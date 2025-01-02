import 'package:bloc/bloc.dart';
import 'package:comet/core/recetas/domain/receta.entity.dart';
import 'package:comet/core/recetas/domain/use_case/buscador_de_recetas.dart';
import 'package:meta/meta.dart';

class BuscadorRecetaBloc extends Bloc<BuscarRecetaEvent, BuscadorState> {
  final BuscadorDeRecetasUseCase buscadorDeRecetasUseCase;
  BuscadorRecetaBloc(this.buscadorDeRecetasUseCase) : super(BuscadorInitial()) {
    on<BuscarRecetaEvent>((event, emit) async {
      emit(BuscadorLoading());
      final resp = await buscadorDeRecetasUseCase(event.text);
      resp.fold((l) => emit(BuscadorError()),
          (r) => emit(BuscadorSucces(listRecetaEntity: r)));
    });
  }
}

class BuscarRecetaEvent {
  final String text;

  BuscarRecetaEvent({required this.text});
}

@immutable
sealed class BuscadorState {}

final class BuscadorInitial extends BuscadorState {}

final class BuscadorLoading extends BuscadorState {}

final class BuscadorError extends BuscadorState {}

final class BuscadorSucces extends BuscadorState {
  final List<RecetaEntity> listRecetaEntity;

  BuscadorSucces({required this.listRecetaEntity});
}
