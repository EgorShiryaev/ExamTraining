import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../data/daos/exams_dao.dart';
import '../../../data/models/_models.dart';
import '../../screens/_screens.dart';
import '../_components.dart';

class ExamCard extends StatefulWidget {
  final Exam exam;

  const ExamCard({
    Key? key,
    required this.exam,
  }) : super(key: key);

  @override
  State<ExamCard> createState() => _ExamCardState();
}

class _ExamCardState extends State<ExamCard> {
  @override
  void initState() {
    super.initState();
    Intl.defaultLocale = 'ru';
  }

  Color getColor(Importance imp) {
    switch (imp) {
      case Importance.low:
        return const Color(0xFF00D930);
      case Importance.medium:
        return const Color(0xFFD9D930);
      case Importance.high:
        return const Color(0xFFD90030);
      default:
        return Colors.grey;
    }
  }

  final heightDivider = 5.0;

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    final color = getColor(widget.exam.importance);
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
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            gradient: LinearGradient(
              colors: [color, color, Colors.white, Colors.white],
              stops: [0.0, 7.5 / widthScreen, 7.5 / widthScreen, 1.0],
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 47,
                padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.exam.title,
                      style: Theme.of(context).textTheme.subtitle1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: heightDivider),
                    Text(
                      '${_upperFirst(DateFormat.yMMMEd().format(widget.exam.dateTime.toDate()).toString())} ${DateFormat.Hm().format(widget.exam.dateTime.toDate()).toString()}',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    SizedBox(height: heightDivider),
                    Text(
                      widget.exam.location,
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

  _onShowExamTickets(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            TicketsViewScreen(examTickets: widget.exam.tickets),
      ),
    );
  }

  _onEdit(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExamInfoScreen(
          onSave: Provider.of<ExamsDao>(context).update,
          exam: widget.exam,
        ),
      ),
    );
  }

  _onDelete(context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Вы действительно хотите удалить экзамен?",
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
    Provider.of<ExamsDao>(context, listen: false)
        .delete(widget.exam.reference!.id);
    Navigator.pop(context);
  }

  _onCancelModal() {
    Navigator.pop(context);
  }

  String _upperFirst(String text) =>
      '${text[0].toUpperCase()}${text.substring(1)}';
}
