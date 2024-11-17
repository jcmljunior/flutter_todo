import 'package:flutter/material.dart' show immutable;

@immutable
sealed class AnimatedButtonState {
  final bool? isLoading;
  final bool? isVisible;

  const AnimatedButtonState({
    this.isLoading,
    this.isVisible,
  });

  AnimatedButtonState copyWith({
    bool? isLoading,
    bool? isVisible,
  });
}

class AnimatedButtonInitial extends AnimatedButtonState {
  const AnimatedButtonInitial({
    bool? isLoading,
    bool? isVisible,
  }) : super(
          isLoading: isLoading ?? false,
          isVisible: isVisible ?? false,
        );

  @override
  AnimatedButtonState copyWith({bool? isLoading, bool? isVisible}) =>
      AnimatedButtonInitial(
        isLoading: isLoading ?? this.isLoading,
        isVisible: isVisible ?? this.isVisible,
      );
}
