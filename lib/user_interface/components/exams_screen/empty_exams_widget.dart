import 'package:flutter/material.dart';

class EmptyExamsWidget extends StatelessWidget {
  const EmptyExamsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Экзамены не найдены.\nДля добавления экзаменов нажмите кнопку "Добавить" в правом верхнем углу',
        style: Theme.of(context).textTheme.caption,
        textAlign: TextAlign.center,
      ),
    );
  }
}
