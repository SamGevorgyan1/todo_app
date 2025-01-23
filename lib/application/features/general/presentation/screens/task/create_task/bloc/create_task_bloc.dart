import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/application/features/general/domain/model/task.dart';
import 'package:todo_app/application/features/general/domain/usecase/create_task.dart';

part 'create_task_event.dart';

part 'create_task_state.dart';

class CreateTaskBloc extends Bloc<CreateTaskEvent, CreateTaskState> {
  final CreateTaskUseCase _createTaskUseCase;

  CreateTaskBloc(this._createTaskUseCase) : super(CreateTaskState.initial()) {
    on<_CreateEvent>(_onCreateEvent);
  }

  FutureOr<void> _onCreateEvent(_CreateEvent event, Emitter<CreateTaskState> emit) async {
    emit(state._loading());

    var title = state.title;
    var description = state.description;

    var task = Task(title: title, description: description, isActive: true);

    try {
      var dataState = await _createTaskUseCase(params: task);
      dataState.when(
        success: (_) => emit(state._created()),
        failure: (error) => emit(state._error(error)),
      );
    } catch (e) {
      emit(state._error(e));
    }
  }
}
