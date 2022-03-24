import 'package:exam_training/data/models/subtask.dart';
import 'package:flutter/material.dart';

class SubtaskWidget extends StatelessWidget {
  final Subtask subtask;
  final Function(String title) onDelete;
  const SubtaskWidget({
    Key? key,
    required this.subtask,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          shape: const CircleBorder(),
          value: subtask.completed,
          onChanged: (_) {},
        ),
        Expanded(
          child: Text(
            subtask.title,
            style: Theme.of(context).textTheme.overline,
          ),
        ),
        GestureDetector(
          onTap: () => onDelete(subtask.title),
          child: const Icon(
            Icons.clear_outlined,
            size: 18,
          ),
        )
      ],
    );
  }
}
