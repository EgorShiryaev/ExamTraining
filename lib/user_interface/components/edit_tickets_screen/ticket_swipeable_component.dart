import 'package:exam_training/data/models/_models.dart';
import 'package:exam_training/user_interface/components/exam_question_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TicketSwipeableComponent extends StatefulWidget {
  final int index;
  final ExamTicket ticket;
  const TicketSwipeableComponent({
    Key? key,
    required this.index,
    required this.ticket,
  }) : super(key: key);

  @override
  State<TicketSwipeableComponent> createState() =>
      _TicketSwipeableComponentState();
}

class _TicketSwipeableComponentState extends State<TicketSwipeableComponent> {
  late Color color;
  late double widthScreen;

  @override
  void initState() {
    super.initState();
    widthScreen = MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.5,
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
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
                child: ExamQuestionComponent(
                    index: widget.index, question: widget.ticket.question),
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

  _onDelete(context) {}
}
