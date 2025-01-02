import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


class EditarRecetaBloc extends Bloc<EditarRecetaEvent, EditarRecetaState> {
  EditarRecetaBloc() : super(EditarRecetaInitial()) {
    on<EditarRecetaEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

//event
@immutable
sealed class EditarRecetaEvent {}

//state
@immutable
sealed class EditarRecetaState {}

final class EditarRecetaInitial extends EditarRecetaState {}
