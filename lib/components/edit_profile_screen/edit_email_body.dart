import 'dart:developer';

import 'package:exam_training/components/custom_rounded_button.dart';
import 'package:exam_training/components/custom_text_field.dart';
import 'package:exam_training/daos/auth_dao.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../custom_alert_dialog.dart';

class EditEmailBody extends StatefulWidget {
  final String? email;
  const EditEmailBody({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  State<EditEmailBody> createState() => _EditEmailBodyState();
}

class _EditEmailBodyState extends State<EditEmailBody> {
  final emailController = TextEditingController();
  bool loading = false;

  @override
  void initState() {
    emailController.text = widget.email ?? '';
    super.initState();
  }

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
            child: Center(
              child: CustomTextField(
                controller: emailController,
                label: 'Email',
                textInputType: TextInputType.emailAddress,
              ),
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
    String error = '';
    final email = emailController.text;
    if (!email.contains('@')) {
      error = 'Email должен содержать знак @';
    }

    if (error.isNotEmpty) {
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
          .updateEmail(emailController.text);
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
    emailController.dispose();
    super.dispose();
  }
}
