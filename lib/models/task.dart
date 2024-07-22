import 'package:flutter/material.dart';

class Task {
  String title;
  String description;
  int priority;
  DateTime dueDate;
  TimeOfDay reminderTime;

  Task({
    required this.title,
    required this.description,
    required this.priority,
    required this.dueDate,
    required this.reminderTime,
  });
}
