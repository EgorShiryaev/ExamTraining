import 'package:exam_training/data/daos/exams_dao.dart';
import 'package:exam_training/data/daos/tasks_dao.dart';
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
                ? () => _navigateToEditProfileScreen(context)
                : _currentIndex == 0
                    ? () => _navigateToCreateExamScreen(context)
                    : () => _navigateCreateTaskScreen(context),
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

  _navigateToCreateExamScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            CreateExamScreen(onSave: Provider.of<ExamsDao>(context).add),
      ),
    );
  }

  _navigateCreateTaskScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            CreateTaskScreen(onSave: Provider.of<TasksDao>(context).add),
      ),
    );
  }

  _navigateToEditProfileScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditProfileScreen(),
      ),
    );
  }
}

final _pages = [
  const ExamsScreen(),
  const TasksScreen(),
  const ProfileScreen(),
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
