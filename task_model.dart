class Task {
  final String id;
  final String title;
  final DateTime dueDate;
  final bool isCompleted;

  Task({required this.id, required this.title, required this.dueDate, required this.isCompleted});

  factory Task.fromParseObject(ParseObject object) {
    return Task(
      id: object.objectId!,
      title: object.get<String>('title')!,
      dueDate: object.get<DateTime>('dueDate')!,
      isCompleted: object.get<bool>('isCompleted')!,
    );
  }
}
