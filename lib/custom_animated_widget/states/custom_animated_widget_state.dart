import 'package:flutter/material.dart' show immutable;

@immutable
sealed class CustomAnimatedWidgetStoreState {
  final bool? isLoading;
  final bool? isVisible;

  const CustomAnimatedWidgetStoreState({
    this.isLoading,
    this.isVisible,
  });

  CustomAnimatedWidgetStoreState copyWith({
    bool? isLoading,
    bool? isVisible,
  });
}

class CustomAnimatedWidgetInitial extends CustomAnimatedWidgetStoreState {
  const CustomAnimatedWidgetInitial({
    bool? isLoading,
    bool? isVisible,
  }) : super(
          isLoading: isLoading ?? false,
          isVisible: isVisible ?? false,
        );

  @override
  CustomAnimatedWidgetStoreState copyWith({bool? isLoading, bool? isVisible}) =>
      CustomAnimatedWidgetInitial(
        isLoading: isLoading ?? this.isLoading,
        isVisible: isVisible ?? this.isVisible,
      );
}
