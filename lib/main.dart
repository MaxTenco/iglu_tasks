import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'presentation/providers/tasks/task_list_provider.dart';
import 'presentation/screens/tasks/list/task_list_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      home: ChangeNotifierProvider<TaskListProvider>(
        create: (context) => TaskListProvider()..init(),
        child: TaskListScreen(),
      ),
    );
  }
}
