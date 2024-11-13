import 'package:flutter/material.dart' show immutable;

@immutable
sealed class AppState {
  final bool? isInitialized;

  const AppState({
    this.isInitialized,
  });

  AppState copyWith({
    bool? isInitialized,
  });
}

class AppInitial extends AppState {
  const AppInitial({
    bool? isInitialized,
  }) : super(
          isInitialized: isInitialized ?? false,
        );

  @override
  AppState copyWith({bool? isInitialized}) => AppInitial(
        isInitialized: isInitialized ?? this.isInitialized,
      );
}
