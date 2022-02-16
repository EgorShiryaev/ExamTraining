import 'dart:html';

import 'package:exam_training/screens/new_exam.dart';
import 'package:flutter/material.dart';

class ExamInfo extends StatelessWidget {
 const ExamInfo({Key? key}): super(key:key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ExamTraining'),
      ),
      body: ListView(
        children: const <Widget>[
          //Card(child: ListTile(title: Text('One-line ListTile'))),
          Card(
            child: ListTile(
              title: Text('Название экзамена...'),

            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.calendar_today_outlined, color: Colors.black,),
              title: Text('Выбрать дату экзамена...'),
      //onTap: () => print("${Icons.title} - tap"),

            ),

          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.access_time_outlined,color: Colors.black,),
              title: Text('Выбрать время экзамена...'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Место экзамена...'),
            ),
          ),

        ],
      )
    );
  }
       }
