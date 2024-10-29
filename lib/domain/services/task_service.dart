import 'package:uuid/uuid.dart';

import '../../data/models/task_model.dart';
import '../../data/repositories/task_repository.dart';
import '../entities/task.dart';
import '../entities/task_form.dart';

class TaskService {
  final _repository = TaskRepository();

  Future<List<Task>> findAll() async {
    final result = await _repository.findAll();
    return result.map(Task.fromModel).toList();
  }

  Future<void> save(TaskForm taskForm) async {
    if (taskForm.hasId) {
      final model = TaskModel(
        id: taskForm.id!,
        title: taskForm.title!,
        description: taskForm.description!,
        isCompleted: taskForm.isCompleted,
      );

      await _repository.update(model);
    } else {
      final model = TaskModel(
        id: Uuid().v4(),
        title: taskForm.title!,
        description: taskForm.description!,
      );

      await _repository.create(model);
    }
  }

  Future<void> delete(String taskId) => _repository.delete(taskId);
}
