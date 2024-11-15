import 'package:test/test.dart';

import 'package:flutter_todo/features/tasks/models/task_model.dart';
import 'package:flutter_todo/features/tasks/states/tasks_state.dart';
import 'package:flutter_todo/features/tasks/stores/tasks_store.dart';

import '../mocks/mock_task.dart';

void main() {
  final List<TaskModel> tasks = MockTasks.generateTasks();

  test('TasksStore deve iniciar com uma lista de tarefas vazia', () {
    final tasksStore = TasksStore(
      TasksInitial(
        currentDayOfWeek: DateTime.now().day,
      ),
    );
    expect(tasksStore.tasks, isEmpty,
        reason: 'A lista de tarefas deve estar vazia');
  });

  test('addTask deve adicionar uma tarefa à lista de tarefas', () {
    final tasksStore = TasksStore(
      TasksInitial(
        currentDayOfWeek: DateTime.now().day,
      ),
    );

    tasksStore.addTask(tasks.first);

    expect(tasksStore.tasks, contains(tasks.first),
        reason: 'A lista de tarefas deve conter [tasks.first]');
    expect(tasksStore.tasks.length, equals(1),
        reason: 'O tamanho da lista deve ser 1');
  });

  test('removeTask deve remover uma tarefa da lista de tarefas', () {
    final tasksStore = TasksStore(
      TasksInitial(
        currentDayOfWeek: DateTime.now().day,
      ),
    );

    tasksStore.addTask(tasks.first);
    tasksStore.removeTask(tasks.first);

    expect(tasksStore.tasks, isNot(contains(tasks.first)),
        reason: 'A lista de tarefas não deve conter [tasks.first]');
    expect(tasksStore.tasks.length, equals(0),
        reason: 'O tamanho da lista deve ser 0');
  });

  test('toggleTaskCompletion deve alterar o status de conclusão de uma tarefa',
      () {
    final tasksStore = TasksStore(
      TasksInitial(
        currentDayOfWeek: DateTime.now().day,
      ),
    );

    tasksStore.addTask(tasks.first);
    tasksStore.toggleTaskCompletion(tasks.first);

    expect(
        tasksStore.tasks.first.isCompleted, equals(!tasks.first.isCompleted!),
        reason: 'O status de conclusão da tarefa deve ser true');
  });

  test('toggleTaskFavorite deve alterar o status de favorito de uma tarefa',
      () {
    final tasksStore = TasksStore(
      TasksInitial(
        currentDayOfWeek: DateTime.now().day,
      ),
    );

    tasksStore.addTask(tasks.first);
    tasksStore.toggleTaskFavorite(tasks.first);

    expect(tasksStore.tasks.first.isFavorite, equals(!tasks.first.isFavorite!),
        reason: 'O status de favorito da tarefa deve ser true');
  });

  test('tasks setter deve atualizar a lista de tarefas', () {
    final tasksStore = TasksStore(
      TasksInitial(
        currentDayOfWeek: DateTime.now().day,
      ),
    );

    tasksStore.tasks = tasks;

    expect(tasksStore.tasks, equals(tasks),
        reason: 'A lista de tarefas deve ser atualizada');
  });

  test('currentDayOfWeek setter deve atualizar o dia da semana atual', () {
    final tasksStore = TasksStore(
      TasksInitial(
        currentDayOfWeek: DateTime.now().day,
      ),
    );

    tasksStore.currentDayOfWeek = DateTime.now().day;

    expect(tasksStore.currentDayOfWeek, equals(DateTime.now().day),
        reason: 'O dia da semana atual deve ser atualizado');
  });

  test('changeCurrentDayOfWeekHandler deve atualizar o dia da semana atual',
      () {
    final tasksStore = TasksStore(
      TasksInitial(
        currentDayOfWeek: DateTime.now().subtract(const Duration(days: 1)).day,
      ),
    );

    tasksStore.changeCurrentDayOfWeekHandler(DateTime.now().day);

    expect(tasksStore.currentDayOfWeek, equals(DateTime.now().day),
        reason: 'O dia da semana atual deve ser atualizado');
  });
}
