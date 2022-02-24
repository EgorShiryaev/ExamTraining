import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import '../../../data/models/_models.dart';

class ExamCard extends StatefulWidget {
  final Exam exam;
  const ExamCard({Key? key, required this.exam}) : super(key: key);

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
            onPressed: (context) {},
          ),
          SlidableAction(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            icon: Icons.edit_rounded,
            onPressed: (context) {},
          ),
          SlidableAction(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            icon: Icons.delete,
            onPressed: (context) {},
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.exam.title,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    SizedBox(height: heightDivider),
                    Text(
                      _upperFirst(DateFormat.yMMMEd()
                          .format(widget.exam.dateTime)
                          .toString()),
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    SizedBox(height: heightDivider),
                    Text(
                      widget.exam.location,
                      style: Theme.of(context).textTheme.subtitle1,
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

  String _upperFirst(String text) =>
      '${text[0].toUpperCase()}${text.substring(1)}';
}
