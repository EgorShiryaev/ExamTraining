import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/daos/auth_dao.dart';
import '../../components/custom_alert_dialog.dart';
import '../../components/custom_rounded_button.dart';
import '../../components/custom_text_field.dart';
import '../../components/password_text_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool isLoading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: const Text('ExamTraining')),
      body: Builder(builder: (context) {
        if (isLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        return Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                controller: emailController,
                label: 'Электронная почта',
              ),
              PasswordTextField(
                controller: passwordController,
                label: 'Пароль',
              ),
              CustomRoundedButton(
                onTap: onTapSignIn,
                text: 'Войти',
              )
            ],
          ),
        );
      }),
    );
  }

  bool checkEmailAndPassword() {
    final errors = <String>[];

    if (!emailController.text.contains('@')) {
      errors.add('Поле "Электронная почта" должно содержать знак @');
    }
    if (passwordController.text.length < 8) {
      errors.add('Пароль должен быть больше 8 символов');
    }
    final alphabetReg = RegExp(r"[^a-zA-Z]");
    final numberReg = RegExp(r"[^0-9]");
    if (!(passwordController.text.contains(alphabetReg) &&
        passwordController.text.contains(numberReg))) {
      errors.add('Пароль должен содержать английские буквы и хоть одно число');
    }

    if (errors.isNotEmpty) {
      final error = errors.join('\n\n');
      showDialog(
        context: context,
        builder: (_) => CustomAlertDialog(
          title: error,
          actionTitle: 'ОК',
          actionFunction: () => Navigator.pop(context),
          actionColor: Colors.blue,
          isOneButton: true,
        ),
      );
      return false;
    }
    return true;
  }

  void onTapSignIn(BuildContext context) async {
    if (checkEmailAndPassword()) {
      setState(() => isLoading = true);
      final result = await Provider.of<AuthDao>(context, listen: false)
          .signInWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      );
      setState(() => isLoading = false);
      if (result.success) {
        Navigator.pop(_scaffoldKey.currentContext!);
      } else {
        ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(
          SnackBar(
            content: Text(result.message),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
