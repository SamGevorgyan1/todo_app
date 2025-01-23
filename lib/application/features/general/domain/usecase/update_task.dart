import 'package:todo_app/application/core/resources/data_state/data_state.dart';
import 'package:todo_app/application/core/usecase/use_case.dart';
import 'package:todo_app/application/features/general/domain/model/task.dart';
import 'package:todo_app/application/features/general/domain/repository/task_repository.dart';

class UpdateTaskUseCase extends UseCase<DataState<Task>, Task> {
  final TaskRepository _taskRepository;

  const UpdateTaskUseCase(this._taskRepository);

  @override
  Future<DataState<Task>> call({required Task params}) async {
    return await _taskRepository.update(params);
  }
}
