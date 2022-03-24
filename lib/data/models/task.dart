import 'package:cloud_firestore/cloud_firestore.dart';
import '_models.dart';

class Task {
  final String title;
  final Timestamp dateTime;
  final String description;
  final Importance importance;
  final List<Subtask> subtasks;
  final bool completed;

  DocumentReference? reference;

  Task({
    required this.title,
    required this.dateTime,
    required this.description,
    required this.importance,
    required this.subtasks,
    required this.completed,
    this.reference,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      dateTime: json['dateTime'],
      description: json['description'],
      completed: json['completed'],
      importance: Importance.values[json['importance']],
      subtasks: (json['subtasks'] as List<dynamic>)
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
      'description': description,
      'completed': completed,
      'importance': importance.index,
      'subtasks': subtasks.map((e) => e.toJson()),
    };
  }
}
