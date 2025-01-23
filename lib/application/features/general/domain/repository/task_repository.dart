import 'package:todo_app/application/core/resources/data_state/data_state.dart';
import 'package:todo_app/application/features/general/domain/model/task.dart';

abstract class TaskRepository {
  Future<DataState<int>> create(Task task);

  Future<DataState<Task>> update(Task task);

  Future<DataState<Task>> get(int id);

  Future<DataState<List<Task>>> getTasks(bool? isActive);

  Future<DataState<bool>> delete(int id);
}
