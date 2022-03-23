class Subtask {
  final String title;
  final bool completed;

  Subtask({
    required this.title,
    required this.completed,
  });

  factory Subtask.fromJson(Map<String, dynamic> json) {
    return Subtask(
      title: json['title'],
      completed: json['completed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'completed': completed,
    };
  }
}
