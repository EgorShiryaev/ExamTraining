import 'package:exam_training/user_interface/components/custom_text_field.dart';
import 'package:flutter/material.dart';

import '../components/custom_rounded_button.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);
  final usernameController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ExamTraining'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
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
                    controller: usernameController, label: 'Имя пользователя')
              ],
            ),
            CustomRoundedButton(
              text: 'Сохранить',
              onTap: (context) {},
            ),
          ],
        ),
      ),
    );
  }
}
