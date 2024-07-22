import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../viewmodels/task_view_model.dart';


class TaskFormView extends StatelessWidget {
  final TaskViewModel taskViewModel = Get.find();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final RxInt priority = 1.obs;
  final Rx<DateTime> dueDate = DateTime.now().obs;
  final Rx<TimeOfDay> reminderTime = TimeOfDay.now().obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            DropdownButton<int>(
              value: priority.value,
              items: [
                DropdownMenuItem(child: Text('Low'), value: 1),
                DropdownMenuItem(child: Text('Medium'), value: 2),
                DropdownMenuItem(child: Text('High'), value: 3),
              ],
              onChanged: (value) {
                priority.value = value!;
              },
            ),
            Obx(() {
              return TextButton(
                onPressed: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: dueDate.value,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null && picked != dueDate.value) {
                    dueDate.value = picked;
                  }
                },
                child: Text('Due Date: ${dueDate.value.toLocal()}'.split(' ')[0]),
              );
            }),
            Obx(() {
              return TextButton(
                onPressed: () async {
                  TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: reminderTime.value,
                  );
                  if (picked != null && picked != reminderTime.value) {
                    reminderTime.value = picked;
                  }
                },
                child: Text('Reminder Time: ${reminderTime.value.format(context)}'),
              );
            }),
            ElevatedButton(
              onPressed: () {
                taskViewModel.addTask(
                  titleController.text,
                  descriptionController.text,
                  priority.value,
                  dueDate.value,
                  reminderTime.value,
                );
                Get.back();
              },
              child: Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }
}
