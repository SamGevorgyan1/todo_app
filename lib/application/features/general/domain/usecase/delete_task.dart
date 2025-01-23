import 'package:todo_app/application/core/resources/data_state/data_state.dart';
import 'package:todo_app/application/core/usecase/use_case.dart';
import 'package:todo_app/application/features/general/domain/repository/task_repository.dart';

class DeleteTaskUseCase extends UseCase<DataState<bool>, int> {
  final TaskRepository _repository;

  const DeleteTaskUseCase(this._repository);

  @override
  Future<DataState<bool>> call({required int params}) async {
    return await _repository.delete(params);
  }
}
