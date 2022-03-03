import 'dart:developer';

import 'package:exam_training/data/models/_models.dart';
import 'package:flutter/material.dart';

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

class ExamTicketsViewScreen extends StatefulWidget {
  final List<ExamTicket> examTickets;
  const ExamTicketsViewScreen({
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
  State<ExamTicketsViewScreen> createState() => _ExamTicketsViewScreenState();
}

class _ExamTicketsViewScreenState extends State<ExamTicketsViewScreen> {
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
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          examTickets[index].isExpanded = !isExpanded;
        });
      },
      children: examTickets.map<ExpansionPanel>((ExamTicketItem item) {
        return ExpansionPanel(
          isExpanded: item.isExpanded,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: ListTile(title: Text(item.expandedValue)),
        );
      }).toList(),
    );
  }
}
