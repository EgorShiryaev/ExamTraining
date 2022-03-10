import 'package:flutter/material.dart';

class EditTicketsScreen extends StatelessWidget {
  const EditTicketsScreen({Key? key}) : super(key: key);

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
