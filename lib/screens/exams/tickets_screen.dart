import 'package:exam_training/models/_models.dart';
import 'package:exam_training/components/_components.dart';
import 'package:flutter/material.dart';

class TicketsScreen extends StatefulWidget {
  final List<ExamTicket> examTickets;
  const TicketsScreen({
    Key? key,
    required this.examTickets,
  }) : super(key: key);

  List<ExamTicketItem> generateItems() {
    return List<ExamTicketItem>.generate(examTickets.length, (int index) {
      return ExamTicketItem(
        headerValue: examTickets[index].question,
        expandedValue: examTickets[index].answer,
      );
    });
  }

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  List<ExamTicketItem> examTickets = [];

  @override
  void initState() {
    examTickets = widget.generateItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ExamTraining'),
      ),
      body: Builder(
        builder: (cntx) {
          if (examTickets.isEmpty) {
            return const EmptyListWidget(
              text:
                  'Экзаменационные билеты не найдены.\nДля добавления отредактируйте экзамен.',
            );
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: ExpansionPanelList(
              expandedHeaderPadding: const EdgeInsets.all(0),
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  examTickets[index].isExpanded = !isExpanded;
                });
              },
              children: List.generate(examTickets.length, (index) {
                return ExpansionPanel(
                  canTapOnHeader: true,
                  isExpanded: examTickets[index].isExpanded,
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: ExamTicketWidget(
                        index: index,
                        question: examTickets[index].headerValue,
                      ),
                    );
                  },
                  body: ListTile(
                    title: Text(
                      examTickets[index].expandedValue,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                );
              }),
            ),
          );
        },
      ),
    );
  }
}

class ExamTicketItem {
  ExamTicketItem({
    required this.headerValue,
    required this.expandedValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}
