import 'package:flutter/material.dart';

import '../models/task.model.dart';
import '../stores/tasks.store.dart';

@immutable
class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  final store = TasksStore();
  final GlobalKey<AnimatedListState> _pendingListKey =
      GlobalKey<AnimatedListState>();
  final GlobalKey<AnimatedListState> _completedListKey =
      GlobalKey<AnimatedListState>();

  // late final AnimationController _controller;
  // late final Animation<double> _animation;

  // @override
  // void initState() {
  //   super.initState();
  //
  //   _controller = AnimationController(
  //     vsync: this,
  //     duration: const Duration(milliseconds: 500),
  //   );
  //   _animation = Tween(begin: 0.0, end: 1.0).animate(_controller).drive(
  //         CurveTween(
  //           curve: Curves.easeInOutCubic,
  //         ),
  //       );
  // }

  @override
  void dispose() {
    store.dispose();

    super.dispose();
  }

  void _toggleCompletedList(TaskModel task) {
    // Encontra a posição da tarefa atual na lista de pendentes ou concluídas.
    final insertIndex = task.isCompleted!
        ? store.pendingTasks.indexWhere((t) => t.id! > task.id!)
        : store.completedTasks.indexWhere((t) => t.id! > task.id!);

    if (task.isCompleted!) {
      // Remove a tarefa atual da lista de concluídas.
      _completedListKey.currentState?.removeItem(
        store.completedTasks.indexOf(task),
        (context, animation) => _buildTaskItem(task, animation),
      );

      // Insere a tarefa atual na lista de pendentes.
      _pendingListKey.currentState?.insertItem(
        insertIndex != -1 ? insertIndex : store.pendingTasks.length,
      );
    } else {
      // Remove a tarefa atual da lista de pendentes.
      _pendingListKey.currentState?.removeItem(
        store.pendingTasks.indexOf(task),
        (context, animation) => _buildTaskItem(task, animation),
      );

      // Insere a tarefa atual na lista de concluídas.
      _completedListKey.currentState?.insertItem(
        insertIndex != -1 ? insertIndex : store.completedTasks.length,
      );
    }

    // Atualiza o estado da tarefa para concluída.
    store.toggleTaskCompletion(task);
  }

  void _removeTask(TaskModel task) {
    if (task.isCompleted!) {
      _completedListKey.currentState?.removeItem(
        store.completedTasks.indexOf(task),
        (context, animation) => _buildTaskItem(task, animation),
      );
    } else {
      _pendingListKey.currentState?.removeItem(
        store.pendingTasks.indexOf(task),
        (context, animation) => _buildTaskItem(task, animation),
      );
    }

    store.removeTask(task);
  }

  Widget _buildTaskItem(TaskModel task, Animation<double> animation) {
    return SizeTransition(
      axis: Axis.vertical,
      sizeFactor: animation,
      child: ListTile(
        title: Text(task.title!),
        subtitle: Text(task.content!),
        leading: Checkbox(
          value: task.isCompleted,
          onChanged: (_) => _toggleCompletedList(task),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => _removeTask(task),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: AnimatedBuilder(
        animation: store,
        builder: (context, child) => FloatingActionButton(
          onPressed: () async {
            await store.addTask(
              TaskModel(
                id: store.tasks.isEmpty ? 0 : store.tasks.last.id! + 1,
                authorId: 1,
                title:
                    'Tarefa ${store.tasks.isEmpty ? 0 : store.tasks.last.id! + 1}',
                content:
                    'Conteudo da tarefa ${store.tasks.isEmpty ? 0 : store.tasks.last.id! + 1}',
                isFavorite: false,
                isCompleted: false,
                createdAt: DateTime.now(),
              ),
            );

            _pendingListKey.currentState?.insertItem(
              store.pendingTasks.length - 1,
            );
          },
          child: Icon(!store.isLoading ? Icons.add : Icons.hourglass_bottom),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                Text('Pendentes',
                    style: Theme.of(context).textTheme.headlineLarge),
                Expanded(
                  child: AnimatedBuilder(
                    animation: store,
                    builder: (context, child) => AnimatedList(
                      key: _pendingListKey,
                      initialItemCount: store.pendingTasks.length,
                      itemBuilder: (context, index, animation) {
                        return _buildTaskItem(
                            store.pendingTasks.elementAt(index), animation);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: Column(
              children: [
                Text('Concluídas',
                    style: Theme.of(context).textTheme.headlineLarge),
                Expanded(
                  child: AnimatedBuilder(
                    animation: store,
                    builder: (context, child) => AnimatedList(
                      key: _completedListKey,
                      initialItemCount: store.completedTasks.length,
                      itemBuilder: (context, index, animation) {
                        return _buildTaskItem(
                            store.completedTasks.elementAt(index), animation);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
