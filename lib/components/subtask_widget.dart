import 'package:exam_training/models/subtask.dart';
import 'package:flutter/material.dart';

class SubtaskWidget extends StatefulWidget {
  final Subtask subtask;
  final Function(String title) onDelete;
  const SubtaskWidget({
    Key? key,
    required this.subtask,
    required this.onDelete,
  }) : super(key: key);

  @override
  State<SubtaskWidget> createState() => _SubtaskWidgetState();
}

class _SubtaskWidgetState extends State<SubtaskWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 30,
          child: Checkbox(
            checkColor: Colors.white,
            fillColor: MaterialStateColor.resolveWith((states) => Colors.black),
            shape: const CircleBorder(),
            value: widget.subtask.completed,
            onChanged: (_) => setState(() => widget.subtask.changeCompleted()),
          ),
        ),
        Expanded(
          child: Text(
            widget.subtask.title,
            style: Theme.of(context).textTheme.overline?.apply(
                  decoration: widget.subtask.completed
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
          ),
        ),
        GestureDetector(
          onTap: () => widget.onDelete(widget.subtask.title),
          child: const Icon(
            Icons.clear_outlined,
            size: 18,
          ),
        )
      ],
    );
  }
}
