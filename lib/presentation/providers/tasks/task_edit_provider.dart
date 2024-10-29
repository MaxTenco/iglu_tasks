import 'package:flutter/material.dart';

import '../../../domain/entities/task.dart';
import '../../../domain/entities/task_form.dart';
import '../../../domain/services/task_service.dart';
import '../../ui_states/data_ui_state.dart';

class TaskEditProvider extends ChangeNotifier {
  late final TaskForm taskForm;
  final formKey = GlobalKey<FormState>();
  final _service = TaskService();

  bool isLoading = false;

  void init([Task? task]) {
    taskForm = TaskForm.fromTask(task);
  }

  Future<bool> onSavePressed() async {
    final form = formKey.currentState!;

    if (form.validate()) {
      form.save();
      await _service.save(taskForm);
      return true;
    }

    return false;
  }

  void onCheckBoxChanged(bool value) => taskForm.isCompleted = value;

  Future<void> deleteTask() => _service.delete(taskForm.id!);

  void showLoading() {
    isLoading = true;
    notifyListeners();
  }

  void hideLoading() {
    isLoading = false;
    notifyListeners();
  }
}
