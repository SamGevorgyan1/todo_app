import 'package:todo_app/application/core/resources/data_state/data_state.dart';
import 'package:todo_app/application/core/usecase/use_case.dart';
import 'package:todo_app/application/features/general/domain/model/task.dart';
import 'package:todo_app/application/features/general/domain/repository/task_repository.dart';

class GetTasksUseCase extends UseCase<DataState<List<Task>>, bool> {
  final TaskRepository _taskRepository;

  const GetTasksUseCase(this._taskRepository);

  @override
  Future<DataState<List<Task>>> call({bool? params}) async {
    return await _taskRepository.getTasks(params);
  }
}
