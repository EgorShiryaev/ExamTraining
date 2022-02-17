import 'package:flutter/material.dart';

class ExamInfo extends StatelessWidget {
  const ExamInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ExamTraining'),
        ),
        body: ListView(
          children: <Widget>[
            const Card(
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: ListTile(
                title:  Text('Важность:'),
              ),
            ),
            Padding (
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                children: [
                  const Chip(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black, width: 1),
                        borderRadius:
                            BorderRadius.all(const Radius.circular(15))),
                    label: Text("Низкая"),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Chip(
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    label: const Text("Средняя"),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Chip(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.black, width: 1),
                        borderRadius:
                            BorderRadius.all(const Radius.circular(15))),
                    label: Text("Высокая"),
                  ),
                ],
              ),
            ),
            const Card(
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: ListTile(
                title: Text('Добавить билеты', textAlign: TextAlign.center),
              ),
            ),
            const Card(
              shape: const RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black, width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(15))),
              child: ListTile(
                title: Text('Сохранить', textAlign: TextAlign.center),
              ),
            ),
          ],
        ));
  }
}
