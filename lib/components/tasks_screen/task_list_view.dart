import 'package:flutter/material.dart';
import '../../models/_models.dart';
import '../_components.dart';

class TaskListView extends StatelessWidget {
  final List<Task> tasks;

  const TaskListView({Key? key, required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemBuilder: (context, index) => TaskCard(task: tasks[index]),
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemCount: tasks.length,
      shrinkWrap: true,
    );
  }
}
