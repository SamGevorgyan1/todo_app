import 'package:todo_app/application/core/resources/data_state/data_state.dart';
import 'package:todo_app/application/features/general/data/source/local/task_local_service.dart';
import 'package:todo_app/application/features/general/domain/model/task.dart';
import 'package:todo_app/application/features/general/domain/repository/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalService _localService;

  const TaskRepositoryImpl(this._localService);

  @override
  Future<DataState<int>> create(Task task) async {
    try {
      int taskId = await _localService.insertTask(task.toJson());
      return DataState.success(taskId);
    } catch (e) {
      return DataState.error(e);
    }
  }

  @override
  Future<DataState<Task>> update(Task task) async {
    try {
      await _localService.updateTask(task.toJson(), task.id.toString());
      return DataState.success(task);
    } catch (e) {
      return DataState.error(e);
    }
  }

  @override
  Future<DataState<Task>> get(int id) async {
    try {
      var taskMap = await _localService.get(id);
      if (taskMap == null || taskMap.isEmpty) {
        throw Exception('Task not found');
      }
      return DataState.success(Task.fromMap(taskMap));
    } catch (e) {
      return DataState.error(e);
    }
  }

  @override
  Future<DataState<List<Task>>> getTasks(bool? isActive) async {
    try {
      var tasksMap = await _localService.getAllTasks(isActive: isActive);
      List<Task> tasks = tasksMap.map((taskMap) => Task.fromMap(taskMap)).toList();
      return DataState.success(tasks);
    } catch (e) {
      return DataState.error(e);
    }
  }

  @override
  Future<DataState<bool>> delete(int id) async {
    try {
      await _localService.deleteTask(id);
      return DataState.success(true);
    } catch (e) {
      return DataState.error(e);
    }
  }
}
