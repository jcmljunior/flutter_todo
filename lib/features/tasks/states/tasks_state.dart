import 'package:flutter/material.dart' show immutable;

import '../models/task_model.dart';

@immutable
sealed class TasksState {
  final bool? isLoading;
  final List<TaskModel>? tasks;

  const TasksState({
    this.isLoading,
    this.tasks,
  });

  TasksState copyWith({
    bool? isLoading,
    List<TaskModel>? tasks,
  });
}

class TasksInitial extends TasksState {
  const TasksInitial({
    bool? isLoading,
    List<TaskModel>? tasks,
  }) : super(
          isLoading: isLoading ?? false,
          tasks: tasks ?? const <TaskModel>[],
        );

  @override
  TasksState copyWith({
    bool? isLoading,
    List<TaskModel>? tasks,
  }) =>
      TasksInitial(
        isLoading: isLoading ?? this.isLoading,
        tasks: tasks ?? this.tasks,
      );
}
