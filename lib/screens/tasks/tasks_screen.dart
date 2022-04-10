import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_training/daos/tasks_dao.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/_models.dart';
import '../../components/_components.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({Key? key}) : super(key: key);

  final separatorHeight = 10;

  @override
  Widget build(BuildContext context) {
    final tasksDao = Provider.of<TasksDao>(context, listen: false);
    return StreamBuilder<QuerySnapshot>(
      stream: tasksDao.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Произошла ошибка:${snapshot.error}'),
          );
        }
        if (snapshot.hasData) {
          if (snapshot.data!.docs.isNotEmpty) {
            final List<Task> tasks =
                (snapshot.data!.docs).map((e) => Task.fromSnapshot(e)).toList();
            tasks.sort((a, b) => a.dateTime.compareTo(b.dateTime));
            return TaskListView(tasks: tasks);
          } else {
            return const EmptyListWidget(
              text:
                  'Задачи не найдены.\nДля добавления задачи нажмите кнопку "Добавить" в правом верхнем углу.',
            );
          }
        } else {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
      },
    );
  }
}
