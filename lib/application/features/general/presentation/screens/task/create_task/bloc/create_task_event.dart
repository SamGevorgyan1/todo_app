part of 'create_task_bloc.dart';

@immutable
sealed class CreateTaskEvent {
  const CreateTaskEvent();

  factory CreateTaskEvent.create() => const _CreateEvent();
}

class _CreateEvent extends CreateTaskEvent {
  const _CreateEvent();
}
