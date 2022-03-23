import 'package:exam_training/data/models/_models.dart';
import 'package:exam_training/user_interface/components/_components.dart';
import 'package:flutter/material.dart';

class TicketsViewScreen extends StatefulWidget {
  final List<ExamTicket> examTickets;
  const TicketsViewScreen({
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
  State<TicketsViewScreen> createState() => _TicketsViewScreenState();
}

class _TicketsViewScreenState extends State<TicketsViewScreen> {
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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: _buildPanel(),
        ),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
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
              title: ExamQuestionComponent(
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
