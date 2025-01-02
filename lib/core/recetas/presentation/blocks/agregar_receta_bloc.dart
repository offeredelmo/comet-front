import 'package:bloc/bloc.dart';
import 'package:comet/core/recetas/domain/receta.entity.dart';
import 'package:comet/core/recetas/domain/use_case/agregar_receta.dart';
import 'package:meta/meta.dart';

class AgregarRecetaBloc extends Bloc<AgregarRecetaEvent, AgregarRecetaState> {
  final AgregarRecetaUseCase agregarRecetaUseCase;
  AgregarRecetaBloc(this.agregarRecetaUseCase) : super(AgregarRecetaInitial()) {
    on<AgregarRecetaEvent>((event, emit) async {
      emit(AgregarRecetaLoading());
      final resp = await agregarRecetaUseCase(event.recetaEntity);
      resp.fold(
        (l) => emit(AgregarRecetaError()),
        (r) => emit(AgregarRecetaSucces()));
    });
  }
}

class AgregarRecetaEvent {
  final RecetaEntity recetaEntity;

  AgregarRecetaEvent({required this.recetaEntity});
}

//state
@immutable
sealed class AgregarRecetaState {}

final class AgregarRecetaInitial extends AgregarRecetaState {}

final class AgregarRecetaLoading extends AgregarRecetaState {}

final class AgregarRecetaError extends AgregarRecetaState {}

final class AgregarRecetaSucces extends AgregarRecetaState {}
