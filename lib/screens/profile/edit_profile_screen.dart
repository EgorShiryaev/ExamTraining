import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../components/_components.dart';
import '../../models/_models.dart';

class EditProfileScreen extends StatelessWidget {
  final EditProfileMode mode;
  final User user;
  const EditProfileScreen({
    Key? key,
    required this.mode,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ExamTraining'),
      ),
      body: SafeArea(
        child: Builder(
          builder: (context) {
            switch (mode) {
              case EditProfileMode.editUsername:
                return EditUsernameBody(
                  username: user.displayName,
                );
              case EditProfileMode.editEmail:
                return EditEmailBody(
                  email: user.email,
                );
              case EditProfileMode.editPassword:
                return const EditPasswordBody();
              default:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
