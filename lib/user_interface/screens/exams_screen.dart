import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_training/data/daos/exams_dao.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/_components.dart';

class ExamsScreen extends StatelessWidget {
  const ExamsScreen({
    Key? key,
  }) : super(key: key);

  final separatorHeight = 10;

  @override
  Widget build(BuildContext context) {
    final examDao = Provider.of<ExamsDao>(context, listen: false);
    return StreamBuilder<QuerySnapshot>(
      stream: examDao.stream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Произошла ошибка:${snapshot.error}'));
        }
        if (snapshot.hasData) {
          return ExamListView(exams: snapshot.data!.docs);
        } else {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
      },
    );
  }
}
