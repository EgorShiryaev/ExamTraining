import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../data/models/_models.dart';

class ExamCard extends StatelessWidget {
  final Exam exam;
  const ExamCard({Key? key, required this.exam}) : super(key: key);

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
    final color = getColor(exam.importance);
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
              color: Theme.of(context).cardTheme.color,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              gradient: LinearGradient(
                colors: [color, color, Colors.white, Colors.white],
                stops: [0.0, 5 / widthScreen, 5 / widthScreen, 1.0],
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exam.title,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    SizedBox(height: heightDivider),
                    Text(
                      '22.11.2022 17:01',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    SizedBox(height: heightDivider),
                    Text(
                      exam.location,
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
}
