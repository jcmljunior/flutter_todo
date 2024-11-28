import 'package:flutter/material.dart' show immutable;

@immutable
sealed class CustomAnimatedWidgetState {
  final bool? isLoading;
  final bool? isVisible;

  const CustomAnimatedWidgetState({
    this.isLoading,
    this.isVisible,
  });

  CustomAnimatedWidgetState copyWith({
    bool? isLoading,
    bool? isVisible,
  });
}

class CustomAnimatedWidgetInitial extends CustomAnimatedWidgetState {
  const CustomAnimatedWidgetInitial({
    bool? isLoading,
    bool? isVisible,
  }) : super(
          isLoading: isLoading ?? false,
          isVisible: isVisible ?? false,
        );

  @override
  CustomAnimatedWidgetState copyWith({bool? isLoading, bool? isVisible}) =>
      CustomAnimatedWidgetInitial(
        isLoading: isLoading ?? this.isLoading,
        isVisible: isVisible ?? this.isVisible,
      );
}
