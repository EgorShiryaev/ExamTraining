import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final int maxLines;
  final TextInputType? textInputType;
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.label,
    this.maxLines = 1,
    this.textInputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        keyboardType: textInputType,
        style: Theme.of(context).textTheme.caption,
        maxLines: maxLines,
        cursorColor: Colors.black,
        controller: controller,
        decoration: InputDecoration(
          label: Text(label),
          labelStyle: Theme.of(context).textTheme.caption,
          contentPadding: const EdgeInsets.all(15),
          fillColor: Colors.white,
          filled: true,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    );
  }
}
