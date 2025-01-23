part of 'create_task_bloc.dart';

class CreateTaskState {
  final bool? isCreated;
  final String? error;
  final bool? isLoading;
  String? title;
  String? description;

  CreateTaskState({
    this.isCreated,
    this.error,
    this.isLoading,
    this.title,
    this.description,
  });

  factory CreateTaskState.initial() => CreateTaskState(isLoading: false);

  CreateTaskState _created() {
    return copyWith(isCreated: true, isLoading: false);
  }

  CreateTaskState _loading() {
    return copyWith(isLoading: true);
  }

  CreateTaskState _error(Object error) {
    return copyWith(error: error.toString(), isCreated: false, isLoading: false);
  }

  CreateTaskState copyWith({
    bool? isCreated,
    String? error,
    bool? isLoading,
    String? title,
    String? description,
  }) {
    return CreateTaskState(
      isCreated: isCreated ?? this.isCreated,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }
}
