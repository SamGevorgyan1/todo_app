import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/application/features/general/domain/model/task.dart';
import 'package:todo_app/application/features/general/domain/usecase/delete_task.dart';
import 'package:todo_app/application/features/general/domain/usecase/get_task.dart';
import 'package:todo_app/application/features/general/domain/usecase/update_task.dart';

part 'task_details_event.dart';

part 'task_details_state.dart';

class TaskDetailsBloc extends Bloc<TaskDetailsEvent, TaskDetailsState> {
  final GetTaskUseCase _getTaskUseCase;
  final UpdateTaskUseCase _updateTaskUseCase;
  final DeleteTaskUseCase _deleteTaskUseCase;

  TaskDetailsBloc(
    this._getTaskUseCase,
    this._updateTaskUseCase,
    this._deleteTaskUseCase,
  ) : super(TaskDetailsState.initial()) {
    on<_GetTaskEvent>(_onGetTaskEvent);
    on<_UpdateTaskEvent>(_onUpdateTaskEvent);
    on<_DeleteTaskEvent>(_onDeleteTask);
  }

  FutureOr<void> _onGetTaskEvent(_GetTaskEvent event, Emitter<TaskDetailsState> emit) async {
    emit(state._loading());
    try {
      var dataState = await _getTaskUseCase(params: event.id);
      dataState.when(
        success: (task) => emit(state._taskLoaded(task)),
        failure: (error) => emit(state._taskError(error.toString())),
      );
    } catch (e) {
      emit(state._taskError(e.toString()));
    }
  }

  FutureOr<void> _onUpdateTaskEvent(_UpdateTaskEvent event, Emitter<TaskDetailsState> emit) async {
    try {
      var dataState = await _updateTaskUseCase(params: event.task);
      dataState.when(
        success: (task) => emit(state._taskUpdated()),
        failure: (error) => emit(state._taskError(error.toString())),
      );
    } catch (e) {
      emit(state._taskError(e.toString()));
    }
  }

  FutureOr<void> _onDeleteTask(_DeleteTaskEvent event, Emitter<TaskDetailsState> emit) async {
    if (event.id == null) {
      emit(state._taskError(Exception("Something went wrong")));
      return;
    }
    try {
      var dataState = await _deleteTaskUseCase(params: event.id!);
      dataState.when(
        success: (tasks) {
          emit(state._taskDeleted());
        },
        failure: (error) => emit(state._taskError(error)),
      );
    } catch (e) {
      emit(state._taskError(e));
    }
  }
}
