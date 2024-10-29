import 'package:flutter/material.dart';
import 'package:iglu_tasks/main.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/entities/task.dart';
import '../../../../providers/tasks/task_edit_provider.dart';
import '../../../../providers/tasks/task_list_provider.dart';
import '../../edit/task_edit_screen.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),
      subtitle: Text(task.description),
      trailing: Checkbox(
        value: task.isCompleted,
        onChanged: (value) {},
      ),
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider<TaskEditProvider>(
              create: (context) => TaskEditProvider()..init(task),
              child: TaskEditScreen(),
            ),
          ),
        );

        if (result && context.mounted) {
          await context.read<TaskListProvider>().refreshTasks();
        }
      },
    );
  }
}
