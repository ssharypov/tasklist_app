import 'package:flutter/material.dart';

import '../models/task.dart';

class PopupMenu extends StatelessWidget {
  const PopupMenu({
    Key? key,
    required this.cancelOrDeleteCallback,
    required this.likeOrDislikeCallback,
    required this.editTaskCallback,
    required this.restoreTaskCallback,
    required this.task,
  }) : super(key: key);

  final Task task;
  final VoidCallback cancelOrDeleteCallback;
  final VoidCallback likeOrDislikeCallback;
  final VoidCallback editTaskCallback;
  final VoidCallback restoreTaskCallback;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: task.isDeleted == false
          ? ((context) => [
                PopupMenuItem(
                  onTap: null,
                  enabled: task.isDone == false ? true : false,
                  child: TextButton.icon(
                    onPressed: task.isDone == false ? editTaskCallback : null,
                    icon: const Icon(Icons.edit),
                    label: const Text('Изменить'),
                  ),
                ),
                PopupMenuItem(
                  onTap: likeOrDislikeCallback,
                  child: TextButton.icon(
                    onPressed: null,
                    icon: task.isFavorite == false
                        ? const Icon(Icons.bookmark_add_outlined)
                        : const Icon(Icons.bookmark_remove),
                    label: task.isFavorite == false
                        ? const Text('Добавить в\nизбранное')
                        : const Text('Убрать из\nизбранного'),
                  ),
                ),
                PopupMenuItem(
                  onTap: cancelOrDeleteCallback,
                  child: TextButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.delete),
                    label: const Text('Удалить в\nкорзину'),
                  ),
                ),
              ])
          : (context) => [
                PopupMenuItem(
                  onTap: restoreTaskCallback,
                  child: TextButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.restore),
                    label: const Text('Восстановить'),
                  ),
                ),
                PopupMenuItem(
                  onTap: cancelOrDeleteCallback,
                  child: TextButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.delete_forever),
                    label: const Text('Удалить навсегда'),
                  ),
                ),
              ],
    );
  }
}
