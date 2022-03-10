import 'package:flutter/material.dart';

import '../../data/models/exam_ticket.dart';
import '../components/_components.dart';

class AnswerExamTicketScreen extends StatefulWidget {
  final ExamTicket ticket;
  const AnswerExamTicketScreen({
    Key? key,
    required this.ticket,
  }) : super(key: key);

  @override
  State<AnswerExamTicketScreen> createState() => _AnswerExamTicketScreenState();
}

class _AnswerExamTicketScreenState extends State<AnswerExamTicketScreen> {
  final answerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    answerController.text = widget.ticket.answer;
  }

  @override
  void dispose() {
    answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ExamTraining')),
      body: ListView(
        children: [
          SizedBox(
            child: Text(
              widget.ticket.question,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          )
        ],
      ),
      floatingActionButton: Column(
        children: [
          CustomTextField(
            label: 'Ответ на билет',
            controller: answerController,
            maxLines: 5,
          ),
          const SizedBox(height: 10),
          CustomRoundedButton(onTap: _onSave, text: 'Сохранить')
        ],
      ),
    );
  }

  _onSave(context) {
    Navigator.pop(context, answerController.text);
  }
}
