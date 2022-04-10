import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../daos/_daos.dart';
import '../_components.dart';

class EditPasswordBody extends StatefulWidget {
  final String? email;
  const EditPasswordBody({
    Key? key,
    this.email,
  }) : super(key: key);

  @override
  State<EditPasswordBody> createState() => _EditPasswordBodyState();
}

class _EditPasswordBodyState extends State<EditPasswordBody> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PasswordTextField(
                  controller: passwordController,
                  label: 'Пароль',
                ),
                PasswordTextField(
                  controller: confirmPasswordController,
                  label: 'Подтвердите пароль',
                ),
              ],
            ),
          ),
          CustomRoundedButton(
            onTap: onSave,
            text: 'Сохранить',
          ),
        ],
      ),
    );
  }

  bool checkField() {
    final errors = <String>[];
    if (passwordController.text != confirmPasswordController.text) {
      errors.add(
        'Значения в полях "Пароль" и "Подтвердите пароль" должны совпадать',
      );
    } else {
      if (passwordController.text.length < 8) {
        errors.add('Пароль должен быть больше 8 символов');
      }
      final alphabetReg = RegExp(r"[^a-zA-Z]");
      final numberReg = RegExp(r"[^0-9]");
      if (!(passwordController.text.contains(alphabetReg) &&
          passwordController.text.contains(numberReg))) {
        errors
            .add('Пароль должен содержать английские буквы и хоть одно число');
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

  void onSave(BuildContext _) async {
    if (checkField()) {
      setState(() => loading = true);
      final result = await Provider.of<AuthDao>(context, listen: false)
          .updatePassword(passwordController.text);
      setState(() => loading = false);
      if (result.success) {
        Navigator.pop(context);
      } else {
        if (result.status == requiresRecentLogin) {
          Provider.of<AuthDao>(context, listen: false).signOut();
          Navigator.pop(context);
        }
      }
      showDialog(
        context: context,
        builder: (ctx) => CustomAlertDialog(
          title: result.message,
          actionTitle: 'ОК',
          actionFunction: () => Navigator.pop(ctx),
          actionColor: Colors.blue,
          isOneButton: true,
        ),
      );
    }
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
