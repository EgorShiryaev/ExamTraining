import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;

  const PasswordTextField({
    Key? key,
    required this.controller,
    required this.label,
  }) : super(key: key);

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool passwordIsVisible = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        style: Theme.of(context).textTheme.caption,
        cursorColor: Colors.black,
        controller: widget.controller,
        obscureText: passwordIsVisible,
        decoration: InputDecoration(
          label: Text(widget.label),
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
          suffixIcon: IconButton(
            onPressed: showPassword,
            icon: Icon(
              passwordIsVisible
                  ? Icons.visibility_rounded
                  : Icons.visibility_off_rounded,
            ),
          ),
        ),
      ),
    );
  }

  void showPassword() => setState(() => passwordIsVisible = !passwordIsVisible);
}
