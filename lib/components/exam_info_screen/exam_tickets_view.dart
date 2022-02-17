import 'package:exam_training/components/custom_rounded_button.dart';
import 'package:exam_training/models/exam_ticket.dart';
import 'package:exam_training/screens/exam_tickets_screen.dart';
import 'package:flutter/material.dart';

class ExamTicketsView extends StatelessWidget {
  final List<ExamTicket> examTickets;
  final Function(List<ExamTicket> newTicket) setTickets;
  const ExamTicketsView({
    Key? key,
    required this.examTickets,
    required this.setTickets,
  }) : super(key: key);

  _navigateToExamTicket(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ExamTicketsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (examTickets.isEmpty) {
      return CustomRoundedButton(
        onTap: _navigateToExamTicket,
        text: 'Добавить билеты',
      );
    }
    return Container();
  }
}
