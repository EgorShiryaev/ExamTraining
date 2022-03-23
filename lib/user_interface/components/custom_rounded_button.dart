import 'package:flutter/material.dart';

class CustomRoundedButton extends StatelessWidget {
  final Function(BuildContext context) onTap;
  final String text;
  const CustomRoundedButton({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: OutlinedButton(
        onPressed: () => onTap(context),
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.grey.shade200),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          padding: MaterialStateProperty.all<EdgeInsets>(
            const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(
              side: BorderSide(color: Colors.black, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          side: MaterialStateProperty.all<BorderSide>(
              const BorderSide(color: Colors.black, width: 1)),
        ),
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.caption,
          ),
        ),
      ),
    );
  }
}
