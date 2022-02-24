import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_training/data/daos/exam_dao.dart';
import 'package:exam_training/user_interface/components/exams_screen/exam_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExamsScreen extends StatelessWidget {
  const ExamsScreen({
    Key? key,
  }) : super(key: key);

  final separatorHeight = 10;

  @override
  Widget build(BuildContext context) {
    final examDao = Provider.of<ExamDao>(context, listen: false);
    return StreamBuilder<QuerySnapshot>(
      stream: examDao.getExamStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Произошла ошибка:${snapshot.error}')
          );
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else {
          return ExamListView(exams: snapshot.data!.docs);
        }
      },
    );

  }
}
