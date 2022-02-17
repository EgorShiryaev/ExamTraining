import 'package:exam_training/components/exams/exam_card.dart';
import 'package:exam_training/models/exam.dart';
import 'package:flutter/material.dart';

class ExamsScreen extends StatelessWidget {
  final List<Exam> exams;
  const ExamsScreen({
    Key? key,
    required this.exams,
  }) : super(key: key);

  final separatorHeight = 10;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => ExamCard(exam: exams[index]),
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemCount: exams.length,
            shrinkWrap: true,
          ),
        )
      ],
    );
  }
}
