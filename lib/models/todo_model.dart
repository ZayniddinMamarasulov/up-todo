class TodoModel {
  int? id;
  final String title;
  final String description;
  final String date;
  final String priority;
  final bool isCompleted;

  TodoModel(
      {required this.title,
      required this.description,
      required this.date,
      required this.priority,
      required this.isCompleted});
}
