import 'package:exam_training/data/daos/exam_dao.dart';
import 'package:exam_training/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'user_interface/screens/_screens.dart';

void main(List<String> args) async {
  initializeDateFormatting();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ExamTrainingApp());
}

class ExamTrainingApp extends StatelessWidget {
  const ExamTrainingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ExamDao>(
          lazy: false,
          create: (_) => ExamDao(),
        ),
      ],
      child: MaterialApp(
        theme: ExamTrainingTheme.lightTheme,
        home: const HomeScreen(),
      ),
    );
  }
}
