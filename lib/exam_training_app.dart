import 'package:exam_training/screens/home_screen.dart';
import 'package:exam_training/theme.dart';
import 'package:flutter/material.dart';

class ExamTrainingApp extends StatelessWidget {
  const ExamTrainingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ExamTrainingTheme.light(),
      home: HomeScreen(),
    );
  }
}
