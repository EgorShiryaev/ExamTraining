
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
          const SizedBox(height: 5),
          ...List<Widget>.generate(
            widget.subtasks.length,
            (index) {
              return Padding(
                padding: const EdgeInsets.only(right: 15),
                child: SubtaskWidget(
                  subtask: widget.subtasks[index],
                  onDelete: widget.delete,
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              children: [
                const Icon(Icons.arrow_forward_outlined, size: 18),
                const SizedBox(width: 15),
                Expanded(
                  child: TextField(
                    controller: controller,
                    scrollPadding: const EdgeInsets.all(0),
                    onEditingComplete: _onEditingComplete,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Новая подзадача',
                      hintStyle: Theme.of(context).textTheme.bodyText2,
                      suffixIcon: GestureDetector(
                        onTap: _onEditingComplete,
                        child: const Icon(
                          Icons.add_rounded,
                          size: 22,
                        ),
                      ),
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
    if (controller.text.isNotEmpty) {
      widget.add(controller.text);
      controller.text = '';
    }
  }
}
