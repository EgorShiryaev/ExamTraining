import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../daos/_daos.dart';
import '../_components.dart';


class EditUsernameBody extends StatefulWidget {
  final String? username;
  const EditUsernameBody({
    Key? key,
    required this.username,
  }) : super(key: key);

  @override
  State<EditUsernameBody> createState() => _EditUsernameBodyState();
}

class _EditUsernameBodyState extends State<EditUsernameBody> {
  final userNameController = TextEditingController();
  bool loading = false;

  @override
  void initState() {
    userNameController.text = widget.username ?? '';
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
                controller: userNameController,
                label: 'Имя пользователя',
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
    final errors = <String>[];
    final username = userNameController.text;
    if (username.isEmpty) {
      errors.add('Имя пользователя должно быть заполнено');
    } else if (username.length < 8) {
      errors.add('Имя пользователя должно быть заполнено');
    }
    if (username.trim().isEmpty) {
      errors.add('Имя пользователя не может состоять из пробелов');
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
      await Provider.of<AuthDao>(context, listen: false)
          .updateDisplayName(userNameController.text);
      setState(() => loading = false);
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (ctx) => CustomAlertDialog(
          title: 'Имя пользователя изменено успешно',
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
    userNameController.dispose();
    super.dispose();
  }
}
