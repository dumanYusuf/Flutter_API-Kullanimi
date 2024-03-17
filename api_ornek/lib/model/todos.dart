// To parse this JSON data, do
//
//     final todos = todosFromMap(jsonString);

import 'dart:convert';

Todos todosFromMap(String str) => Todos.fromMap(json.decode(str));

String todosToMap(Todos data) => json.encode(data.toMap());

class Todos {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  Todos({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  factory Todos.fromMap(Map<String, dynamic> json) => Todos(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
    completed: json["completed"],
  );

  Map<String, dynamic> toMap() => {
    "userId": userId,
    "id": id,
    "title": title,
    "completed": completed,
  };
}
