import 'package:todo_app/application/core/resources/data_state/data_state.dart';
import 'package:todo_app/application/core/usecase/use_case.dart';
import 'package:todo_app/application/features/general/domain/model/task.dart';
import 'package:todo_app/application/features/general/domain/repository/task_repository.dart';

class GetTaskUseCase extends UseCase<DataState<Task>, int> {
  final TaskRepository _repository;

  const GetTaskUseCase(this._repository);

  @override
  Future<DataState<Task>> call({required int params}) async {
    return await _repository.get(params);
  }
}
