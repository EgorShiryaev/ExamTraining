import 'package:exam_training/data/models/_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TicketSwipeableComponent extends StatelessWidget {
  final int index;
  final ExamTicket ticket;
  final Function(ExamTicket) onDelete;
  const TicketSwipeableComponent({
    Key? key,
    required this.index,
    required this.ticket,
    required this.onDelete,
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

  _onEdit(context) {}

  _onDelete(context) {
    onDelete(ticket);
  }
}
