import 'package:exam_training/data/daos/tasks_dao.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../data/models/_models.dart';
import '../../../utils/get_color_for_importance.dart';
import '../_components.dart';

class TaskCard extends StatefulWidget {
  final Task task;

  const TaskCard({Key? key, required this.task}) : super(key: key);

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  void initState() {
    super.initState();
    Intl.defaultLocale = 'ru';
  }

  final heightDivider = 5.0;

  @override
  Widget build(BuildContext context) {

    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.5,
        children: [
          SlidableAction(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            icon: Icons.question_answer_rounded,
            onPressed: _onShowExamTickets,
          ),
          SlidableAction(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            icon: Icons.edit_rounded,
            onPressed: _onEdit,
          ),
          SlidableAction(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              icon: Icons.delete,
              onPressed: _onDelete),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Transform.scale(
                scale: 1.4,
                child: Checkbox(
                  shape: const CircleBorder(),
                  side: BorderSide(
                    color: getColorForImportance(widget.task.importance),
                  ),
                  value: widget.task.completed,
                  onChanged: (tr) {},
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width - 95,
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.task.title,
                      style: Theme.of(context).textTheme.subtitle1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: heightDivider),
                    Text(
                      '${_upperFirst(DateFormat.yMMMEd().format(widget.task.dateTime.toDate()).toString())} ${DateFormat.Hm().format(widget.task.dateTime.toDate()).toString()}',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    SizedBox(height: heightDivider),
                    Text(
                      widget.task.description,
                      style: Theme.of(context).textTheme.subtitle2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 22,
              )
            ],
          ),
        ),
      ),
    );
  }

  _onShowExamTickets(context) {}

  _onEdit(context) {}

  _onDelete(context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Вы действительно хотите удалить задачу?",
            textAlign: TextAlign.center,
          ),
          titleTextStyle: Theme.of(context).textTheme.subtitle2,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 25,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          actionsAlignment: MainAxisAlignment.spaceAround,
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomDialogButton(
                  title: 'Удалить',
                  onTap: _onDeleteModal,
                  textColor: const Color(0xFFD90030),
                ),
                CustomDialogButton(
                  title: 'Отмена',
                  onTap: _onCancelModal,
                  textColor: Colors.blue,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  _onDeleteModal() {
    Provider.of<TasksDao>(context, listen: false)
        .delete(widget.task.reference!.id);
    Navigator.pop(context);
  }

  _onCancelModal() {
    Navigator.pop(context);
  }

  String _upperFirst(String text) =>
      '${text[0].toUpperCase()}${text.substring(1)}';
}
