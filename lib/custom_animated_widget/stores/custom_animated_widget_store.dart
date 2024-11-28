import 'package:flutter/foundation.dart';
import '../../features/value_notifier/extensions/value_notifier_extension.dart';
import '../states/custom_animated_widget_state.dart';

class CustomAnimatedWidgetStore
    extends ValueNotifier<CustomAnimatedWidgetStoreState> {
  CustomAnimatedWidgetStore(super.value);

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
