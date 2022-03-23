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
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).bottomAppBarColor,
            border: Border.all(color: Colors.black),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            children: List<Widget>.generate(
              examTickets.length > 5 ? 5 : examTickets.length,
              (index) {
                final question = examTickets[index].question;
                if (index == 0) {
                  return _createExamQuestionComponent(index, question);
                } else if (index == 4 && examTickets.length > 5) {
                  return Column(
                    children: [
                      SizedBox(height: _separatorHeight),
                      _createExamQuestionComponent(index, question),
                      Text('. . .',
                          style: Theme.of(context).textTheme.subtitle2),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      SizedBox(height: _separatorHeight),
                      _createExamQuestionComponent(index, question),
                    ],
                  );
                }
              },
            ),
          )),
    );
  }

  final _separatorHeight = 10.0;

  _createExamQuestionComponent(int index, String question) {
    return ExamQuestionComponent(
      index: index,
      question: question,
    );
  }

  _navigateToExamTicket(BuildContext context) async {
    final newTickets = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditTicketsScreen(
          tickets: examTickets,
        ),
      ),
    );
    if (newTickets != null) {
      setTickets(newTickets);
    }
  }
}
