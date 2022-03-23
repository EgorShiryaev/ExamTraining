import 'package:flutter/material.dart';

class EmptyTasksWidget extends StatelessWidget {
  const EmptyTasksWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Задачи не найдены.\nДля добавления задачи нажмите кнопку "Добавить" в правом верхнем углу',
        style: Theme.of(context).textTheme.caption,
        textAlign: TextAlign.center,
      ),
    );
  }
}
