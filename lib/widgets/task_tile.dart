import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/widgets/popup_menu.dart';
import '../blocs/bloc_exports.dart';
import '../models/task.dart';
import '../screens/edit_task_screen.dart';

class TaskTile extends StatefulWidget {
  const TaskTile({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  void _removeOrDeleteTask(BuildContext ctx, Task task) {
    task.isDeleted!
        ? ctx.read<TasksBloc>().add(DeleteTask(task: task))
        : ctx.read<TasksBloc>().add(RemoveTask(task: task));
  }

  void _editTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: EditTaskScreen(oldTask: widget.task),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                widget.task.isFavorite == false
                    ? const Icon(Icons.star_outline)
                    : const Icon(Icons.star),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.task.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 18,
                            decoration: widget.task.isDone!
                                ? TextDecoration.lineThrough
                                : null),
                      ),
                      Text(
                        DateFormat('dd-MM-yyyy HH:mm:ss')
                            //.add_yMEd()
                            .format(
                          DateTime.parse(widget.task.date),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Checkbox(
                value: widget.task.isDone,
                onChanged: widget.task.isDeleted == false
                    ? (value) {
                        return context
                            .read<TasksBloc>()
                            .add(UpdateTask(task: widget.task));
                      }
                    : null,
              ),
              PopupMenu(
                task: widget.task,
                cancelOrDeleteCallback: () {
                  _removeOrDeleteTask(context, widget.task);
                },
                likeOrDislikeCallback: () {
                  return context
                      .read<TasksBloc>()
                      .add(MarkFavoriteOrUnfavoriteTask(task: widget.task));
                },
                editTaskCallback: () {
                  Navigator.of(context).pop();
                  return _editTask(context);
                },
                restoreTaskCallback: () {
                  return context
                      .read<TasksBloc>()
                      .add(RestoreTask(task: widget.task));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}



// ListTile(
//       title: Text(
//         task.title,
//         overflow: TextOverflow.ellipsis,
//         style: TextStyle(
//             decoration: task.isDone! ? TextDecoration.lineThrough : null),
//       ),
//       trailing: Checkbox(
//         value: task.isDone,
//         onChanged: task.isDeleted == false
//             ? (value) {
//                 context.read<TasksBloc>().add(UpdateTask(task: task));
//               }
//             : null,
//       ),
//       onLongPress: () {
//         _removeOrDeleteTask(context, task);
//       },
//     );