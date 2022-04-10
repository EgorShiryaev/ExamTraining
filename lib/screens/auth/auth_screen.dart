import 'package:exam_training/screens/auth/registration_screen.dart';
import 'package:exam_training/screens/auth/sign_in_screen.dart';
import 'package:flutter/material.dart';

import '../../components/_components.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ExamTraining')),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
                width: 84,
                height: 84,
                child: Image.asset('assets/app_icon.png')),
            Column(
              children: [
                CustomRoundedButton(
                  onTap: onTapRegistration,
                  text: 'Зарегистрироваться',
                ),
                CustomRoundedButton(
                  onTap: onTapSignIn,
                  text: 'Войти',
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void onTapRegistration(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RegistrationScreen(),
      ),
    );
  }

  void onTapSignIn(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      ),
    );
  }
}
