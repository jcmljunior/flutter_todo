import 'package:flutter/material.dart' show immutable;

@immutable
abstract class TaskEntity {
  final int? id;
  final int? authorId;
  final String? title;
  final String? content;
  final bool? isFavorite;
  final bool? isCompleted;
  final DateTime? createdAt;

  const TaskEntity({
    this.id,
    this.authorId,
    this.title,
    this.content,
    this.isFavorite,
    this.isCompleted,
    this.createdAt,
  })  : assert(
          id != null,
          'id must not be null',
        ),
        assert(
          authorId != null,
          'authorId must not be null',
        ),
        assert(
          title != null,
          'title must not be null',
        ),
        assert(
          content != null,
          'content must not be null',
        ),
        assert(
          isFavorite != null,
          'isFavorite must not be null',
        ),
        assert(
          isCompleted != null,
          'isCompleted must not be null',
        ),
        assert(
          createdAt != null,
          'createdAt must not be null',
        );
}
