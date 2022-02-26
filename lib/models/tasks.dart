// To parse this JSON data, do
//
//     final tasks = tasksFromJson(jsonString);

import 'dart:convert';

List<Tasks> tasksFromJson(String str) =>
    List<Tasks>.from(json.decode(str).map((x) => Tasks.fromJson(x)));

String tasksToJson(List<Tasks> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Tasks {
  Tasks({
    required this.id,
    required this.task,
    required this.status,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.eventId,
  });

  int id;
  String task;
  String status;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  int eventId;

  factory Tasks.fromJson(Map<String, dynamic> json) => Tasks(
        id: json["id"],
        task: json["task"],
        status: json["status"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        eventId: json["event_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "task": task,
        "status": status,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "event_id": eventId,
      };
}
