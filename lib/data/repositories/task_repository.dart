import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/task_model.dart';

class TaskRepository {
  static const String _tasksKey = 'tasks';

  Future<void> create(TaskModel model) async {
    final tasks = await findAll();
    tasks.add(model);
    await _saveTasks(tasks);
  }

  Future<void> update(TaskModel model) async {
    final tasks = await findAll();
    final index = tasks.indexWhere((task) => task.id == model.id);

    if (index != -1) {
      tasks[index] = model;
      await _saveTasks(tasks);
    }
  }

  Future<List<TaskModel>> findAll() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksString = prefs.getString(_tasksKey);

    if (tasksString != null) {
      final tasksJson = jsonDecode(tasksString) as List<dynamic>;
      return tasksJson.map((json) => TaskModel.fromJson(json)).toList();
    }

    return [];
  }

  Future<void> delete(String id) async {
    final tasks = await findAll();
    tasks.removeWhere((task) => task.id == id);
    await _saveTasks(tasks);
  }

  Future<void> _saveTasks(List<TaskModel> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final encodedTasks = jsonEncode(tasks.map((task) => task.toJson()).toList());
    await prefs.setString(_tasksKey, encodedTasks);
  }
}
