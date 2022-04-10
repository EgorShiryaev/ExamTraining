import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDialogButton extends StatelessWidget {
  final String title;
  final Function() onTap;
  final Color textColor;
  const CustomDialogButton({
    Key? key,
    required this.title,
    required this.onTap,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: Center(
          child: Text(
            title,
            style: GoogleFonts.roboto(color: textColor, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
