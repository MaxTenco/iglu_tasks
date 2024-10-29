import 'package:flutter/material.dart';
import 'package:iglu_tasks/presentation/screens/tasks/list/components/task_tile.dart';

import '../../../../../domain/entities/task.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    super.key,
    required this.tasks,
  });

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Text(
                'Al momento non hai nessun task.\nClicca sul "+" per crearne uno!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          )
        : ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) => TaskTile(task: tasks[index]),
          );
  }
}
