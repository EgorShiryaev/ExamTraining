import 'package:exam_training/user_interface/components/_components.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog extends StatefulWidget {
  final String title;
  final String actionTitle;
  final Function() actionFunction;
  final Color actionColor;
  final String? cancelTitle;
  final Function()? cancelFunction;
  final Color? cancelColor;
  final bool isOneButton;
  const CustomAlertDialog({
    Key? key,
    required this.title,
    required this.actionTitle,
    required this.actionFunction,
    required this.actionColor,
    this.cancelTitle,
    this.cancelFunction,
    this.cancelColor,
    this.isOneButton = false,
  }) : super(key: key);

  @override
  State<CustomAlertDialog> createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  final List<Widget> buttons = [];

  @override
  void initState() {
    buttons.add(
      CustomDialogButton(
        title: widget.actionTitle,
        onTap: widget.actionFunction,
        textColor: widget.actionColor,
      ),
    );
    if (!widget.isOneButton) {
      buttons.add(
        CustomDialogButton(
          title: widget.cancelTitle!,
          onTap: widget.cancelFunction!,
          textColor: widget.cancelColor!,
        ),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.title,
        textAlign: TextAlign.center,
      ),
      titleTextStyle: Theme.of(context).textTheme.subtitle1,
      contentPadding:
          const EdgeInsets.only(top: 15, bottom: 0, left: 25, right: 25),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: buttons,
        ),
      ],
    );
  }
}
