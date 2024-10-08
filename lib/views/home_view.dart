import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../viewmodels/task_view_model.dart';
import 'task_form_view.dart';
import '../widgets/task_card.dart';

class HomeView extends StatelessWidget {
  final TaskViewModel taskViewModel = Get.put(TaskViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDoList', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: taskViewModel.tasks.length,
          itemBuilder: (context, index) {
            return TaskCard(task: taskViewModel.tasks[index]);
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(TaskFormView());
        },
        child: const Icon(Icons.add,color: Colors.white,),
        backgroundColor: Colors.black,
      ),
    );
  }
}
