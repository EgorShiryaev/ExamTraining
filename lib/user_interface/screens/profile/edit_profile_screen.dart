import 'dart:developer';

import 'package:exam_training/user_interface/components/custom_text_field.dart';
import 'package:exam_training/user_interface/components/password_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/daos/user_dao.dart';
import '../../components/custom_alert_dialog.dart';
import '../../components/custom_rounded_button.dart';

class EditProfileScreen extends StatefulWidget {
  final User user;
  const EditProfileScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void initState() {
    usernameController.text = widget.user.displayName ?? '';
    emailController.text = widget.user.email ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ExamTraining'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15).copyWith(top: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 130,
                    width: 130,
                    child: Image.asset('assets/avatariya_icon.png'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: usernameController,
                    label: 'Имя пользователя',
                  ),
                  CustomTextField(
                    controller: emailController,
                    label: 'Электронная почта',
                  ),
                  PasswordTextField(
                    controller: passwordController,
                    label: 'Пароль',
                  ),
                  PasswordTextField(
                    controller: confirmPasswordController,
                    label: 'Подтвердите пароль',
                  )
                ],
              ),
              Column(
                children: [
                  CustomRoundedButton(
                    text: 'Сохранить',
                    onTap: (context) {},
                  ),
                  CustomRoundedButton(
                    text: 'Удалить пользователя',
                    onTap: (context) {},
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onSave(BuildContext context) {
    if (_checkForm()){
      Future.wait(futures)
    }
  }

  bool _checkForm() {
    final errors = <String>[];
    final userName = usernameController.text;
    if (userName.isNotEmpty && userName != widget.user.displayName) {
      if (userName.length < 8) {
        errors.add('Имя пользователя должно быть длинее 8 символов');
      }
      if (userName.trim().isEmpty) {
        errors.add('Имя пользователя не может состоять из пробелов');
      }
    }
    final email = emailController.text;
    if (email != widget.user.email) {
      if (!emailController.text.contains('@')) {
        errors.add('Поле "Электронная почта" должно содержать знак @');
      }
    }
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;
    if (password.isNotEmpty && confirmPassword.isNotEmpty) {
      if (password != confirmPassword) {
        errors.add('Не совпадают пароли');
      } else {
        if (passwordController.text.length < 8) {
          errors.add('Пароль должен быть больше 8 символов');
        }
        final alphabetReg = RegExp(r"[^a-zA-Z]");
        final numberReg = RegExp(r"[^0-9]");
        if (!(passwordController.text.contains(alphabetReg) &&
            passwordController.text.contains(numberReg))) {
          errors.add(
              'Пароль должен содержать английские буквы и хоть одно число');
        }
      }
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
}
