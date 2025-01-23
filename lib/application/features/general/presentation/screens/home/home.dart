import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/application/di/di_container.dart';
import 'package:todo_app/application/features/general/domain/model/task.dart';
import 'package:todo_app/application/features/general/presentation/screens/home/bloc/home_bloc.dart';
import 'package:todo_app/application/features/general/presentation/screens/task/create_task/create_task_screen.dart';
import 'package:todo_app/application/features/general/presentation/screens/task/task_details/task_details_screen.dart';
import 'package:todo_app/application/features/general/presentation/utils/task_filter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeBloc>()..add(HomeEvent.getTasks()),
      child: const HomeScreenView(),
    );
  }
}

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  TaskFilter _selectedFilter = TaskFilter.all;

  void _openCreateTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return const FractionallySizedBox(
          alignment: Alignment.topCenter,
          heightFactor: 0.7,
          child: CreateTaskScreen(),
        );
      },
    ).then((_) {
      context.read<HomeBloc>().add(HomeEvent.getTasks());
    });
  }

  void _handleFilterChange(TaskFilter? filter) {
    if (filter == null) return;

    setState(() {
      _selectedFilter = filter;
    });
    context.read<HomeBloc>().add(HomeEvent.filterTask(filter));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listenWhen: (previous, current) =>
          previous.isDeleted != current.isDeleted || previous.isCompleted != current.isCompleted,
      listener: (context, state) {
        if (state.isDeleted || state.isCompleted) {
          final content = state.isDeleted ? 'Task deleted' : 'Task completed';
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(content),
              duration: const Duration(seconds: 1),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Tasks"),
          actions: [_buildDropdownButton()],
        ),
        body: const _TaskListView(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _openCreateTask(context),
          tooltip: 'Add Task',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  DropdownButton<TaskFilter> _buildDropdownButton() {
    return DropdownButton<TaskFilter>(
      value: _selectedFilter,
      onChanged: _handleFilterChange,
      items: [
        DropdownMenuItem(value: TaskFilter.all, child: Text(TaskFilter.all.name)),
        DropdownMenuItem(value: TaskFilter.active, child: Text(TaskFilter.active.name)),
        DropdownMenuItem(value: TaskFilter.completed, child: Text(TaskFilter.completed.name)),
      ],
    );
  }
}

class _TaskListView extends StatelessWidget {
  const _TaskListView();

  Future<void> _onRefresh(BuildContext context) async {
    context.read<HomeBloc>().add(HomeEvent.getTasks());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () => _onRefresh(context),
          child: _buildContent(state),
        );
      },
    );
  }

  Widget _buildContent(HomeState state) {
    var tasks = state.tasks;
    var isLoading = state.isLoading;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (!isLoading && (tasks == null || tasks.isEmpty)) {
      return const Center(child: Text("Tasks are empty"));
    }

    return ListView.builder(
      itemCount: isLoading ? 1 : (tasks?.length ?? 0),
      itemBuilder: (context, index) {
        return _TaskListItemWidget(tasks![index]);
      },
    );
  }
}

class _TaskListItemWidget extends StatelessWidget {
  const _TaskListItemWidget(this.task);

  final Task task;

  void _onTapItem(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TaskDetailsScreen(id: task.id ?? 0)),
    ).then((_) {
      context.read<HomeBloc>().add(HomeEvent.getTasks());
    });
  }

  void _onTapStatus(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return _TaskActionBottomSheet(
          task: task,
          homeBloc: context.read<HomeBloc>(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final title = task.title ?? "No Title";
    final description = task.description ?? "No Description Available";
    final isActive = task.isActive ?? false;

    final Color statusColor = isActive ? Colors.green : Colors.grey;
    final String statusText = isActive ? "Active" : "Completed";
    final IconData statusIcon = isActive ? Icons.play_circle_fill : Icons.check_circle;

    return InkWell(
      onTap: () => _onTapItem(context),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(statusIcon, statusColor, title, context),
              const SizedBox(height: 8),
              Row(
                children: [
                  _buildDescription(description, context),
                  const SizedBox(width: 10),
                  _buildStatus(context, statusColor, statusText, isActive),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildTitle(IconData statusIcon, Color statusColor, String title, BuildContext context) {
    return Row(
      children: [
        Icon(statusIcon, color: statusColor, size: 24),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Expanded _buildDescription(String description, BuildContext context) {
    return Expanded(
      child: Text(
        description,
        style: Theme.of(context).textTheme.bodyMedium,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildStatus(BuildContext context, Color statusColor, String statusText, bool isActive) {
    return InkWell(
      onTap: () => _onTapStatus(context),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 5),
        decoration: BoxDecoration(
          color: statusColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Text(
              statusText,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: statusColor,
                  ),
            ),
            if (isActive) const Icon(Icons.arrow_drop_down),
            if (!isActive)
              InkWell(
                onTap: () => _onTapStatus(context),
                child: const Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 22,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _TaskActionBottomSheet extends StatelessWidget {
  final Task task;
  final HomeBloc homeBloc;

  const _TaskActionBottomSheet({
    required this.task,
    required this.homeBloc,
  });

  void _onTapComplete(BuildContext context) {
    homeBloc.add(HomeEvent.complete(task.id));
    Navigator.pop(context);
  }

  void _onTapDelete(BuildContext context) {
    homeBloc.add(HomeEvent.delete(task.id));
    Navigator.pop(context);
  }

  void _onTapCancel(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final bool isActive = task.isActive ?? false;

    const completeText = "Complete";
    const deleteText = "Delete";
    const cancelText = "Cancel";

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isActive) ...[
            _buildActionButton(
              context,
              Icons.check,
              completeText,
              Colors.green,
              () => _onTapComplete(context),
            ),
          ],
          if (!isActive) ...[
            _buildActionButton(
              context,
              Icons.remove_circle_outline,
              deleteText,
              Colors.red,
              () => _onTapDelete(context),
            ),
          ],
          _buildActionButton(
            context,
            Icons.close,
            cancelText,
            Colors.grey,
            () => _onTapCancel(context),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
      BuildContext context, IconData icon, String label, Color color, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(label, style: TextStyle(color: color)),
      onTap: onTap,
    );
  }
}
