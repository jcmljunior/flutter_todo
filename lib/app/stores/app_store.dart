import 'package:flutter/foundation.dart';

import '../../features/value_notifier/extensions/value_notifier_extension.dart';
import '../states/app_state.dart';

class AppStore extends ValueNotifier<AppState> {
  AppStore(super.value);

  bool get isInitialized => state.isInitialized!;

  set isInitialized(bool value) {
    if (state.isInitialized == value) return;

    state = state.copyWith(
      isInitialized: value,
    );
  }
}
