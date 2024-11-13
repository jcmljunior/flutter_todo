import 'package:flutter/material.dart';

import 'package:test/test.dart';

import 'package:flutter_todo/features/theme_manager/constants/theme_manager_constant.dart';
import 'package:flutter_todo/features/theme_manager/states/theme_manager_state.dart';
import 'package:flutter_todo/features/theme_manager/stores/theme_manager_store.dart';

void main() {
  test('themeMode setter deve atualizar o estado.', () {
    final ThemeManagerStore themeManagerStore =
        ThemeManagerStore(const ThemeManagerInitial());

    switch (ThemeManagerConstant.defaultThemeMode) {
      case ThemeMode.light:
        themeManagerStore.themeMode = ThemeMode.dark;
        expect(themeManagerStore.themeMode, ThemeMode.dark,
            reason: 'O themeMode deve ser ThemeMode.dark.');
        break;
      case ThemeMode.dark:
        themeManagerStore.themeMode = ThemeMode.system;
        expect(themeManagerStore.themeMode, ThemeMode.system,
            reason: 'O themeMode deve ser ThemeMode.system.');
        break;
      case ThemeMode.system:
        themeManagerStore.themeMode = ThemeMode.light;
        expect(themeManagerStore.themeMode, ThemeMode.light,
            reason: 'O themeMode deve ser ThemeMode.light.');
        break;
    }
  });

  test('accentColor setter deve atualizar o estado.', () {
    final ThemeManagerStore themeManagerStore =
        ThemeManagerStore(const ThemeManagerInitial());
    const Color accentColor = Colors.blue;

    themeManagerStore.accentColor = accentColor;

    expect(themeManagerStore.accentColor, equals(accentColor),
        reason: 'themeManagerStore.accentColor deve ser igual a accentColor');
  });

  test('brightness setter deve atualizar o estado.', () {
    final ThemeManagerStore themeManagerStore =
        ThemeManagerStore(const ThemeManagerInitial());

    switch (themeManagerStore.brightness) {
      case Brightness.light:
        themeManagerStore.brightness = Brightness.dark;
        break;
      case Brightness.dark:
        themeManagerStore.brightness = Brightness.light;
        break;
    }

    expect(
        themeManagerStore.brightness == ThemeManagerConstant.defaultBrightness,
        isFalse,
        reason:
            'themeManagerStore.brightness deve ser diferente de ThemeManagerConstant.defaultBrightness');
  });

  test('themeMode setter deve atualizar o estado.', () {
    final ThemeManagerStore themeManagerStore =
        ThemeManagerStore(const ThemeManagerInitial());

    switch (themeManagerStore.themeMode) {
      case ThemeMode.light:
        themeManagerStore.themeMode = ThemeMode.dark;
        break;
      case ThemeMode.dark:
        themeManagerStore.themeMode = ThemeMode.system;
        break;
      case ThemeMode.system:
        themeManagerStore.themeMode = ThemeMode.light;
        break;
    }

    expect(themeManagerStore.themeMode == ThemeManagerConstant.defaultThemeMode,
        isFalse,
        reason:
            'themeManagerStore.themeMode deve ser diferente de ThemeManagerConstant.defaultThemeMode');
  });
}
