import 'package:flutter/material.dart' show immutable;

@immutable
abstract class OverviewItemEntity {
  final int? id;
  final String? title;
  final String? content;
  final String? image;

  const OverviewItemEntity({
    this.id,
    this.title,
    this.content,
    this.image,
  })  : assert(
          id != null,
          'Id cannot be null',
        ),
        assert(
          title != null,
          'Title cannot be null',
        ),
        assert(
          content != null,
          'Content cannot be null',
        ),
        assert(
          image != null,
          'Image cannot be null',
        );
}
