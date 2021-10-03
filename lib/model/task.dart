class Task {
  String name = '';
  String memo;
  bool isDone;
  final DateTime createdAt;
  DateTime updatedAt;

  Task(
      {required this.name,
      required this.memo,
      this.isDone = false,
      required this.createdAt,
      required this.updatedAt});
}
