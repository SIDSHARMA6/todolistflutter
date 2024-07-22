import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/task.dart';
import '../viewmodels/task_view_model.dart';


class TaskCard extends StatelessWidget {
  final Task task;

  TaskCard({required this.task});

  @override
  Widget build(BuildContext context) {
    final TaskViewModel taskViewModel = Get.find();

    return Card(
      child: ListTile(
        title: Text(task.title),
        subtitle: Text(task.description),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                // Add edit functionality
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                taskViewModel.removeTask(task);
              },
            ),
          ],
        ),
      ),
    );
  }
}
