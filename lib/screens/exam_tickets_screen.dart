import 'package:flutter/material.dart';

class ExamTicketsScreen extends StatelessWidget {
  const ExamTicketsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ExamTraining'),
      ),
      body: const Center(
        child: Text('Билеты экзаменов'),
      ),
    );
  }
}
