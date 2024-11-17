import 'package:flutter/material.dart' show immutable;

import '../entities/overview_item_entity.dart';

@immutable
class OverviewItemModel extends OverviewItemEntity {
  const OverviewItemModel({
    super.id,
    super.title,
    super.content,
    super.image,
  });

  OverviewItemModel copyWith({
    int? id,
    String? title,
    String? content,
    String? image,
  }) =>
      OverviewItemModel(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        image: image ?? this.image,
      );
}
