import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(const ExamTicketCard());

class ExamTicketCard extends StatelessWidget {
  //final ExamTicketCard ticket;
  const ExamTicketCard({
    Key? key
    //required this.ticket,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: const ExamTicket(),
      ),
    );
  }
}


class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'Вопрос № $index',
      expandedValue: 'Ответ № $index',
    );
  });
}

class ExamTicket extends StatefulWidget {
  const ExamTicket({Key? key}) : super(key: key);

  @override
  State<ExamTicket> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<ExamTicket> {
  final List<Item> _data = generateItems(10);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: ListTile(
              title: Text(item.expandedValue),
              ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
