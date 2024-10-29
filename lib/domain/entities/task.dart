import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/task_model.dart';

part 'task.freezed.dart';

@freezed
class Task with _$Task {
  const factory Task({
    required String id,
    required String title,
    required String description,
    required bool isCompleted,
  }) = _Task;

  factory Task.fromModel(TaskModel model) {
    return Task(
      id: model.id,
      title: model.title,
      description: model.description,
      isCompleted: model.isCompleted,
    );
  }
}
