import 'package:flutter/material.dart';

import '../../../models/_models.dart';
import '../../components/_components.dart';

class AnswerScreen extends StatefulWidget {
  final ExamTicket ticket;
  const AnswerScreen({
    Key? key,
    required this.ticket,
  }) : super(key: key);

  @override
  State<AnswerScreen> createState() => _AnswerScreenState();
}

class _AnswerScreenState extends State<AnswerScreen> {
  final answerController = TextEditingController();

  bool isSaved = false;
  bool dontSave = false;

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
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(title: const Text('ExamTraining')),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  physics: const ClampingScrollPhysics(),
                  children: [
                    SizedBox(
                      child: Text(
                        widget.ticket.question.replaceFirst('!!! ', ''),
                        style: Theme.of(context).textTheme.overline,
                      ),
                    )
                  ],
                ),
              ),
              CustomTextField(
                label: 'Ответ на билет',
                controller: answerController,
                maxLines: 5,
              ),
              CustomRoundedButton(onTap: _onSave, text: 'Сохранить'),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  _onSave(context) {
    setState(() => isSaved = true);
    Navigator.pop(context, answerController.text);
  }

  Future<bool> _onWillPop() async {
    if (answerController.text != widget.ticket.answer) {
      if (!isSaved) {
        await showWarning(context);
        if (dontSave) {
          return true;
        }
      }
      return isSaved;
    }
    Navigator.pop(context, answerController.text);
    return true;
  }

  Future<bool?> showWarning(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (context) => CustomAlertDialog(
        title: 'Есть несохраненные данные. Сохранить?',
        actionTitle: 'Да',
        cancelTitle: 'Нет',
        actionFunction: () {
          Navigator.pop(context);
          _onSave(context);
        },
        cancelFunction: () {
          setState(() => dontSave = true);
          Navigator.pop(context);
        },
        actionColor: Colors.blue,
        cancelColor: Colors.red,
      ),
    );
  }
}
