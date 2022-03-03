import 'package:exam_training/user_interface/components/_components.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String actionTitle;
  final Function() actionFunction;
  final Color actionColor;
  final String cancelTitle;
  final Function() cancelFunction;
  final Color cancelColor;
  final bool isOneButton;
  const CustomAlertDialog({
    Key? key,
    required this.title,
    required this.actionTitle,
    required this.actionFunction,
    required this.actionColor,
    required this.cancelTitle,
    required this.cancelFunction,
    required this.cancelColor, this.isOneButton=false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        textAlign: TextAlign.center,
      ),
      titleTextStyle: Theme.of(context).textTheme.subtitle2,
      contentPadding:
          const EdgeInsets.only(top: 15, bottom: 0, left: 25, right: 25),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomDialogButton(
              title: actionTitle,
              onTap: actionFunction,
              textColor: actionColor,
            ),
            isOneButton? CustomDialogButton(
              title: cancelTitle,
              onTap: cancelFunction,
              textColor: cancelColor,
            ):SizedBox(),
          ],
        ),
      ],
    );
  }
}
