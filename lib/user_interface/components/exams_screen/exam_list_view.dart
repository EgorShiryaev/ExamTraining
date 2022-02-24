import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../data/daos/exam_dao.dart';
import '../../../data/models/_models.dart';
import '../_components.dart';

class ExamListView extends StatelessWidget {
  final List<DocumentSnapshot> exams;
  final ExamDao examDao;
  
  const ExamListView({
    Key? key,
    required this.exams,
    required this.examDao,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => _buildExamCard(exams[index]),
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemCount: exams.length,
            shrinkWrap: true,
          ),
        )
      ],
    );
  }

  _buildExamCard(DocumentSnapshot snapshot) {
    final exam = Exam.fromSnapshot(snapshot);
    return ExamCard(
      exam: exam,
      examDao: examDao,
    );
  }
}
