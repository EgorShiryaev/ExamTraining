import 'package:cloud_firestore/cloud_firestore.dart';
import '_models.dart';

class Exam {
  final String title;
  final Timestamp dateTime;
  final String location;
  final Importance importance;
  final List<ExamTicket> tickets;

  DocumentReference? reference;

  Exam({
    required this.title,
    required this.dateTime,
    required this.location,
    required this.importance,
    required this.tickets,
    this.reference,
  });

  factory Exam.fromJson(Map<String, dynamic> json) {
    return Exam(
      title: json['title'],
      dateTime: json['dateTime'],
      location: json['location'],
      importance: Importance.values[json['importance']],
      tickets: (json['tickets'] as List<dynamic>)
          .map((v) => ExamTicket.fromJson(v))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'dateTime': dateTime,
      'location': location,
      'importance': importance.index,
      'tickets': tickets.map((e) => e.toJson()).toList(),
    };
  }

  factory Exam.fromSnapshot(DocumentSnapshot snapshot) {
    final exam = Exam.fromJson(snapshot.data() as Map<String, dynamic>);
    exam.reference = snapshot.reference;
    return exam;
  }
}

