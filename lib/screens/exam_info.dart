import 'package:flutter/material.dart';

class ExamInfo extends StatelessWidget {
  const ExamInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Экзамен'),
      ),
      body: Center(
        child: Text('exam'),
      ),
    );
  }
}
