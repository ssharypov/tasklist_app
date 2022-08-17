import 'package:flutter/material.dart';
import 'package:todo_list/widgets/tasks_list.dart';

import '../blocs/bloc_exports.dart';
import 'tasks_drawer.dart';

class RecycleBin extends StatelessWidget {
  const RecycleBin({Key? key}) : super(key: key);
  static const id = 'recycle_bin_screen';
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Корзина'),
            actions: [
              PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    onTap: (() =>
                        context.read<TasksBloc>().add(DeleteAllTasks())),
                    child: TextButton.icon(
                      onPressed: null,
                      icon: const Icon(Icons.delete_forever),
                      label: const Text('Очистить корзину'),
                    ),
                  ),
                ],
              ),
            ],
          ),
          drawer: const TasksDrawer(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Chip(
                  label: Text(
                    'Задач: ${state.removedTasks.length}',
                  ),
                ),
              ),
              TasksList(tasksList: state.removedTasks),
            ],
          ),
        );
      },
    );
  }
}
