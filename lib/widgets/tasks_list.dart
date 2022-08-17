import 'package:flutter/material.dart';
import 'package:todo_list/widgets/task_tile.dart';
import '../models/task.dart';

class TasksList extends StatelessWidget {
  const TasksList({
    Key? key,
    required this.tasksList,
  }) : super(key: key);

  final List<Task> tasksList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: ExpansionPanelList.radio(
          children: tasksList
              .map(
                (task) => ExpansionPanelRadio(
                  value: task.id,
                  headerBuilder: (context, isOpen) => TaskTile(task: task),
                  body: ListTile(
                    title: SelectableText.rich(
                      TextSpan(children: [
                        const TextSpan(
                          text: 'Задача:\n',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(text: task.title),
                        const TextSpan(
                          text: '\nПодробнее:\n',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(text: task.description),
                      ]),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}


// Expanded(
//       child: ListView.builder(
//         itemCount: tasksList.length,
//         itemBuilder: (context, index) {
//           var task = tasksList[index];
//           return TaskTile(task: task);
//         },
//       ),
//     );