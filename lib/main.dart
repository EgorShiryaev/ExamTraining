import 'package:exam_training/theme.dart';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main(List<String> args) {
  runApp(
    MaterialApp(
      theme: ExamTrainingTheme.lightTheme,
      home: const HomeScreen(),
    ),
  );
}
