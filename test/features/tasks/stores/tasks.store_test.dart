import 'package:flutter_todo/features/tasks/models/task.model.dart';
import 'package:flutter_todo/features/tasks/stores/tasks.store.dart';
import 'package:test/test.dart';

void main() {
  final task1 = TaskModel(
    id: 0,
    authorId: 0,
    title: 'Teste',
    content: 'descricão',
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
    isCompleted: false,
    isFavorite: false,
  );

  final task2 = TaskModel(
    id: 1,
    authorId: 0,
    title: 'Teste 2',
    content: 'descricão 2',
    createdAt: DateTime.now(),
    isCompleted: true,
    isFavorite: true,
  );

  group('Inicio do teste: TasksStore', () {
    test('Propriedade: completedTasks', () {
      final tasksStore = TasksStore();

      tasksStore.addTask(task1);
      tasksStore.addTask(task2);

      expect(tasksStore.completedTasks.length, 1);
      expect(tasksStore.completedTasks.contains(task2), true);
    });

    test('Propriedade: pendingTasks', () {
      final tasksStore = TasksStore();

      tasksStore.addTask(task1);
      tasksStore.addTask(task2);

      expect(tasksStore.pendingTasks.length, 1);
      expect(tasksStore.pendingTasks.contains(task1), true);
    });

    test('Propriedade: favoriteTasks', () {
      final tasksStore = TasksStore();

      tasksStore.addTask(task1);
      tasksStore.addTask(task2);

      expect(tasksStore.favoriteTasks.length, 1);
      expect(tasksStore.favoriteTasks.contains(task2), true);
      expect(tasksStore.favoriteTasks.first.isFavorite, true);
    });

    test('Método: addTask', () {
      final tasksStore = TasksStore();

      tasksStore.addTask(task1);

      expect(tasksStore.tasks.contains(task1), true);
    });

    test('Método: removeTask', () {
      final tasksStore = TasksStore();

      tasksStore.addTask(task1);
      tasksStore.removeTask(task1);

      expect(tasksStore.tasks.contains(task1), false);
    });

    test('Método: toggleTaskCompletion', () {
      final tasksStore = TasksStore();

      tasksStore.addTask(task1);
      tasksStore.toggleTaskCompletion(task1);

      expect(tasksStore.tasks.first.isCompleted, !task1.isCompleted!);
    });

    test('Método: toggleTaskFavorite', () {
      final tasksStore = TasksStore();

      tasksStore.addTask(task1);
      tasksStore.toggleTaskFavorite(task1);

      expect(tasksStore.tasks.first.isFavorite, !task1.isFavorite!);
    });
  });
}
