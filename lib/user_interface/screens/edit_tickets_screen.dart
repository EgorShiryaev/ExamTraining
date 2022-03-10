import 'package:exam_training/data/models/_models.dart';
import 'package:exam_training/user_interface/components/custom_text_field.dart';
import 'package:exam_training/user_interface/components/edit_tickets_screen/ticket_swipeable_component.dart';
import 'package:flutter/material.dart';

class EditTicketsScreen extends StatefulWidget {
  final List<ExamTicket> tickets;
  const EditTicketsScreen({
    Key? key,
    required this.tickets,
  }) : super(key: key);

  @override
  State<EditTicketsScreen> createState() => _EditTicketsScreenState();
}

class _EditTicketsScreenState extends State<EditTicketsScreen> {
  final questionController = TextEditingController();
  late List<ExamTicket> _tickets;

  @override
  void initState() {
    super.initState();
    _tickets = widget.tickets;
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
        Navigator.pop(context, widget.tickets);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ExamTraining'),
        ),
        body: widget.tickets.isEmpty
            ? Center(
                child: Text(
                  'Билеты к экзамену не найдены.\nЧтобы добавить билеты введите вопрос билета снизу в поле и нажмите на кнопку добавить справа от поля ввода.',
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center,
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.tickets.length,
                    itemBuilder: (context, index) => TicketSwipeableComponent(
                      index: index,
                      ticket: widget.tickets[index],
                      onDelete: _onDelete,
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

  _addTicket() {
    setState(() {
      _tickets.add(ExamTicket(question: questionController.text, answer: ''));
    });
    questionController.clear();
  }

  _onDelete(ExamTicket ticket) {
    setState(() {
      _tickets.remove(ticket);
    });
  }

  final _heightDivider = 10.0;
}
