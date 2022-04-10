import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/_components.dart';
import '../../daos/_daos.dart';
import '../../models/_models.dart';

class ExamsScreen extends StatelessWidget {
  const ExamsScreen({Key? key}) : super(key: key);

  final separatorHeight = 10;

  @override
  Widget build(BuildContext context) {
    final examsDao = Provider.of<ExamsDao>(context, listen: false);
    return StreamBuilder<QuerySnapshot>(
      stream: examsDao.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Произошла ошибка:${snapshot.error}'));
        }
        if (snapshot.hasData) {
          if (snapshot.data!.docs.isNotEmpty) {
            final List<Exam> exams =
                (snapshot.data!.docs).map((e) => Exam.fromSnapshot(e)).toList();
            exams.sort((a, b) => a.dateTime.compareTo(b.dateTime));
            return ExamListView(exams: exams);
          } else {
            return const EmptyListWidget(
              text:
                  'Экзамены не найдены.\nДля добавления экзаменов нажмите кнопку "Добавить" в правом верхнем углу.',
            );
          }
        } else {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
      },
    );
  }
}
