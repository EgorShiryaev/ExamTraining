import 'package:flutter/material.dart';
import '../components/_components.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              Text(
                'Имя пользователя',
                style: Theme.of(context).textTheme.headline5,
              ),
            ],
          ),
          CustomRoundedButton(
            text: 'Выйти',
            onTap: _onExit,
          ),
        ],
      ),
    );
  }

  _onExit(context) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomAlertDialog(
          title: "Вы действительно хотите выйти?",
          actionTitle: 'Да',
          actionFunction: () {},
          actionColor: const Color(0xFFD90030),
          cancelTitle: 'Нет',
          cancelColor: Colors.blue,
          cancelFunction: () {},
        );
      },
    );
  }
}
