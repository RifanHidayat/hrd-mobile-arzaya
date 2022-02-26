// To parse this JSON data, do
//
//     final example = exampleFromJson(jsonString);

import 'dart:convert';

List<Example> exampleFromJson(String str) =>
    List<Example>.from(json.decode(str).map((x) => Example.fromJson(x)));

String exampleToJson(List<Example> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Example {
  Example({
    required this.id,
    required this.employeeId,
    required this.firstName,
    required this.lastName,
    this.companyId,
    required this.companyLocationId,
    this.departmentId,
    required this.designationId,
    required this.dateOfBirth,
    required this.gender,
    required this.contactNumber,
    this.officeShiftId,
    required this.reportTo,
    required this.leaveId,
    required this.address,
    required this.email,
    required this.username,
    required this.password,
    required this.pin,
    required this.roleId,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
    required this.isActiveAccount,
    required this.hasMobileAccess,
  });

  int id;
  String employeeId;
  String firstName;
  String lastName;
  dynamic companyId;
  int companyLocationId;
  dynamic departmentId;
  int designationId;
  DateTime dateOfBirth;
  String gender;
  String contactNumber;
  dynamic officeShiftId;
  int reportTo;
  int leaveId;
  String address;
  String email;
  String username;
  String password;
  String pin;
  int roleId;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  int isActive;
  int isActiveAccount;
  int hasMobileAccess;

  factory Example.fromJson(Map<String, dynamic> json) => Example(
        id: json["id"],
        employeeId: json["employee_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        companyId: json["company_id"],
        companyLocationId: json["company_location_id"],
        departmentId: json["department_id"],
        designationId: json["designation_id"],
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        gender: json["gender"],
        contactNumber: json["contact_number"],
        officeShiftId: json["office_shift_id"],
        reportTo: json["report_to"],
        leaveId: json["leave_id"],
        address: json["address"],
        email: json["email"],
        username: json["username"],
        password: json["password"],
        pin: json["pin"],
        roleId: json["role_id"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        isActive: json["is_active"],
        isActiveAccount: json["is_active_account"],
        hasMobileAccess: json["has_mobile_access"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employee_id": employeeId,
        "first_name": firstName,
        "last_name": lastName,
        "company_id": companyId,
        "company_location_id": companyLocationId,
        "department_id": departmentId,
        "designation_id": designationId,
        "date_of_birth":
            "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
        "gender": gender,
        "contact_number": contactNumber,
        "office_shift_id": officeShiftId,
        "report_to": reportTo,
        "leave_id": leaveId,
        "address": address,
        "email": email,
        "username": username,
        "password": password,
        "pin": pin,
        "role_id": roleId,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "is_active": isActive,
        "is_active_account": isActiveAccount,
        "has_mobile_access": hasMobileAccess,
      };
}
