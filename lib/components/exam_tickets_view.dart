import 'package:flutter/material.dart';
import '../models/_models.dart';
import '../screens/_screens.dart';
import '_components.dart';

class ExamTicketsView extends StatelessWidget {
  final List<ExamTicket> examTickets;
  final Function(List<ExamTicket> newTicket) setTickets;
  const ExamTicketsView({
    Key? key,
    required this.examTickets,
    required this.setTickets,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (examTickets.isEmpty) {
      return CustomRoundedButton(
        onTap: _navigateToExamTicket,
        text: 'Добавить билеты',
      );
    }
    return GestureDetector(
      onTap: () => _navigateToExamTicket(context),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: Theme.of(context).bottomAppBarColor,
          border: Border.all(color: Colors.black),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                'Билеты:',
                style: Theme.of(context).textTheme.caption,
              ),
            ),
            ...List<Widget>.generate(
              examTickets.length > 5 ? 5 * 2 : examTickets.length * 2 - 1,
              (index) {
                if (index == 9 && examTickets.length > 5) {
                  return Center(
                    child: Text(
                      '. . .',
                      style: Theme.of(context).textTheme.overline,
                    ),
                  );
                }
                if (index % 2 == 1) {
                  return const SizedBox(height: 10);
                }
                return ExamTicketWidget(
                  index: index ~/ 2,
                  question: examTickets[index ~/ 2].question,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  _navigateToExamTicket(BuildContext context) async {
    final newTickets = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateTicketsScreen(
          tickets: examTickets,
        ),
      ),
    );
    if (newTickets != null) {
      setTickets(newTickets);
    }
  }
}
