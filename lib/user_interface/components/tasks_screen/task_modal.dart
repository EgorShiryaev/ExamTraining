import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/models/_models.dart';
import '../../../utils/upper_first.dart';

class TaskModal extends StatefulWidget {
  final Task task;
  const TaskModal({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  State<TaskModal> createState() => _TaskModalState();
}

class _TaskModalState extends State<TaskModal> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const SizedBox(
                  width: 60,
                  child: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 40,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.task.title,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.task.description,
                    style: Theme.of(context).textTheme.overline,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${upperFirst(DateFormat.yMMMEd().format(widget.task.dateTime.toDate()))} ${DateFormat.Hm().format(widget.task.dateTime.toDate())}',
                    style: Theme.of(context).textTheme.overline,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Подзадачи:',
                    style: Theme.of(context).textTheme.overline,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            MediaQuery.of(context).size.height - 220 <
                    30 * widget.task.subtasks.length + 10
                ? Expanded(child: buildSubtaskListView())
                : SizedBox(
                    height: 30 * widget.task.subtasks.length + 10,
                    child: buildSubtaskListView(),
                  ),
          ],
        ),
      ),
    );
  }

  buildSubtaskListView() => ListView.builder(
        padding: const EdgeInsets.only(right: 15),
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.task.subtasks.length,
        itemBuilder: (context, index) {
          final task = widget.task.subtasks[index];
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 30,
                child: Checkbox(
                  checkColor: Colors.white,
                  fillColor:
                      MaterialStateColor.resolveWith((states) => Colors.black),
                  shape: const CircleBorder(),
                  value: task.completed,
                  onChanged: (_) => setState(() => task.changeCompleted()),
                ),
              ),
              Expanded(
                child: Text(
                  widget.task.subtasks[index].title,
                  style: Theme.of(context).textTheme.overline?.apply(
                        decoration: widget.task.subtasks[index].completed
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                ),
              ),
            ],
          );
        },
      );
}
