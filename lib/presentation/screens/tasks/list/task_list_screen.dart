import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/tasks/task_edit_provider.dart';
import '../../../providers/tasks/task_list_provider.dart';
import '../../../ui_states/data_ui_state.dart';
import '../edit/task_edit_screen.dart';
import 'components/search_bar.dart';
import 'components/task_list.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  Widget _loading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _error() {
    return Center(
      child: Text('Si è verificato un errore!'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TaskListProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Gestione dei Compiti'),
      ),
      body: switch (provider.uiState) {
        Loading() => _loading(),
        Success() => Column(
            children: [
              TaskSearchBar(
                onChanged: provider.search,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: TaskList(
                  tasks: provider.tasks,
                ),
              ),
            ],
          ),
        Error() => _error(),
      },
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider<TaskEditProvider>(
                create: (context) => TaskEditProvider()..init(),
                child: TaskEditScreen(),
              ),
            ),
          );

          if (result && context.mounted) {
            await provider.refreshTasks();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
