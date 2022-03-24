import 'package:exam_training/user_interface/components/subtask_widget.dart';
import 'package:flutter/material.dart';
import '../../data/models/_models.dart';
import '_components.dart';

class SubtasksView extends StatefulWidget {
  final List<Subtask> subtasks;
  final Function(String title) add;
  final Function(String title) delete;

  const SubtasksView({
    Key? key,
    required this.subtasks,
    required this.add,
    required this.delete,
  }) : super(key: key);

  @override
  State<SubtasksView> createState() => _SubtasksViewState();
}

class _SubtasksViewState extends State<SubtasksView> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).bottomAppBarColor,
        border: Border.all(color: Colors.black),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              'Подзадачи:',
              style: Theme.of(context).textTheme.caption,
            ),
          ),
          ...List<Widget>.generate(
            widget.subtasks.length,
            (index) {
              return Padding(
                padding: const EdgeInsets.only(right: 15),
                child: SubtaskWidget(
                  subtask: widget.subtasks[index ~/ 2],
                  onDelete: widget.delete,
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 15),
            child: Row(
              children: [
                const Icon(Icons.arrow_forward_outlined, size: 18),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: controller,
                    scrollPadding: const EdgeInsets.all(0),
                    onEditingComplete: _onEditingComplete,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(0),
                      border: InputBorder.none,
                      hintText: 'Новая подзадача',
                      hintStyle: Theme.of(context).textTheme.bodyText2,
                    ),
                    style: Theme.of(context).textTheme.overline,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _onEditingComplete() {
    widget.add(controller.text);
    controller.clear();
  }
}
