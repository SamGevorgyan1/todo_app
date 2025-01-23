import 'package:todo_app/application/core/resources/data_state/data_state.dart';
import 'package:todo_app/application/core/usecase/use_case.dart';
import 'package:todo_app/application/features/general/domain/model/task.dart';
import 'package:todo_app/application/features/general/domain/repository/task_repository.dart';

class CreateTaskUseCase extends UseCase<DataState<int>, Task> {
  final TaskRepository _repository;

  const CreateTaskUseCase(this._repository);

  @override
  Future<DataState<int>> call({required Task params}) async {
    return await _repository.create(params);
  }
}
