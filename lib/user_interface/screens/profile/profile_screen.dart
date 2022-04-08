import 'dart:developer';

import 'package:exam_training/data/daos/auth_dao.dart';
import 'package:exam_training/data/daos/user_dao.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/_components.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Provider.of<UserDao>(context).user,
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
                  SizedBox(
                    height: (snapshot.data as User?)?.emailVerified ?? false
                        ? 10
                        : 0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      !((snapshot.data as User?)?.emailVerified ?? true)
                          ? IconButton(
                              padding: const EdgeInsets.all(0),
                              onPressed: () => _onWarningTap(context),
                              icon: const Icon(Icons.warning_amber,
                                  color: Colors.red),
                            )
                          : const SizedBox(),
                      Text(
                        (snapshot.data as User?)?.email ??
                            'Электронная почта не указана',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  !((snapshot.data as User?)?.emailVerified ?? true)
                      ? CustomRoundedButton(
                          text: 'Подтвердить почту',
                          onTap: (context) {},
                        )
                      : const SizedBox(),
                  CustomRoundedButton(
                    text: 'Выйти',
                    onTap: _onExit,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  _onWarningTap(context) {
    showDialog(
      context: context,
      builder: (_) => CustomAlertDialog(
        title: 'Адрес электронной почты не подтвержден',
        actionTitle: 'ОК',
        actionFunction: () => Navigator.pop(context),
        actionColor: Colors.blue,
        isOneButton: true,
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
