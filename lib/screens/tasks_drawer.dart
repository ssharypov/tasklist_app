import 'package:flutter/material.dart';
import 'package:todo_list/screens/recycle_bin.dart';
import 'package:todo_list/screens/tabs_screen.dart';

import '../blocs/bloc_exports.dart';

class TasksDrawer extends StatelessWidget {
  const TasksDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              color: Colors.grey,
              child: Text(
                'Список задач',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            BlocBuilder<TasksBloc, TasksState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed(TabsScreen.id);
                  },
                  child: ListTile(
                    leading: const Icon(Icons.folder_special),
                    title: const Text('Задачи'),
                    trailing: Text(
                        '${state.pendingTasks.length} | ${state.completedTasks.length}'),
                  ),
                );
              },
            ),
            const Divider(),
            BlocBuilder<TasksBloc, TasksState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed(RecycleBin.id);
                  },
                  child: ListTile(
                    leading: const Icon(Icons.delete),
                    title: const Text('Корзина'),
                    trailing: Text('${state.removedTasks.length}'),
                  ),
                );
              },
            ),
            BlocBuilder<SwitchBloc, SwitchState>(
              builder: (context, state) {
                return ListTile(
                  leading: const Icon(Icons.dark_mode),
                  title: const Text('Ночной режим'),
                  trailing: Switch(
                    value: state.switchValue,
                    onChanged: (newValue) {
                      newValue
                          ? context.read<SwitchBloc>().add(SwitchOnEvent())
                          : context.read<SwitchBloc>().add(SwitchOffEvent());
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
