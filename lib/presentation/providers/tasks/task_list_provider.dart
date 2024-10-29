import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../../../domain/entities/task.dart';
import '../../../domain/services/task_service.dart';
import '../../ui_states/data_ui_state.dart';

class TaskListProvider extends ChangeNotifier {
  DataUIState _uiState = Loading();
  final _tasks = <Task>[];
  final _tasksToShow = <Task>[];
  final _service = TaskService();

  List<Task> get tasks => _tasksToShow;

  DataUIState get uiState => _uiState;

  Future<void> init() async {
    try {
      final results = await _service.findAll();

      _tasks.clear();
      _tasks.addAll(results);

      _tasksToShow.clear();
      _tasksToShow.addAll(results);

      _uiState = Success();
    } catch (e) {
      _uiState = Error();

      print(e);
    } finally {
      notifyListeners();
    }
  }

  Future<void> onDonePressed(Task task, bool? value) async {
    final index = tasks.indexOf(task);
    tasks[index] = task.copyWith(isCompleted: value ?? false);
    notifyListeners();
  }

  Future<void> refreshTasks() async {
    _uiState = Loading();
    notifyListeners();

    // Per simulare il caricamento
    await Future.delayed(Duration(seconds: 1));

    await init();
  }

  void search(String query) {
    if (query.isEmpty) {
      _tasksToShow.clear();
      _tasksToShow.addAll(_tasks);
    }

    final items = tasks.where((task) => task.title.toLowerCase().contains(query.toLowerCase())).toList();
    _tasksToShow.clear();
    _tasksToShow.addAll(items);
    notifyListeners();
  }
}
