import 'package:flutter/material.dart';
import 'package:todo_list/screens/tasks_drawer.dart';
import 'package:todo_list/screens/pending_tasks_screen.dart';

import 'add_task_screen.dart';
import 'completed_tasks_screen.dart';
import 'favorite_tasks_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);
  static const id = 'tabs_screen';

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, dynamic>> _pageDetails = [
    {'pageName': const PendingTasksScreen(), 'title': 'Не сделано'},
    {'pageName': const CompletedTasksScreen(), 'title': 'Сделано'},
    {'pageName': const FavoriteTasksScreen(), 'title': 'Избранное'},
  ];

  var _selectedPageIndex = 0;

  void _addTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: const AddTaskScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageDetails[_selectedPageIndex]['title']),
        actions: [
          IconButton(
            onPressed: () {
              return _addTask(context);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      drawer: const TasksDrawer(),
      body: _pageDetails[_selectedPageIndex]['pageName'],
      floatingActionButton: _selectedPageIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                return _addTask(context);
              },
              tooltip: 'Add Task',
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: (index) {
          setState(() {
            _selectedPageIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.incomplete_circle_sharp),
            label: 'Не сделано',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done),
            label: 'Сделано',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Избранное',
          ),
        ],
      ),
    );
  }
}
