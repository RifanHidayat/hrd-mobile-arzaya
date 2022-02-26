// To parse this JSON data, do
//
//     final project = projectFromJson(jsonString);

import 'dart:convert';

Project projectFromJson(String str) => Project.fromJson(json.decode(str));

String projectToJson(Project data) => json.encode(data.toJson());

class Project {
  Project({
    required this.message,
    required this.error,
    required this.code,
    required this.data,
  });

  String message;
  bool error;
  int code;
  List<Datum> data;

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        message: json["message"],
        error: json["error"],
        code: json["code"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "error": error,
        "code": code,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.quotationId,
    required this.cityId,
    required this.startDate,
    required this.endDate,
    this.description,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.number,
    this.picEvent,
    required this.budgetEffectiveDate,
    required this.budgetExpireDate,
    required this.poNumber,
    required this.poDate,
    required this.members,
  });

  int id;
  int quotationId;
  int cityId;
  DateTime startDate;
  DateTime endDate;
  dynamic description;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  String status;
  String number;
  dynamic picEvent;
  DateTime budgetEffectiveDate;
  DateTime budgetExpireDate;
  String poNumber;
  DateTime poDate;
  List<Member> members;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        quotationId: json["quotation_id"],
        cityId: json["city_id"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        description: json["description"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        status: json["status"],
        number: json["number"],
        picEvent: json["pic_event"],
        budgetEffectiveDate: DateTime.parse(json["budget_effective_date"]),
        budgetExpireDate: DateTime.parse(json["budget_expire_date"]),
        poNumber: json["po_number"],
        poDate: DateTime.parse(json["po_date"]),
        members:
            List<Member>.from(json["members"].map((x) => Member.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quotation_id": quotationId,
        "city_id": cityId,
        "start_date":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "description": description,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "status": status,
        "number": number,
        "pic_event": picEvent,
        "budget_effective_date":
            "${budgetEffectiveDate.year.toString().padLeft(4, '0')}-${budgetEffectiveDate.month.toString().padLeft(2, '0')}-${budgetEffectiveDate.day.toString().padLeft(2, '0')}",
        "budget_expire_date":
            "${budgetExpireDate.year.toString().padLeft(4, '0')}-${budgetExpireDate.month.toString().padLeft(2, '0')}-${budgetExpireDate.day.toString().padLeft(2, '0')}",
        "po_number": poNumber,
        "po_date":
            "${poDate.year.toString().padLeft(4, '0')}-${poDate.month.toString().padLeft(2, '0')}-${poDate.day.toString().padLeft(2, '0')}",
        "members": List<dynamic>.from(members.map((x) => x.toJson())),
      };
}

class Member {
  Member({
    required this.id,
    required this.employeeId,
    this.freelancerId,
    required this.eventId,
    required this.dailyMoney,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.role,
  });

  int id;
  int employeeId;
  dynamic freelancerId;
  int eventId;
  int dailyMoney;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  String role;

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        id: json["id"],
        employeeId: json["employee_id"],
        freelancerId: json["freelancer_id"],
        eventId: json["event_id"],
        dailyMoney: json["daily_money"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employee_id": employeeId,
        "freelancer_id": freelancerId,
        "event_id": eventId,
        "daily_money": dailyMoney,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "role": role,
      };
}
