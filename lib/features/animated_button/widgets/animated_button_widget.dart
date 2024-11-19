import 'package:flutter/material.dart';

import '../constants/animated_button_constant.dart';
import '../states/animated_button_state.dart';
import '../stores/animated_button_store.dart';

@immutable
class AnimatedButtonWidget extends StatefulWidget {
  // Solução alternativa ao uso do globalKey. Melhor performance.
  // final GlobalKey<AnimatedButtonWidgetState> key = GlobalKey();
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
    switch (_controller.status) {
      case AnimationStatus.completed:
        await _controller.reverse();
        break;

      default:
        _controller.forward();
        break;
    }

    _store.toggleVisibility();
  }

  Widget useSlideTrasition(Widget child,
          {Offset begin = const Offset(0, 2),
          Offset end = const Offset(0, 0)}) =>
      SlideTransition(
        key: ValueKey<bool>(_controller.isCompleted),
        position: Tween<Offset>(
          begin: begin,
          end: end,
        ).animate(_controller),
        child: child,
      );

  Widget useScaleTransition(Widget child,
          {required Animatable<double> curve}) =>
      ScaleTransition(
        key: ValueKey<bool>(_controller.isCompleted),
        scale: _controller.drive(curve),
        child: child,
      );

  Widget useFadeTransition(Widget child, {required Animatable<double> curve}) =>
      FadeTransition(
        key: ValueKey<bool>(_controller.isCompleted),
        opacity: _controller.drive(curve),
        child: child,
      );

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
