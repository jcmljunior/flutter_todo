import 'package:flutter/material.dart';

import '../stores/tasks.store.dart';

@immutable
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final store = TasksStore();

  late final List<AnimationController> _animationControllers;
  late final List<Animation<Offset>> _animations;

  @override
  void initState() {
    super.initState();

    setAnimationControllers();
    setAnimations();
  }

  @override
  void dispose() {
    for (AnimationController controller in _animationControllers) {
      controller.dispose();
    }

    super.dispose();
  }

  void setAnimationControllers() {
    _animationControllers = [
      for (int i = 0; i < store.tasks.length; i++)
        AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 500),
        ),
    ];
  }

  void setAnimations() {
    _animations = [
      for (int i = 0; i < store.tasks.length; i++)
        Tween<Offset>(
          begin: const Offset(0, 0),
          end: const Offset(0, 1),
        ).animate(_animationControllers[i]),
    ];
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('${_animationControllers.length}');

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(),
        ],
      ),
    );
  }
}
