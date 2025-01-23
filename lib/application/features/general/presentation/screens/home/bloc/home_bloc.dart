import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/application/features/general/domain/model/task.dart';
import 'package:todo_app/application/features/general/domain/usecase/delete_task.dart';
import 'package:todo_app/application/features/general/domain/usecase/get_tasks.dart';
import 'package:todo_app/application/features/general/domain/usecase/update_task.dart';
import 'package:todo_app/application/features/general/presentation/utils/task_filter.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetTasksUseCase _getTasksUseCase;
  final UpdateTaskUseCase _updateTaskUseCase;
  final DeleteTaskUseCase _deleteTaskUseCase;

  HomeBloc(
    this._getTasksUseCase,
    this._deleteTaskUseCase,
    this._updateTaskUseCase,
  ) : super(HomeState.initial()) {
    on<_GetTasksEvent>(_onGetTasks);
    on<_FilterTasksEvent>(_onFilterTasks);
    on<_CompleteTaskEvent>(_onCompleteTask);
    on<_DeleteTaskEvent>(_onDeleteTask);
  }

  FutureOr<void> _onGetTasks(_GetTasksEvent event, Emitter<HomeState> emit) async {
    emit(state._loading());

    try {
      var dataState = await _getTasksUseCase();
      dataState.when(
        success: (tasks) => emit(state._tasksLoaded(tasks)),
        failure: (error) => emit(state._taskError(error)),
      );
    } catch (e) {
      emit(state._taskError(e));
    }
  }

  FutureOr<void> _onFilterTasks(_FilterTasksEvent event, Emitter<HomeState> emit) async {
    emit(state._loading());

    try {
      final filter = event.filter == TaskFilter.active
          ? true
          : event.filter == TaskFilter.completed
              ? false
              : null;

      var dataState = await _getTasksUseCase(params: filter);
      dataState.when(
        success: (tasks) => emit(state._tasksLoaded(tasks)),
        failure: (error) => emit(state._taskError(error)),
      );
    } catch (e) {
      emit(state._taskError(e));
    }
  }

  FutureOr<void> _onCompleteTask(_CompleteTaskEvent event, Emitter<HomeState> emit) async {
    if (event.id == null) {
      emit(state._taskError(Exception("Something went wrong")));
      return;
    }
    try {
      var dataState = await _updateTaskUseCase(params: Task(id: event.id!, isActive: false));
      dataState.when(
        success: (tasks) {
          emit(state._taskCompleted());
          emit(state.copyWith(isCompleted: false));
          add(const _GetTasksEvent());
        },
        failure: (error) => emit(state._taskError(error)),
      );
    } catch (e) {
      emit(state._taskError(e));
    }
  }

  FutureOr<void> _onDeleteTask(_DeleteTaskEvent event, Emitter<HomeState> emit) async {
    if (event.id == null) {
      emit(state._taskError(Exception("Something went wrong")));
      return;
    }
    try {
      var dataState = await _deleteTaskUseCase(params: event.id!);
      dataState.when(
        success: (tasks) {
          emit(state._taskDeleted());
          emit(state.copyWith(isDeleted: false));
          add(const _GetTasksEvent());
        },
        failure: (error) => emit(state._taskError(error)),
      );
    } catch (e) {
      emit(state._taskError(e));
    }
  }
}
