import 'package:exam_training/data/models/_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../screens/answer_exam_ticket_screen.dart';
import '../custom_dialog_button.dart';

class TicketSwipeableComponent extends StatelessWidget {
  final int index;
  final ExamTicket ticket;
  final Function(ExamTicket) onDelete;
  final Function(ExamTicket, int) onEdit;
  const TicketSwipeableComponent({
    Key? key,
    required this.index,
    required this.ticket,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.4,
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
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 15, 10),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
          ),
          child: Row(
            children: [
              Container(
                width: 25,
                height: 25,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(),
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  ticket.question.length > 140
                      ? '${ticket.question.substring(0, 140)}...'
                      : ticket.question,
                  style: Theme.of(context).textTheme.labelMedium,
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

  _onEdit(context) async {
    final newTicket = ExamTicket(
        question: ticket.question,
        answer: await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AnswerExamTicketScreen(ticket: ticket),
              ),
            ) ??
            "");
    onEdit(newTicket, index);
  }

  _onDelete(context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Вы действительно хотите удалить экзаменационный билет?",
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
                  onTap: () {
                    onDelete(ticket);
                    Navigator.pop(context);
                  },
                  textColor: const Color(0xFFD90030),
                ),
                CustomDialogButton(
                  title: 'Отмена',
                  onTap: () {
                    Navigator.pop(context);
                  },
                  textColor: Colors.blue,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
