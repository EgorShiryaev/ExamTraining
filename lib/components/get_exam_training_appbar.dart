import 'package:flutter/material.dart';

PreferredSizeWidget getExamTrainingAppBar(BuildContext context) => AppBar(
      title: Text(
        'ExamTraining',
        style: Theme.of(context).textTheme.headline4?.copyWith(fontSize: 24),
      ),
    );
