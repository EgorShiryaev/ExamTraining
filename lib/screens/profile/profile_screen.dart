import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/_components.dart';
import '../../daos/auth_dao.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Provider.of<AuthDao>(context, listen: false).userChanges,
      builder: (context, snapshot) {
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
                    (snapshot.data as User?)?.displayName ?? 'Имя не указано',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    (snapshot.data as User?)?.email ?? 'Email не указана',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
              CustomRoundedButton(
                text: 'Выйти',
                onTap: _onExit,
              )
            ],
          ),
        );
      },
    );
  }

  void _onExit(context) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomAlertDialog(
          title: "Вы действительно хотите выйти?",
          actionTitle: 'Да',
          actionFunction: () {
            Provider.of<AuthDao>(context, listen: false).signOut();
            Navigator.pop(context);
          },
          actionColor: const Color(0xFFD90030),
          cancelTitle: 'Нет',
          cancelColor: Colors.blue,
          cancelFunction: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
