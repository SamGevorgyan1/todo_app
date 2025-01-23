part of 'task_details_bloc.dart';

@immutable
class TaskDetailsState {
  final Task? task;
  final bool? isLoading;
  final String? error;
  final bool isDeleted;
  final bool isUpdated;

  const TaskDetailsState({
    this.task,
    this.isLoading,
    this.isDeleted = false,
    this.isUpdated = false,
    this.error,
  });

  factory TaskDetailsState.initial() {
    return const TaskDetailsState(isLoading: false);
  }

  TaskDetailsState _loading() {
    return copyWith(isLoading: true);
  }

  TaskDetailsState _taskLoaded(Task? task) {
    return copyWith(task: task, isLoading: false);
  }

  TaskDetailsState _taskDeleted() {
    return copyWith(isDeleted: true);
  }

  TaskDetailsState _taskUpdated() {
    return copyWith(isUpdated: true);
  }

  TaskDetailsState _taskError(Object error) {
    return copyWith(error: error.toString(), isLoading: false);
  }

  TaskDetailsState copyWith({
    Task? task,
    bool? isLoading,
    String? error,
    bool? isDeleted,
    bool? isUpdated,
  }) {
    return TaskDetailsState(
      task: task ?? this.task,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isDeleted: isDeleted ?? this.isDeleted,
      isUpdated: isUpdated ?? this.isUpdated,
    );
  }
}
