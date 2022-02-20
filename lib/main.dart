import 'package:exam_training/theme.dart';
import 'package:flutter/material.dart';
import 'user_interface/screens/_screens.dart';

void main(List<String> args) {
  runApp(
    MaterialApp(
      theme: ExamTrainingTheme.lightTheme,
      home: const HomeScreen(),
    ),
  );
}
