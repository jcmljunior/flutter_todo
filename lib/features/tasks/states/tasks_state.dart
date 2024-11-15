import 'package:flutter/material.dart' show immutable;

import '../models/task_model.dart';

@immutable
sealed class TasksState {
  final bool? isLoading;
  final int? currentDayOfWeek;
  final List<TaskModel>? tasks;

  const TasksState({
    this.isLoading,
    this.currentDayOfWeek,
    this.tasks,
  })  : assert(
          isLoading != null,
          'isLoading must not be null',
        ),
        assert(
          currentDayOfWeek != null,
          'currentDayOfWeek must not be null',
        ),
        assert(
          tasks != null,
          'tasks must not be null',
        );

  TasksState copyWith({
    bool? isLoading,
    int? currentDayOfWeek,
    List<TaskModel>? tasks,
  });
}

class TasksInitial extends TasksState {
  const TasksInitial({
    bool? isLoading,
    List<TaskModel>? tasks,
    super.currentDayOfWeek,
  }) : super(
          isLoading: isLoading ?? false,
          tasks: tasks ?? const <TaskModel>[],
        );

  @override
  TasksState copyWith({
    bool? isLoading,
    int? currentDayOfWeek,
    List<TaskModel>? tasks,
  }) =>
      TasksInitial(
        isLoading: isLoading ?? this.isLoading,
        currentDayOfWeek: currentDayOfWeek ?? this.currentDayOfWeek,
        tasks: tasks ?? this.tasks,
      );
}
