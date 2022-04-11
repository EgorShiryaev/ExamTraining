import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import '../../models/_models.dart';
import '../../daos/_daos.dart';
import '../../screens/tasks/create_task_screen.dart';
import '../../utils/_utils.dart';
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
        extentRatio: 0.33,
        children: [
          SlidableAction(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            icon: Icons.edit_rounded,
            onPressed: _onEdit,
          ),
          SlidableAction(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            icon: Icons.delete,
            onPressed: _onDelete,
          ),
        ],
      ),
      child: Builder(builder: (cntx) {
        return GestureDetector(
          onTap: _onTap,
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
                      fillColor: MaterialStateColor.resolveWith(
                        (states) =>
                            getColorForImportance(widget.task.importance),
                      ),
                      value: widget.task.completed,
                      onChanged: _changeCompletedTask,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 121,
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.task.title,
                          style: Theme.of(context).textTheme.subtitle1?.apply(
                                decoration: widget.task.completed
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: heightDivider),
                        Text(
                          widget.task.description,
                          style: Theme.of(context).textTheme.overline?.apply(
                                decoration: widget.task.completed
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: heightDivider),
                        Text(
                          '${upperFirst(DateFormat.yMMMEd().format(widget.task.dateTime.toDate()))} ${DateFormat.Hm().format(widget.task.dateTime.toDate())}',
                          style: Theme.of(context).textTheme.overline?.apply(
                                decoration: widget.task.completed
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => _onIconTap(cntx),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 22,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  _changeCompletedTask(_) {
    setState(() => widget.task.changeComplete());
    Provider.of<TasksDao>(context, listen: false)
        .updateTaskIsCompleted(widget.task);
  }

  _onIconTap(buildCtx) {
    final slidable = Slidable.of(buildCtx)!;
    if (slidable.actionPaneType.value == ActionPaneType.none) {
      slidable.openEndActionPane();
    } else {
      slidable.close();
    }
  }

  _onTap() async {
    await showCupertinoModalBottomSheet(
      topRadius: const Radius.circular(20),
      context: context,
      builder: (context) => TaskModal(task: widget.task),
    );
    Provider.of<TasksDao>(context, listen: false).updateSubtasks(widget.task);
  }

  _onEdit(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CreateTaskScreen(
          onSave: Provider.of<TasksDao>(context, listen: false).update,
          task: widget.task,
        ),
      ),
    );
  }

  _onDelete(context) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomAlertDialog(
          title: "Вы действительно хотите удалить задачу?",
          actionTitle: 'Да',
          actionFunction: _onDeleteModal,
          actionColor: const Color(0xFFD90030),
          cancelTitle: 'Нет',
          cancelColor: Colors.blue,
          cancelFunction: _onCancelModal,
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
}
