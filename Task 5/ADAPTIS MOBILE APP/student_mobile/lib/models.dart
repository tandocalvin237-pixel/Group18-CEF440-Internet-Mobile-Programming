class Course {
  const Course({
    required this.id,
    required this.title,
    required this.teacher,
    required this.location,
    required this.progress,
    required this.modules,
    required this.lessons,
    required this.colorHex,
  });

  final String id;
  final String title;
  final String teacher;
  final String location;
  final double progress;
  final int modules;
  final List<Lesson> lessons;
  final int colorHex;
}

class Lesson {
  const Lesson({
    required this.id,
    required this.title,
    required this.duration,
    required this.summary,
    required this.text,
    this.downloaded = false,
  });

  final String id;
  final String title;
  final String duration;
  final String summary;
  final String text;
  final bool downloaded;
}

class QuizQuestion {
  const QuizQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
  });

  final String question;
  final List<String> options;
  final int correctIndex;
}

class MessageThread {
  const MessageThread({
    required this.name,
    required this.role,
    required this.preview,
    required this.time,
  });

  final String name;
  final String role;
  final String preview;
  final String time;
}
