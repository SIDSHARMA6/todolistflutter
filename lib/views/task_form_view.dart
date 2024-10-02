import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../TimeCheckerController.dart';
import '../models/task.dart';
import '../viewmodels/task_view_model.dart';


class TaskFormView extends StatelessWidget {
  final TaskViewModel taskViewModel = Get.find();
  final TimeCheckerController timeCheckerController = Get.find();
  final Task? task;

  // Controllers and observables
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final RxInt priority = 1.obs;
  final Rx<DateTime> dueDate = DateTime.now().obs;
  final Rx<TimeOfDay> reminderTime = TimeOfDay.now().obs;

  TaskFormView({Key? key, this.task})
      : titleController = TextEditingController(text: task?.title ?? ''),
        descriptionController = TextEditingController(text: task?.description ?? ''),
        super(key: key) {
    // Set initial values if editing
    if (task != null) {
      priority.value = task!.priority;
      dueDate.value = task!.dueDate;
      reminderTime.value = task!.reminderTime;
    }
  }

  void _addOrUpdateTask() {
    if (task == null) {
      // Add task
      final newTask = Task(
        title: titleController.text,
        description: descriptionController.text,
        priority: priority.value,
        dueDate: dueDate.value,
        reminderTime: reminderTime.value,
      );
      taskViewModel.addTask(
        titleController.text,
        descriptionController.text,
        priority.value,
        dueDate.value,
        reminderTime.value,
      );
      timeCheckerController.tasks.add(newTask);
    } else {
      // Update task
      Task updatedTask = Task(
        title: titleController.text,
        description: descriptionController.text,
        priority: priority.value,
        dueDate: dueDate.value,
        reminderTime: reminderTime.value,
      );
      taskViewModel.updateTask(task!, updatedTask);
      timeCheckerController.tasks.remove(task);
      timeCheckerController.tasks.add(updatedTask);
    }
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task == null ? 'Add Task' : 'Edit Task', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<int>(
                value: priority.value,
                items: const [
                  DropdownMenuItem(child: Text('Low'), value: 1),
                  DropdownMenuItem(child: Text('Medium'), value: 2),
                  DropdownMenuItem(child: Text('High'), value: 3),
                ],
                decoration: const InputDecoration(
                  labelText: 'Priority',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  priority.value = value!;
                },
              ),
              SizedBox(height: 10),
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
                  child: Text(
                    'Due Date: ${dueDate.value.toLocal()}'.split(' ')[0],
                    style: const TextStyle(
                      color: Colors.black,
                    ),

                  ),
                );
              }),
              SizedBox(height: 10),
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
                  child: Text(
                    'Reminder Time: ${reminderTime.value.format(context)}',
                style: const TextStyle(
                color: Colors.black,
                ),
                  ),
                );
              }),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addOrUpdateTask,
                child: Text(
                  task == null ? 'Add Task' : 'Update Task',
                  style: const TextStyle(
                    color: Colors.white, // Set text color to white
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,

                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
