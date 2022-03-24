import 'package:flutter/material.dart';

class ExamTicketWidget extends StatelessWidget {
  final int index;
  final String question;
  const ExamTicketWidget({
    Key? key,
    required this.index,
    required this.question,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 25,
          height: 25,
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(),
          ),
          child: Center(
            child: Text(
              '${index + 1}',
              style: Theme.of(context).textTheme.caption,
            ),
          ),
        ),
        Expanded(
          child: Text(
            question,
            style: Theme.of(context).textTheme.caption,
          ),
        )
      ],
    );
  }
}
