import 'package:flutter/widgets.dart';
import '../stores/custom_animated_widget_store.dart';
import '../widgets/custom_animated_widget.dart';

mixin CustomAnimatedWidgetMixin on State<CustomAnimatedWidget> {
  CustomAnimatedWidgetStore get store;
  AnimationController get controller;

  Future<void> toggleAnimation() async {
    store.toggleLoading();

    // Simulação de um carregamento assíncrono.
    await Future.delayed(const Duration(milliseconds: 1000));

    switch (controller.status) {
      case AnimationStatus.completed:
        await controller.reverse();
        break;

      default:
        controller.forward();
    }

    store.toggleVisibility();
    store.toggleLoading();
  }
}
