import 'package:flutter/material.dart';

import '../constants/theme_manager_constant.dart';

@immutable
sealed class ThemeManagerState {
  final ThemeMode? themeMode;
  final Brightness? brightness;
  final Color? accentColor;

  const ThemeManagerState({
    this.themeMode,
    this.brightness,
    this.accentColor,
  })  : assert(
          themeMode != null,
          "themeMode cannot be null",
        ),
        assert(
          brightness != null,
          "brightness cannot be null",
        ),
        assert(
          accentColor != null,
          "accentColor cannot be null",
        );

  ThemeManagerState copyWith({
    ThemeMode? themeMode,
    Brightness? brightness,
    Color? accentColor,
  });
}

class ThemeManagerInitial extends ThemeManagerState {
  const ThemeManagerInitial({
    ThemeMode? themeMode,
    Brightness? brightness,
    Color? accentColor,
  }) : super(
          themeMode: themeMode ?? ThemeManagerConstant.defaultThemeMode,
          brightness: brightness ?? ThemeManagerConstant.defaultBrightness,
          accentColor: accentColor ?? ThemeManagerConstant.defaultAccentColor,
        );

  @override
  ThemeManagerState copyWith({
    ThemeMode? themeMode,
    Brightness? brightness,
    Color? accentColor,
  }) =>
      ThemeManagerInitial(
        themeMode: themeMode ?? this.themeMode,
        brightness: brightness ?? this.brightness,
        accentColor: accentColor ?? this.accentColor,
      );
}
