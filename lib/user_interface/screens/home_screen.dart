import 'package:exam_training/data/daos/exams_dao.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '_screens.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ExamTraining'),
        actions: [
          IconButton(
            icon: Icon(
                _currentIndex == 2 ? Icons.edit_rounded : Icons.add_rounded),
            onPressed: _currentIndex == 2
                ? _navigateToEditProfilePage
                : _currentIndex == 0
                    ? _navigateToExamInfoPage
                    : _navigateToTaskInfoPage,
          )
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
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

  _navigateToExamInfoPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ExamInfoScreen(onSave: Provider.of<ExamsDao>(context).add),
      ),
    );
  }

  _navigateToTaskInfoPage() {}

  _navigateToEditProfilePage() {}
}

final _pages = [
  const ExamsScreen(),
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
