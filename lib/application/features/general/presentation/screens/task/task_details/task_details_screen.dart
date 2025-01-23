import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/application/di/di_container.dart';
import 'package:todo_app/application/features/general/presentation/screens/task/task_details/bloc/task_details_bloc.dart';

class TaskDetailsScreen extends StatelessWidget {
  final int id;

  const TaskDetailsScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TaskDetailsBloc>()..add(TaskDetailsEvent.getTask(id)),
      child: const _TaskDetailsScreenView(),
    );
  }
}

class _TaskDetailsScreenView extends StatelessWidget {
  const _TaskDetailsScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.read<TaskDetailsBloc>().state;

    return Scaffold(
      appBar: AppBar(title: const Text('Task Detail')),
      body: state.isLoading ?? false
          ? const Center(child: CircularProgressIndicator())
          : BlocListener<TaskDetailsBloc, TaskDetailsState>(
              listenWhen: (previous, current) =>
                  previous.isDeleted != current.isDeleted ||
                  previous.isUpdated != current.isUpdated,
              listener: (context, state) {
                if (state.isUpdated || state.isDeleted) {
                  var content = state.isDeleted ? 'Task is deleted' : 'Task is updated';
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(content),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                }
                Navigator.pop(context);
              },
              child: const _TaskDetailsContent(),
            ),
    );
  }
}

class _TaskDetailsContent extends StatefulWidget {
  const _TaskDetailsContent({Key? key}) : super(key: key);

  @override
  _TaskDetailsContentState createState() => _TaskDetailsContentState();
}

class _TaskDetailsContentState extends State<_TaskDetailsContent> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isActive = false;
  bool isUpdated = false;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<TaskDetailsBloc>().state;

    if (state.task != null && titleController.text.isEmpty) {
      titleController.text = state.task!.title ?? '';
      descriptionController.text = state.task!.description ?? '';
      isActive = state.task!.isActive ?? false;
    }

    final isModified = state.task?.title != titleController.text ||
        state.task?.description != descriptionController.text ||
        state.task?.isActive != isActive;

    return BlocBuilder<TaskDetailsBloc, TaskDetailsState>(
      builder: (context, state) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(right: 12, left: 12, top: 16, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                _buildTitleField(state),
                const SizedBox(height: 16),
                _buildDescriptionField(state),
                const SizedBox(height: 16),
                _buildActivitySwitch(state),
                const SizedBox(height: 24),
                const Spacer(),
                _buildUpdateButton(isModified),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTitleField(TaskDetailsState state) {
    return TextFormField(
      controller: titleController,
      onChanged: (value) {
        setState(() {
          isUpdated = value != state.task?.title;
        });
      },
    );
  }

  Widget _buildDescriptionField(TaskDetailsState state) {
    return TextFormField(
      controller: descriptionController,
      onChanged: (value) {
        setState(() {
          isUpdated = value != state.task?.description;
        });
      },
      maxLines: 3,
    );
  }

  Widget _buildActivitySwitch(TaskDetailsState state) {
    if (state.task?.isActive == false) {
      return Align(
        child: ElevatedButton(
          onPressed: () => {
            if (state.task?.id != null)
              context.read<TaskDetailsBloc>().add(TaskDetailsEvent.delete(state.task!.id))
          },
          style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                backgroundColor: WidgetStateProperty.all(Colors.red),
              ),
          child: const Text("Delete"),
        ),
      );
    }

    return SwitchListTile(
      value: !isActive,
      onChanged: (value) {
        setState(() {
          isUpdated = value == state.task?.isActive;
        });
        isActive = !value;
      },
      title: Text(
        "Is Completed",
        style: Theme.of(context).textTheme.titleSmall,
      ),
    );
  }

  Widget _buildUpdateButton(bool isModified) {
    return isModified
        ? Align(
            child: ElevatedButton(
              onPressed: () => _onPressedUpdate(context),
              child: const Text("Update Task"),
            ),
          )
        : const SizedBox();
  }

  void _onPressedUpdate(BuildContext context) {
    final task = context.read<TaskDetailsBloc>().state.task;
    if (task != null) {
      final updatedTask = task.copyWith(
        title: titleController.text,
        description: descriptionController.text,
        isActive: isActive,
      );

      context.read<TaskDetailsBloc>().add(TaskDetailsEvent.update(updatedTask));

      setState(() {
        isUpdated = false;
      });
    }
  }
}
