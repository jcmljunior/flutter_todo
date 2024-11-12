import 'package:flutter_todo/features/tasks/models/task.model.dart';

import '../../mock_data/mock.data.dart';

class MockTasks {
  static TaskModel generateTask({
    int? id,
    int? authorId,
    String? title,
    String? content,
    bool? isFavorite,
    bool? isCompleted,
    DateTime? createdAt,
  }) {
    return TaskModel(
      id: id ?? MockData.generateInt(),
      authorId: authorId ?? MockData.generateInt(),
      title: title ?? MockData.generateString(),
      content: content ?? MockData.generateString(),
      isFavorite: isFavorite ?? MockData.generateBoolean(),
      isCompleted: isCompleted ?? !MockData.generateBoolean(),
      createdAt: createdAt ??
          DateTime.now().subtract(
            Duration(days: MockData.generateInt()),
          ),
    );
  }

  static List<TaskModel> generateTasks([int length = 10]) {
    return List.generate(length, (int index) => generateTask(id: index));
  }
}
