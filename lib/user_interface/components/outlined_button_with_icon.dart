import 'package:flutter/material.dart';

class OutlinedButtonWithIcon extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function() onTap;

  const OutlinedButtonWithIcon({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: OutlinedButton(
        onPressed: onTap,
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
        child: Row(
          children: [
            Icon(icon, size: 20, color: Colors.black),
            const SizedBox(width: 10),
            Text(text, style: Theme.of(context).textTheme.labelMedium)
          ],
        ),
      ),
    );
  }
}
