import 'package:get_it/get_it.dart';
import 'package:todo_app/application/features/general/data/repository_impl/task_repository_impl.dart';
import 'package:todo_app/application/features/general/data/source/local/task_local_service.dart';
import 'package:todo_app/application/features/general/domain/repository/task_repository.dart';
import 'package:todo_app/application/features/general/domain/usecase/create_task.dart';
import 'package:todo_app/application/features/general/domain/usecase/delete_task.dart';
import 'package:todo_app/application/features/general/domain/usecase/get_task.dart';
import 'package:todo_app/application/features/general/domain/usecase/get_tasks.dart';
import 'package:todo_app/application/features/general/domain/usecase/update_task.dart';
import 'package:todo_app/application/features/general/presentation/screens/home/bloc/home_bloc.dart';
import 'package:todo_app/application/features/general/presentation/screens/task/create_task/bloc/create_task_bloc.dart';
import 'package:todo_app/application/features/general/presentation/screens/task/task_details/bloc/task_details_bloc.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // Services
  getIt.registerSingleton<TaskLocalService>(TaskLocalService());

  // Repositories
  getIt.registerSingleton<TaskRepository>(TaskRepositoryImpl(getIt()));

  // UseCases
  getIt.registerSingleton<CreateTaskUseCase>(CreateTaskUseCase(getIt()));
  getIt.registerSingleton<UpdateTaskUseCase>(UpdateTaskUseCase(getIt()));
  getIt.registerSingleton<GetTasksUseCase>(GetTasksUseCase(getIt()));
  getIt.registerSingleton<GetTaskUseCase>(GetTaskUseCase(getIt()));
  getIt.registerSingleton<DeleteTaskUseCase>(DeleteTaskUseCase(getIt()));

  // Blocs
  getIt.registerFactory<HomeBloc>(() => HomeBloc(getIt(), getIt(), getIt()));
  getIt.registerFactory<CreateTaskBloc>(() => CreateTaskBloc(getIt()));
  getIt.registerFactory<TaskDetailsBloc>(() => TaskDetailsBloc(getIt(), getIt(), getIt()));
}
