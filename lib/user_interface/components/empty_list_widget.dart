import 'package:flutter/material.dart';

class EmptyListWidget extends StatelessWidget {
  final String text;
  const EmptyListWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: Theme.of(context).textTheme.caption,
        textAlign: TextAlign.center,
      ),
    );
  }
}
