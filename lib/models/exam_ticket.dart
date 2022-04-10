class ExamTicket {
  final String question;
  final String answer;

  ExamTicket({
    required this.question,
    required this.answer,
  });

  factory ExamTicket.fromJson(Map<String, dynamic> json) {
    return ExamTicket(
      question: json['question'],
      answer: json['answer'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'answer': answer,
    };
  }
}
