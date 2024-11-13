import 'package:flutter/material.dart';

import '../containers/theme_manager_container.dart';
import '../stores/theme_manager_store.dart';

mixin ThemeManagerMixin {
  Brightness getBrightness(BuildContext context) {
    final ThemeManagerStore state =
        ThemeManagerContainer.of(context).themeManagerStore;

    switch (state.themeMode) {
      case ThemeMode.light:
        return Brightness.light;
      case ThemeMode.dark:
        return Brightness.dark;
      default:
        return View.of(context).platformDispatcher.platformBrightness;
    }
  }

  void handlePlatformBrightnessChanged(BuildContext context) {
    WidgetsBinding.instance.platformDispatcher.onPlatformBrightnessChanged =
        () {
      final ThemeManagerStore store =
          ThemeManagerContainer.of(context).themeManagerStore;
      if (store.themeMode == ThemeMode.system) {
        store.brightness = getBrightness(context);
        return;
      }
    };
  }
}
