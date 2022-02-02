import 'package:exam_training/models/exam_ticket.dart';

import 'importance.dart';

class Exam {
  final String title;
  final DateTime dateTime;
  final String location;
  final Importance importance;
  final List<ExamTicket> tickets;

  Exam({
    required this.title,
    required this.dateTime,
    required this.location,
    required this.importance,
    required this.tickets,
   });
}
