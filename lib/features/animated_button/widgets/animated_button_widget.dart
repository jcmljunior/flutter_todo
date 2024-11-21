import 'package:flutter/material.dart';

import '../constants/animated_button_constant.dart';
import '../states/animated_button_state.dart';
import '../stores/animated_button_store.dart';

@immutable
class AnimatedButtonWidget extends StatefulWidget {
  final void Function(AnimatedButtonWidgetState)? onInitState;
  final Widget Function(BuildContext, AnimatedButtonWidgetState?) builder;

  const AnimatedButtonWidget({
    super.key,
    this.onInitState,
    required this.builder,
  });

  @override
  State<AnimatedButtonWidget> createState() => AnimatedButtonWidgetState();
}

class AnimatedButtonWidgetState extends State<AnimatedButtonWidget>
    with SingleTickerProviderStateMixin {
  late final AnimatedButtonStore _store;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    onInitState();
    setStore();
    setController();
  }

  @override
  dispose() {
    _store.dispose();
    _controller.dispose();

    super.dispose();
  }

  AnimatedButtonStore get store => _store;

  AnimationController get controller => _controller;

  void onInitState() {
    if (widget.onInitState == null) {
      return WidgetsBinding.instance.addPostFrameCallback((_) {
        toggleAnimation();
      });
    }

    widget.onInitState!.call(this);
  }

  void setStore() {
    _store = AnimatedButtonStore(
      const AnimatedButtonInitial(),
    );
  }

  void setController() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
          milliseconds: AnimatedButtonConstant.defaultAnimationDuration),
    );
  }

  Future<void> toggleAnimation() async {
    _store.toggleLoading();

    await Future.delayed(const Duration(milliseconds: 2000));

    switch (_controller.status) {
      case AnimationStatus.completed:
        await _controller.reverse();
        break;

      default:
        _controller.forward();
        break;
    }

    _store.toggleVisibility();
    _store.toggleLoading();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _store,
        _controller,
      ]),
      builder: (context, _) => Visibility(
        visible: _store.isVisible,
        child: widget.builder(
          context,
          this,
        ),
      ),
    );
  }
}
