import 'package:exam_training/components/exam_card.dart';
import 'package:exam_training/models/exam.dart';
import 'package:exam_training/models/exam_ticket.dart';
import 'package:exam_training/models/importance.dart';
import 'package:flutter/material.dart';

class ExamsScreen extends StatelessWidget {
  final List<Exam> exams;
  ExamsScreen({
    Key? key,
    required this.exams,
  }) : super(key: key);

  final exam = Exam(
    title: 'Test',
    dateTime: DateTime.now(),
    location: 'Test',
    importance: Importance.low,
    tickets: [],
  );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => ExamCard(
        exam: exam,
      ),
      itemCount: 1,
    );
  }
}
