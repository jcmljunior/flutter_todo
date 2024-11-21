import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_todo/features/animated_button/states/animated_button_state.dart';
import 'package:flutter_todo/features/animated_button/stores/animated_button_store.dart';

void main() {
  test('toggleLoading deve atualizar o estado.', () {
    final AnimatedButtonStore animatedButtonStore =
        AnimatedButtonStore(const AnimatedButtonInitial());
    final isLoading = animatedButtonStore.isLoading;

    animatedButtonStore.toggleLoading();
    expect(animatedButtonStore.isLoading, !isLoading);
  });

  test('toggleVisibility deve atualizar o estado.', () {
    final AnimatedButtonStore animatedButtonStore =
        AnimatedButtonStore(const AnimatedButtonInitial());
    final isVisible = animatedButtonStore.isVisible;

    animatedButtonStore.toggleVisibility();
    expect(animatedButtonStore.isVisible, !isVisible);
  });
}
