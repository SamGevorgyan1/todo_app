part of 'home_bloc.dart';

@immutable
class HomeState {
  final List<Task>? tasks;
  final String? error;
  final bool isLoading;
  final bool isDeleted;
  final bool isCompleted;

  const HomeState({
    this.tasks,
    this.error,
    this.isLoading = false,
    this.isDeleted = false,
    this.isCompleted = false,
  });

  factory HomeState.initial() => const HomeState();

  HomeState _tasksLoaded(List<Task> tasks) {
    return copyWith(tasks: tasks, isLoading: false);
  }

  HomeState _taskError(Object error) {
    return copyWith(error: error.toString(), isLoading: false);
  }

  HomeState _loading() {
    return copyWith(isLoading: true);
  }

  HomeState _taskDeleted() {
    return copyWith(isDeleted: true);
  }

  HomeState _taskCompleted() {
    return copyWith(isCompleted: true);
  }

  HomeState copyWith({
    List<Task>? tasks,
    String? error,
    bool? isLoading,
    bool? isDeleted,
    bool? isCompleted,
  }) {
    return HomeState(
      tasks: tasks ?? this.tasks,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      isDeleted: isDeleted ?? this.isDeleted,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
