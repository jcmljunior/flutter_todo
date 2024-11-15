import 'package:flutter/foundation.dart';

import '../../value_notifier/extensions/value_notifier_extension.dart';
import '../models/task_model.dart';
import '../states/tasks_state.dart';

class TasksStore extends ValueNotifier<TasksState> {
  TasksStore(super.value);

  bool get isLoading => state.isLoading!;

  set isLoading(bool value) {
    if (state.isLoading == value) return;

    state = state.copyWith(
      isLoading: value,
    );
  }

  List<TaskModel> get tasks => state.tasks!;

  set tasks(List<TaskModel> value) {
    if (state.tasks == value) return;

    state = state.copyWith(
      tasks: value,
    );
  }

  int get currentDayOfWeek => state.currentDayOfWeek!;

  set currentDayOfWeek(int value) {
    if (state.currentDayOfWeek == value) return;

    state = state.copyWith(
      currentDayOfWeek: value,
    );
  }

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

  Future<void> changeCurrentDayOfWeekHandler(int value) async {
    isLoading = true;

    try {
      state = state.copyWith(
        currentDayOfWeek: value,
      );
    } finally {
      isLoading = false;
    }
  }
}
