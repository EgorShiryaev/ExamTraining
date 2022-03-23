import 'package:cloud_firestore/cloud_firestore.dart';
import '_models.dart';

class Task {
  final String title;
  final Timestamp dateTime;
  final String location;
  final Importance importance;
  final List<Subtask> subtasks;

  DocumentReference? reference;

  Task({
    required this.title,
    required this.dateTime,
    required this.location,
    required this.importance,
    required this.subtasks,
    this.reference,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      dateTime: json['dateTime'],
      location: json['location'],
      importance: json['importance'],
      subtasks: (json['subtasks'] as List<Map<String, dynamic>>)
          .map((e) => Subtask.fromJson(e))
          .toList(),
    );
  }

  factory Task.fromSnapshot(DocumentSnapshot snapshot) {
    final task = Task.fromJson(snapshot.data() as Map<String, dynamic>);
    task.reference = snapshot.reference;
    return task;
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'dateTime': dateTime,
      'location': location,
      'importance': importance,
      'subtasks': subtasks.map((e) => e.toJson()),
    };
  }
}
