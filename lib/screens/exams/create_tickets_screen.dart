import 'package:flutter/material.dart';
import '../../../models/_models.dart';
import '../../components/_components.dart';

class CreateTicketsScreen extends StatefulWidget {
  final List<ExamTicket> tickets;
  const CreateTicketsScreen({
    Key? key,
    required this.tickets,
  }) : super(key: key);

  @override
  State<CreateTicketsScreen> createState() => _CreateTicketsScreenState();
}

class _CreateTicketsScreenState extends State<CreateTicketsScreen> {
  final questionController = TextEditingController();
  final List<ExamTicket> _tickets = [];

  bool dontSave = false;
  bool isSaved = false;

  @override
  void initState() {
    super.initState();
    _tickets.addAll(widget.tickets);
  }

  @override
  void dispose() {
    questionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final result = await _onWillPop();
        if (!dontSave) {
          Navigator.pop(context, _tickets);
        } else {
          Navigator.pop(context);
        }
        return result;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ExamTraining'),
          actions: [
            IconButton(
              icon: const Icon(Icons.check_rounded),
              onPressed: _save,
            )
          ],
        ),
        body: _tickets.isEmpty
            ? Center(
                child: Text(
                  'Билеты к экзамену не найдены.\nЧтобы добавить билеты введите вопрос билета снизу в поле и нажмите на кнопку добавить справа от поля ввода.',
                  style: Theme.of(context).textTheme.caption,
                  textAlign: TextAlign.center,
                ),
              )
            : SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _tickets.length,
                    itemBuilder: (context, index) => TicketCard(
                      index: index,
                      ticket: _tickets[index],
                      onDelete: _onDelete,
                      onEdit: _onEdit,
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                      height: _heightDivider,
                    ),
                  ),
                ),
              ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButton: SizedBox(
          width: MediaQuery.of(context).size.width - 20,
          child: Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: questionController,
                  label: 'Название билета',
                  maxLines: 2,
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: _addTicket,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: Colors.white,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _save() {
    setState(() => isSaved = true);
    Navigator.pop(context, _tickets);
  }

  _addTicket() {
    if (questionController.text.isNotEmpty) {
      setState(() {
        _tickets.add(
            ExamTicket(question: '!!! ' + questionController.text, answer: ''));
      });
      questionController.clear();
    }
  }

  _onEdit(ExamTicket newTicket, int index) {
    setState(() {
      _tickets[index] = newTicket;
    });
  }

  _onDelete(ExamTicket ticket) {
    setState(() {
      _tickets.remove(ticket);
    });
  }

  Future<bool> _onWillPop() async {
    if (widget.tickets.length != _tickets.length) {
      if (!isSaved) {
        await showWarning(context);
        if (dontSave) {
          return true;
        }
      }
      return isSaved;
    } else {
      bool ticketsIsChanged = false;
      final startExamTickets = widget.tickets;
      for (var i = 0; i < _tickets.length; i++) {
        try {
          if (_tickets[i].answer != startExamTickets[i].answer ||
              _tickets[i].question != startExamTickets[i].question) {
            ticketsIsChanged = true;
          }
        } catch (e) {
          ticketsIsChanged = true;
        }
      }
      if (ticketsIsChanged) {
        if (!isSaved) {
          await showWarning(context);
          if (dontSave) {
            return true;
          }
        }
        return isSaved;
      }
    }
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
          setState(() => isSaved = true);
          Navigator.pop(context);
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

  final _heightDivider = 10.0;
}
