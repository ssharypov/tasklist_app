import 'package:flutter/material.dart';
import 'package:todo_list/blocs/bloc_exports.dart';
import 'package:uuid/uuid.dart';

import '../models/task.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            'Создать задачу',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: TextField(
              autofocus: true,
              controller: titleController,
              decoration: const InputDecoration(
                label: Text('Задача'),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: TextField(
              autofocus: true,
              controller: descriptionController,
              minLines: 2,
              maxLines: 5,
              decoration: const InputDecoration(
                label: Text('Подробнее'),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Отмена'),
              ),
              ElevatedButton(
                onPressed: () {
                  // ignore: prefer_const_constructors
                  var uuid = Uuid();
                  var task = Task(
                    title: titleController.text,
                    description: descriptionController.text,
                    id: uuid.v1(),
                    date: DateTime.now().toString(),
                  );
                  context.read<TasksBloc>().add(AddTask(task: task));
                  Navigator.pop(context);
                },
                child: const Text('Создать'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
