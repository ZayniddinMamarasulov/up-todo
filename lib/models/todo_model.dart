class TodoFields {
  static String id = "id";
  static String title = "title";
  static String description = "description";
  static String date = "date";
  static String categoryId = "categoryId";
  static String priority = "priority";
  static String isCompleted = "isCompleted";
}

class TodoModel {
  final int? id;
  final String title;
  final String description;
  final String date;
  final int categoryId;
  final int priority;
  final int isCompleted;

  TodoModel({
    this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.categoryId,
    required this.priority,
    required this.isCompleted,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'] ?? -1,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      date: json['date'] ?? '',
      categoryId: json['categoryId'] ?? -1,
      priority: json['priority'] ?? -1,
      isCompleted: json['isCompleted'] ?? -1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'date': date,
      'categoryId': categoryId,
      'priority': priority,
      'isCompleted': isCompleted,
    };
  }

  TodoModel copyWith({
    int? id,
    String? title,
    String? description,
    String? date,
    int? priority,
    int? categoryId,
    int? isCompleted,
  }) =>
      TodoModel(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        date: date ?? this.date,
        priority: priority ?? this.priority,
        isCompleted: isCompleted ?? this.isCompleted,
        categoryId: categoryId ?? this.categoryId,
      );
}
