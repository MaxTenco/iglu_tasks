import 'task.dart';

class TaskForm {
  TaskForm({
    this.id,
    this.title,
    this.description,
    this.isCompleted = false,
  });

  String? id;
  String? title;
  String? description;
  bool isCompleted;

  bool get hasId => id != null;

  factory TaskForm.fromTask(Task? task) {
    return TaskForm(
      id: task?.id,
      title: task?.title,
      description: task?.description,
      isCompleted: task?.isCompleted ?? false,
    );
  }
}
