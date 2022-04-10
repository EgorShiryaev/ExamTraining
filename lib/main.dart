import 'package:exam_training/daos/_daos.dart';
import 'package:exam_training/app_theme.dart';
import 'package:exam_training/daos/auth_dao.dart';
import 'package:exam_training/screens/auth/auth_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'screens/_screens.dart';

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
    return Provider<AuthDao>(
      lazy: false,
      create: (_) => AuthDao(),
      child: MaterialApp(
        theme: AppTheme().light,
        home: Builder(builder: (ctx) {
          return StreamBuilder(
            stream: Provider.of<AuthDao>(ctx, listen: false).authChanges,
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return MultiProvider(
                    providers: [
                      Provider<ExamsDao>(
                        lazy: true,
                        create: (_) => ExamsDao(user: snapshot.data as User),
                      ),
                      Provider<TasksDao>(
                        lazy: true,
                        create: (_) => TasksDao(user: snapshot.data as User),
                      ),
                    ],
                    child: HomeScreen(
                      user: snapshot.data as User,
                    ));
              } else {
                return const AuthScreen();
              }
            },
          );
        }),
      ),
    );
  }
}
