import 'package:flutter/material.dart';
import '../../../data/models/_models.dart';
import '../../screens/_screens.dart';
import '../_components.dart';


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