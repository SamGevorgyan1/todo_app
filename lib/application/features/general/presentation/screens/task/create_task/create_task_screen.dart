import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/application/di/di_container.dart';

import 'bloc/create_task_bloc.dart';

class CreateTaskScreen extends StatelessWidget {
  const CreateTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CreateTaskBloc>(),
      child: const _CreateTaskScreenView(),
    );
  }
}

class _CreateTaskScreenView extends StatelessWidget {
  const _CreateTaskScreenView();

  void _onPressedCreate(BuildContext context) {
    context.read<CreateTaskBloc>().add(CreateTaskEvent.create());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTaskBloc, CreateTaskState>(
      builder: (context, state) {
        return BlocListener<CreateTaskBloc, CreateTaskState>(
          listenWhen: (previous, current) => previous.isCreated != current.isCreated,
          listener: (context, state) {
            if (state.isCreated ?? false) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Task is created'),
                  duration: Duration(seconds: 1),
                ),
              );
            }
            Navigator.pop(context);
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Create New Task'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text('Task Title', style: Theme.of(context).textTheme.labelSmall),
                  const SizedBox(height: 8),
                  TextField(
                    onChanged: (text) => state.title = text,
                  ),
                  const SizedBox(height: 20),
                  Text('Task Description', style: Theme.of(context).textTheme.labelSmall),
                  const SizedBox(height: 8),
                  TextField(
                    maxLines: 4,
                    onChanged: (text) => state.description = text,
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () => _onPressedCreate(context),
                      icon: const Icon(Icons.add_task),
                      label: const Text('Create Task'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
