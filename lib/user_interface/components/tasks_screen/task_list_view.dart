import 'package:exam_training/user_interface/components/tasks_screen/task_card.dart';
import 'package:flutter/material.dart';
import '../../../data/models/_models.dart';

class TaskListView extends StatelessWidget {
  final List<Task> tasks;

  const TaskListView({Key? key, required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 20),
      itemBuilder: (context, index) => TaskCard(task: tasks[index]),
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemCount: tasks.length,
      shrinkWrap: true,
    );
  }
}
