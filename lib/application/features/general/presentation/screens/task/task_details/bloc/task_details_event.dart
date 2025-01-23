part of 'task_details_bloc.dart';

@immutable
sealed class TaskDetailsEvent {
  const TaskDetailsEvent();

  factory TaskDetailsEvent.getTask(int id) => _GetTaskEvent(id);

  factory TaskDetailsEvent.update(Task task) => _UpdateTaskEvent(task);

  factory TaskDetailsEvent.delete(int? id) => _DeleteTaskEvent(id);
}

class _GetTaskEvent extends TaskDetailsEvent {
  final int id;

  const _GetTaskEvent(this.id);
}

class _UpdateTaskEvent extends TaskDetailsEvent {
  final Task task;

  const _UpdateTaskEvent(this.task);
}

class _DeleteTaskEvent extends TaskDetailsEvent {
  final int? id;

  const _DeleteTaskEvent(this.id);
}
