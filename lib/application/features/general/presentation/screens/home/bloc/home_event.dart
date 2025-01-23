part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {
  const HomeEvent();

  factory HomeEvent.getTasks() => const _GetTasksEvent();

  factory HomeEvent.filterTask(TaskFilter filter) => _FilterTasksEvent(filter);

  factory HomeEvent.complete(int? id) => _CompleteTaskEvent(id);

  factory HomeEvent.delete(int? id) => _DeleteTaskEvent(id);
}

class _GetTasksEvent extends HomeEvent {
  const _GetTasksEvent();
}

class _CompleteTaskEvent extends HomeEvent {
  final int? id;

  const _CompleteTaskEvent(this.id);
}

class _DeleteTaskEvent extends HomeEvent {
  final int? id;

  const _DeleteTaskEvent(this.id);
}

class _FilterTasksEvent extends HomeEvent {
  final TaskFilter filter;

  const _FilterTasksEvent(this.filter);
}
