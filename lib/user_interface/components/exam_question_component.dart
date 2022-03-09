import 'package:flutter/material.dart';

class ExamQuestionComponent extends StatelessWidget {
  final int index;
  final String question;
  const ExamQuestionComponent({
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
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
        ),
        Expanded(
          child: Text(
            question.length > 140
                ? '${question.substring(0, 140)}...'
                : question,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        )
      ],
    );
  }
}
