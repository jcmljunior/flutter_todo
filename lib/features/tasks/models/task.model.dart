import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show immutable;

import '../entities/task.entity.dart';

class TaskSchema {
  static const id = 'id';
  static const authorId = 'authorId';
  static const title = 'title';
  static const content = 'content';
  static const isFavorite = 'isFavorite';
  static const isCompleted = 'isCompleted';
  static const createdAt = 'createdAt';
  static const tableName = 'tasks';
  static const columns = [
    id,
    authorId,
    title,
    content,
    isFavorite,
    isCompleted,
    createdAt,
  ];
  static final values = {
    id: 'INTEGER PRIMARY KEY AUTOINCREMENT',
    authorId: 'INTEGER NOT NULL',
    title: 'TEXT NOT NULL',
    content: 'TEXT NOT NULL',
    isFavorite: 'INTEGER NOT NULL',
    isCompleted: 'INTEGER NOT NULL',
    createdAt: 'TEXT NOT NULL',
  };
  static final createTable =
      '''CREATE TABLE IF NOT EXISTS $tableName (${values.entries.map((e) => '${e.key} ${e.value}').join(', ')})''';
}

@immutable
class TaskModel extends TaskEntity with EquatableMixin {
  const TaskModel({
    super.id,
    super.authorId,
    super.title,
    super.content,
    super.isFavorite,
    super.isCompleted,
    super.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        authorId,
        title,
        content,
        isFavorite,
        isCompleted,
        createdAt,
      ];

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json[TaskSchema.id],
        authorId: json[TaskSchema.authorId],
        title: json[TaskSchema.title],
        content: json[TaskSchema.content],
        isFavorite: json[TaskSchema.isFavorite],
        isCompleted: json[TaskSchema.isCompleted],
        createdAt: json[TaskSchema.createdAt],
      );

  Map<String, dynamic> toJson() => {
        TaskSchema.id: id,
        TaskSchema.authorId: authorId,
        TaskSchema.title: title,
        TaskSchema.content: content,
        TaskSchema.isFavorite: isFavorite,
        TaskSchema.isCompleted: isCompleted,
        TaskSchema.createdAt: createdAt,
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
