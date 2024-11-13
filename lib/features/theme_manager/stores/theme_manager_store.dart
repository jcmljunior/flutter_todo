import 'package:flutter/material.dart';

import '../../value_notifier/extensions/value_notifier_extension.dart';
import '../states/theme_manager_state.dart';

class ThemeManagerStore extends ValueNotifier<ThemeManagerState> {
  ThemeManagerStore(super.value);

  ThemeMode get themeMode => state.themeMode!;

  set themeMode(ThemeMode themeMode) {
    if (state.themeMode == themeMode) return;

    state = state.copyWith(
      themeMode: themeMode,
    );
  }

  Brightness get brightness => state.brightness!;

  set brightness(Brightness brightness) {
    if (state.brightness == brightness) return;

    state = state.copyWith(
      brightness: brightness,
    );
  }

  Color get accentColor => state.accentColor!;

  set accentColor(Color accentColor) {
    if (state.accentColor == accentColor) return;

    state = state.copyWith(
      accentColor: accentColor,
    );
  }
}
