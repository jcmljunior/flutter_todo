import 'package:flutter/material.dart' show immutable;

import '../models/task.model.dart';

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

// Inicialização do estado de tarefas.
class Tasks extends TasksState {
  const Tasks({
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
      Tasks(
        isLoading: isLoading ?? this.isLoading,
        tasks: tasks ?? this.tasks,
      );
}
