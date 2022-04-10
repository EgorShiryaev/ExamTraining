import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../daos/auth_dao.dart';
import '../models/_models.dart';
import '../screens/_screens.dart';
import '_components.dart';

class ActionsModalSheet extends StatefulWidget {
  const ActionsModalSheet({Key? key}) : super(key: key);

  @override
  State<ActionsModalSheet> createState() => _ActionsModalSheetState();
}

class _ActionsModalSheetState extends State<ActionsModalSheet> {
  late final User user;
  @override
  void initState() {
    user = Provider.of<AuthDao>(context, listen: false).user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      actions: [
        CupertinoActionSheetAction(
          child: Text(
            user.displayName != null
                ? 'Изменить имя пользователя'
                : 'Указать имя пользователя',
          ),
          onPressed: _editUsername,
        ),
        CupertinoActionSheetAction(
          child: const Text('Изменить email'),
          onPressed: _editEmail,
        ),
        CupertinoActionSheetAction(
          child: const Text('Изменить пароль'),
          onPressed: _editPassword,
        ),
        CupertinoActionSheetAction(
          child: const Text(
            'Удалить аккаунт',
            style: TextStyle(color: Colors.red),
          ),
          onPressed: _onDelete,
        ),
      ],
    );
  }

  void _navigateToEditProfileScreen(EditProfileMode mode) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(mode: mode, user: user),
      ),
    );
  }

  void _editUsername() {
    Navigator.pop(context);
    _navigateToEditProfileScreen(EditProfileMode.editUsername);
  }

  void _editEmail() {
    Navigator.pop(context);
    _navigateToEditProfileScreen(EditProfileMode.editEmail);
  }

  void _editPassword() {
    Navigator.pop(context);
    _navigateToEditProfileScreen(EditProfileMode.editPassword);
  }

  void _onDelete() {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) {
        return CustomAlertDialog(
          title: "Вы действительно хотите удалить аккаунт?",
          actionTitle: 'Да',
          actionFunction: () async {
            final result =
                await Provider.of<AuthDao>(context, listen: false).deleteUser();
            Navigator.pop(context);
            if (result.status == requiresRecentLogin) {
              Provider.of<AuthDao>(context, listen: false).signOut();
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
