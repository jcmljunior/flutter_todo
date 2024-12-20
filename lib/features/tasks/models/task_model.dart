import 'package:flutter/material.dart' show immutable;
import '../entities/task.entity.dart';
import '../schemas/task.schema.dart';

@immutable
class TaskModel extends TaskEntity {
  const TaskModel({
    super.id,
    super.authorId,
    super.title,
    super.content,
    super.isFavorite,
    super.isCompleted,
    super.createdAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json[TaskSchema.id],
        authorId: json[TaskSchema.authorId],
        title: json[TaskSchema.title],
        content: json[TaskSchema.content],
        isFavorite: (json[TaskSchema.isFavorite] as int) == 1 ? true : false,
        isCompleted: (json[TaskSchema.isCompleted] as int) == 1 ? true : false,
        createdAt: DateTime.parse(json[TaskSchema.createdAt]),
      );

  Map<String, dynamic> toJson() => {
        TaskSchema.id: id,
        TaskSchema.authorId: authorId,
        TaskSchema.title: title,
        TaskSchema.content: content,
        TaskSchema.isFavorite: isFavorite == true ? 1 : 0,
        TaskSchema.isCompleted: isCompleted == true ? 1 : 0,
        TaskSchema.createdAt: createdAt?.toIso8601String(),
      };

  TaskModel copyWith({
    int? id,
    int? authorId,
    String? title,
    String? content,
    bool? isFavorite,
    bool? isCompleted,
    DateTime? createdAt,
  }) =>
      TaskModel(
        id: id ?? this.id,
        authorId: authorId ?? this.authorId,
        title: title ?? this.title,
        content: content ?? this.content,
        isFavorite: isFavorite ?? this.isFavorite,
        isCompleted: isCompleted ?? this.isCompleted,
        createdAt: createdAt ?? this.createdAt,
      );
}
