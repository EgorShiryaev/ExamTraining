import 'package:exam_training/models/exam.dart';
import 'package:exam_training/models/importance.dart';
import 'package:exam_training/screens/exam_info_screen.dart';
import 'package:flutter/material.dart';

import 'exams_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  _changeCurrentPage(int index) {
    setState(() => _currentIndex = index);
  }

  _navigateToExamInfoPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ExamInfoScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ExamTraining')),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      floatingActionButton: _currentIndex == 0
          ? IconButton(
              iconSize: 50,
              icon: const Icon(Icons.add_circle_rounded),
              onPressed: () => _navigateToExamInfoPage(context),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor:
            Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
        unselectedItemColor:
            Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
        currentIndex: _currentIndex,
        onTap: _changeCurrentPage,
        items: navigationBarItems,
      ),
    );
  }
}

final exam = Exam(
  title: 'Test',
  dateTime: DateTime.now(),
  location: 'Test',
  importance: Importance.low,
  tickets: [],
);

final _pages = [
  ExamsScreen(exams: [exam]),
  const Center(child: Text('Задачи')),
  const Center(child: Text('Профиль')),
];

final navigationBarItems = [
  const BottomNavigationBarItem(
    icon: Icon(Icons.quiz_outlined),
    label: 'Экзамены',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.checklist_outlined),
    label: 'Задачи',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.account_circle),
    label: 'Профиль',
  ),
];
