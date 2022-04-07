import 'dart:developer';

import 'package:exam_training/data/daos/_daos.dart';
import 'package:exam_training/app_theme.dart';
import 'package:exam_training/data/daos/auth_dao.dart';
import 'package:exam_training/user_interface/screens/auth/auth_screen.dart';
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
        Provider<ExamsDao>(lazy: false, create: (_) => ExamsDao()),
        Provider<TasksDao>(lazy: false, create: (_) => TasksDao()),
        Provider<AuthDao>(lazy: false, create: (_) => AuthDao())
      ],
      child: MaterialApp(
        theme: AppTheme().light,
        home: Builder(
          builder: (ctx) {
            return StreamBuilder(
              stream: Provider.of<AuthDao>(ctx, listen: false).authChanges,
              builder: (context, snapshot) {
                log(snapshot.data.toString());
                if (snapshot.data != null) {
                  return const HomeScreen();
                } else {
                  return const AuthScreen();
                }
              },
            );
          }
        ),
      ),
    );
  }
}
