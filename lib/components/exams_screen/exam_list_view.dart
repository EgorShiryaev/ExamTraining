import 'package:flutter/material.dart';
import '../../models/_models.dart';
import '../_components.dart';

class ExamListView extends StatelessWidget {
  final List<Exam> exams;

  const ExamListView({
    Key? key,
    required this.exams,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemBuilder: (context, index) => ExamCard(exam: exams[index]),
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemCount: exams.length,
      shrinkWrap: true,
    );
  }
}
