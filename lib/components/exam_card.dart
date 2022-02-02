import 'package:exam_training/models/exam.dart';
import 'package:exam_training/models/importance.dart';
import 'package:flutter/material.dart';

class ExamCard extends StatelessWidget {
  final Exam exam;
  ExamCard({Key? key, required this.exam}) : super(key: key);

  Color getColor(Importance imp) {
    switch (imp) {
      case Importance.low:
        return Color(0xFFF00D930);
      case Importance.medium:
        return Color(0xFFD9D930);
      case Importance.high:
        return Color(0xFFD90030);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Theme.of(context).cardTheme.color,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          children: [
            Container(
              width: 5,
              height: 50,
              decoration: BoxDecoration(
                color: getColor(exam.importance),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
            ),
            Column(
              children: [
                Text(
                  exam.title,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(height: 10),
                // Text(exam.dateTime.)
                SizedBox(height: 10),
              ],
            )
          ],
        ),
      ),
    );
  }
}
