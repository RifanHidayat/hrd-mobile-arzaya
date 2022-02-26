// To parse this JSON data, do
//
//     final loginEmployee = loginEmployeeFromJson(jsonString);

import 'dart:convert';

LoginEmployee loginEmployeeFromJson(String str) =>
    LoginEmployee.fromJson(json.decode(str));

String loginEmployeeToJson(LoginEmployee data) => json.encode(data.toJson());

class LoginEmployee {
  LoginEmployee({
    required this.message,
    required this.error,
    required this.code,
    required this.data,
  });

  String message;
  bool error;
  int code;
  List<Datum> data;

  factory LoginEmployee.fromJson(Map<String, dynamic> json) => LoginEmployee(
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
    required this.employeeId,
    required this.date,
    required this.clockIn,
    required this.clockInIpAddress,
    required this.clockInLatitude,
    required this.clockInLongitude,
    required this.clockOut,
    this.clockOutIpAddress,
    this.clockOutLatitude,
    this.clockOutLongitude,
    this.timeLate,
    this.earlyLeaving,
    this.overtime,
    this.totalWork,
    this.totalRest,
    required this.status,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
    required this.note,
    required this.image,
    required this.approvedBy,
    required this.approvedAt,
    this.rejectedBy,
    this.rejectedAt,
    required this.approvalNote,
    this.rejectionNote,
    required this.category,
    required this.officeLatitude,
    required this.officeLongitude,
    required this.employee,
  });

  int id;
  String employeeId;
  DateTime date;
  DateTime clockIn;
  String clockInIpAddress;
  String clockInLatitude;
  String clockInLongitude;
  dynamic clockOut;
  dynamic clockOutIpAddress;
  dynamic clockOutLatitude;
  dynamic clockOutLongitude;
  dynamic timeLate;
  dynamic earlyLeaving;
  dynamic overtime;
  dynamic totalWork;
  dynamic totalRest;
  String status;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  String type;
  String note;
  String image;
  ApprovedBy approvedBy;
  DateTime approvedAt;
  dynamic rejectedBy;
  dynamic rejectedAt;
  String approvalNote;
  dynamic rejectionNote;
  String category;
  String officeLatitude;
  String officeLongitude;
  ApprovedBy employee;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        employeeId: json["employee_id"],
        date: DateTime.parse(json["date"]),
        clockIn: DateTime.parse(json["clock_in"]),
        clockInIpAddress: json["clock_in_ip_address"],
        clockInLatitude: json["clock_in_latitude"],
        clockInLongitude: json["clock_in_longitude"],
        clockOut: json["clock_out"],
        clockOutIpAddress: json["clock_out_ip_address"],
        clockOutLatitude: json["clock_out_latitude"],
        clockOutLongitude: json["clock_out_longitude"],
        timeLate: json["time_late"],
        earlyLeaving: json["early_leaving"],
        overtime: json["overtime"],
        totalWork: json["total_work"],
        totalRest: json["total_rest"],
        status: json["status"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        type: json["type"],
        note: json["note"],
        image: json["image"],
        approvedBy: ApprovedBy.fromJson(json["approved_by"]),
        approvedAt: DateTime.parse(json["approved_at"]),
        rejectedBy: json["rejected_by"],
        rejectedAt: json["rejected_at"],
        approvalNote: json["approval_note"],
        rejectionNote: json["rejection_note"],
        category: json["category"],
        officeLatitude: json["office_latitude"],
        officeLongitude: json["office_longitude"],
        employee: ApprovedBy.fromJson(json["employee"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employee_id": employeeId,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "clock_in": clockIn.toIso8601String(),
        "clock_in_ip_address": clockInIpAddress,
        "clock_in_latitude": clockInLatitude,
        "clock_in_longitude": clockInLongitude,
        "clock_out": clockOut,
        "clock_out_ip_address": clockOutIpAddress,
        "clock_out_latitude": clockOutLatitude,
        "clock_out_longitude": clockOutLongitude,
        "time_late": timeLate,
        "early_leaving": earlyLeaving,
        "overtime": overtime,
        "total_work": totalWork,
        "total_rest": totalRest,
        "status": status,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "type": type,
        "note": note,
        "image": image,
        "approved_by": approvedBy.toJson(),
        "approved_at": approvedAt.toIso8601String(),
        "rejected_by": rejectedBy,
        "rejected_at": rejectedAt,
        "approval_note": approvalNote,
        "rejection_note": rejectionNote,
        "category": category,
        "office_latitude": officeLatitude,
        "office_longitude": officeLongitude,
        "employee": employee.toJson(),
      };
}

class ApprovedBy {
  ApprovedBy({
    required this.id,
    required this.employeeId,
    required this.firstName,
    required this.lastName,
    required this.workPlacement,
    this.photo,
    required this.designationId,
    required this.designation,
  });

  int id;
  String employeeId;
  String firstName;
  String lastName;
  String workPlacement;
  dynamic photo;
  String designationId;
  Designation designation;

  factory ApprovedBy.fromJson(Map<String, dynamic> json) => ApprovedBy(
        id: json["id"],
        employeeId: json["employee_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        workPlacement: json["work_placement"],
        photo: json["photo"],
        designationId: json["designation_id"],
        designation: Designation.fromJson(json["designation"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employee_id": employeeId,
        "first_name": firstName,
        "last_name": lastName,
        "work_placement": workPlacement,
        "photo": photo,
        "designation_id": designationId,
        "designation": designation.toJson(),
      };
}

class Designation {
  Designation({
    required this.id,
    required this.name,
    required this.departmentId,
    this.description,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.addedBy,
  });

  int id;
  String name;
  String departmentId;
  dynamic description;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  String addedBy;

  factory Designation.fromJson(Map<String, dynamic> json) => Designation(
        id: json["id"],
        name: json["name"],
        departmentId: json["department_id"],
        description: json["description"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        addedBy: json["added_by"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "department_id": departmentId,
        "description": description,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "added_by": addedBy,
      };
}
