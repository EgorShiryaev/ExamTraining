import 'package:exam_training/data/models/_models.dart';
import 'package:flutter/material.dart';

class ExamTicketsScreen extends StatelessWidget {
  final List<ExamTicket> tickets;
  const ExamTicketsScreen({
    Key? key,
    required this.tickets,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, tickets);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ExamTraining'),
        ),
        body: const Center(
          child: Text('Билеты экзаменов'),
        ),
      ),
    );
  }
}
