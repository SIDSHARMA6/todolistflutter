import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/task.dart';

class TaskViewModel extends GetxController {
  var tasks = <Task>[].obs;

  void addTask(String title, String description, int priority, DateTime dueDate, TimeOfDay reminderTime) {
    Task task = Task(
      title: title,
      description: description,
      priority: priority,
      dueDate: dueDate,
      reminderTime: reminderTime,
    );
    tasks.add(task);
  }

  void removeTask(Task task) {
    tasks.remove(task);
  }

  void updateTask(Task oldTask, Task newTask) {
    int index = tasks.indexOf(oldTask);
    if (index != -1) {
      tasks[index] = newTask;
    }
  }
}
