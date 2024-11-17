import 'package:flutter/material.dart';

import '../constants/animated_button_constant.dart';
import '../states/animated_button_state.dart';
import '../stores/floating_action_button_store.dart';

@immutable
class FloatingActionButtonWidget extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final void Function(FloatingActionButtonWidgetState)? onFabStateCreated;

  const FloatingActionButtonWidget({
    super.key,
    required this.child,
    this.onPressed,
    this.onFabStateCreated,
  });

  @override
  State<FloatingActionButtonWidget> createState() =>
      FloatingActionButtonWidgetState();
}

class FloatingActionButtonWidgetState extends State<FloatingActionButtonWidget>
    with SingleTickerProviderStateMixin {
  final FloatingActionButtonStore animatedButtonStore =
      FloatingActionButtonStore(
    const AnimatedButtonInitial(),
  );
  late final AnimationController fabController;
  late final Animation<Offset> fabAnimation;

  static const _animationDuration =
      Duration(milliseconds: AnimatedButtonConstant.defaultAnimationDuration);
  static const _animationCurve = Curves.fastOutSlowIn;

  @override
  void initState() {
    super.initState();

    setFabController();
    setFabAnimation();

    widget.onFabStateCreated?.call(this);
  }

  @override
  void dispose() {
    fabController.dispose();

    super.dispose();
  }

  void setFabController() {
    fabController = AnimationController(
      vsync: this,
      duration: _animationDuration,
    );
  }

  void setFabAnimation() {
    fabAnimation = Tween<Offset>(
      begin: const Offset(0, 2),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: fabController,
        curve: _animationCurve,
      ),
    );
  }

  Future<void> toggleFabAnimation() async {
    switch (fabController.status) {
      case AnimationStatus.completed:
        await fabController.reverse();
        break;

      default:
        fabController.forward();
        break;
    }

    animatedButtonStore.toggleVisibility();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        animatedButtonStore,
        fabController,
      ]),
      builder: (context, _) {
        return Visibility(
          visible: animatedButtonStore.isVisible,
          child: AnimatedContainer(
            duration: _animationDuration,
            child: SlideTransition(
              key: ValueKey<bool>(fabController.isCompleted),
              position: fabAnimation,
              child: FloatingActionButton(
                onPressed: widget.onPressed,
                child: widget.child,
              ),
            ),
          ),
        );
      },
    );
  }
}
