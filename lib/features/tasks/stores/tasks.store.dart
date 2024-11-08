import 'package:flutter/foundation.dart';

import '../../value_notifier/extensions/value_notifier.extension.dart';
import '../models/task.model.dart';
import '../states/tasks.state.dart';

class TasksStore extends ValueNotifier<TasksState> {
  TasksStore() : super(const Tasks());

  bool get isLoading => state.isLoading!;

  set isLoading(bool value) {
    if (state.isLoading == value) return;

    state = state.copyWith(
      isLoading: value,
    );
  }

  set tasks(List<TaskModel> value) {
    if (state.tasks == value) return;

    state = state.copyWith(
      tasks: value,
    );
  }

  List<TaskModel> get tasks => state.tasks!;

  List<TaskModel> get pendingTasks =>
      tasks.where((task) => !task.isCompleted!).toList();

  List<TaskModel> get completedTasks =>
      tasks.where((task) => task.isCompleted!).toList();

  List<TaskModel> get favoriteTasks =>
      tasks.where((task) => task.isFavorite!).toList();

  Future<void> addTask(TaskModel task) async {
    isLoading = true;

    try {
      state = state.copyWith(tasks: [
        ...tasks,
        task,
      ]);
    } finally {
      isLoading = false;
    }
  }

  Future<void> removeTask(TaskModel task) async {
    isLoading = true;

    try {
      state = state.copyWith(
        tasks: tasks.where((t) => t.id != task.id).toList(),
      );
    } finally {
      isLoading = false;
    }
  }

  Future<void> toggleTaskCompletion(TaskModel task) async {
    isLoading = true;

    try {
      state = state.copyWith(
        tasks: [
          ...tasks.map((t) => t.id == task.id
              ? task.copyWith(isCompleted: !task.isCompleted!)
              : t),
        ],
      );
    } finally {
      isLoading = false;
    }
  }

  Future<void> toggleTaskFavorite(TaskModel task) async {
    isLoading = true;

    try {
      state = state.copyWith(
        tasks: [
          ...tasks.map((t) => t.id == task.id
              ? task.copyWith(isFavorite: !task.isFavorite!)
              : t),
        ],
      );
    } finally {
      isLoading = false;
    }
  }

  // List<TaskModel> sortTasksByCompletion(List<TaskModel> value) {
  //   return value.toList()
  //     ..sort((TaskModel a, TaskModel b) {
  //       if (a.isCompleted! && !b.isCompleted!) {
  //         return 1;
  //       } else if (!a.isCompleted! && b.isCompleted!) {
  //         return -1;
  //       }
  //
  //       return 0;
  //     });
  // }

  // List<TaskModel> sortTasksByFavorite(List<TaskModel> value) {
  //   return value.toList()
  //     ..sort((TaskModel a, TaskModel b) {
  //       if (a.isFavorite! && !b.isFavorite!) {
  //         return 1;
  //       } else if (!a.isFavorite! && b.isFavorite!) {
  //         return -1;
  //       } else {
  //         return 0;
  //       }
  //     });
  // }
  //
  // List<TaskModel> sortTasksByDate(List<TaskModel> value) {
  //   return value.toList()
  //     ..sort((TaskModel a, TaskModel b) {
  //       return a.createdAt!.compareTo(b.createdAt!);
  //     });
  // }
}
