import 'package:flutter/foundation.dart';

import '../../value_notifier/extensions/value_notifier_extension.dart';
import '../states/animated_button_state.dart';

class AnimatedButtonStore extends ValueNotifier<AnimatedButtonState> {
  AnimatedButtonStore(super.value);

  bool get isLoading => state.isLoading!;

  set isLoading(bool value) {
    if (state.isLoading == value) return;

    state = state.copyWith(
      isLoading: value,
    );
  }

  bool get isVisible => state.isVisible!;

  set isVisible(bool value) {
    if (state.isVisible == value) return;

    state = state.copyWith(
      isVisible: value,
    );
  }

  void toggleLoading() => isLoading = !isLoading;

  void toggleVisibility() => isVisible = !isVisible;
}
