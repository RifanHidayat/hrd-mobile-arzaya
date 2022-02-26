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
  Data data;

  factory LoginEmployee.fromJson(Map<String, dynamic> json) => LoginEmployee(
        message: json["message"],
        error: json["error"],
        code: json["code"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "error": error,
        "code": code,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.id,
    required this.employeeId,
    required this.firstName,
    required this.lastName,
    required this.companyId,
    required this.companyLocationId,
    required this.departmentId,
    required this.designationId,
    required this.dateOfBirth,
    required this.gender,
    required this.contactNumber,
    this.officeShiftId,
    required this.reportTo,
    required this.leaveId,
    required this.email,
    required this.address,
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
    required this.workPlacement,
    required this.mobileAccessType,
    this.photo,
    required this.designation,
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
  String workPlacement;
  String mobileAccessType;
  dynamic photo;
  Designation designation;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
        workPlacement: json["work_placement"],
        mobileAccessType: json["mobile_access_type"],
        photo: json["photo"],
        designation: Designation.fromJson(json["designation"]),
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
        "work_placement": workPlacement,
        "mobile_access_type": mobileAccessType,
        "photo": photo,
        "designation": designation.toJson(),
      };
}

class Designation {
  Designation({
    required this.id,
    required this.name,
    required this.departmentId,
    required this.description,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.addedBy,
    required this.department,
  });

  int id;
  String name;
  int departmentId;
  String description;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  int addedBy;
  Department department;

  factory Designation.fromJson(Map<String, dynamic> json) => Designation(
        id: json["id"],
        name: json["name"],
        departmentId: json["department_id"],
        description: json["description"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        addedBy: json["added_by"],
        department: Department.fromJson(json["department"]),
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
        "department": department.toJson(),
      };
}

class Department {
  Department({
    required this.id,
    required this.name,
    required this.companyId,
    required this.employeeId,
    required this.companyLocationId,
    required this.addedBy,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.company,
    required this.location,
  });

  int id;
  String name;
  int companyId;
  int employeeId;
  int companyLocationId;
  int addedBy;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  Company company;
  Location location;

  factory Department.fromJson(Map<String, dynamic> json) => Department(
        id: json["id"],
        name: json["name"],
        companyId: json["company_id"],
        employeeId: json["employee_id"],
        companyLocationId: json["company_location_id"],
        addedBy: json["added_by"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        company: Company.fromJson(json["company"]),
        location: Location.fromJson(json["location"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "company_id": companyId,
        "employee_id": employeeId,
        "company_location_id": companyLocationId,
        "added_by": addedBy,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "company": company.toJson(),
        "location": location.toJson(),
      };
}

class Company {
  Company({
    required this.id,
    required this.name,
    required this.registrationNumber,
    required this.contactNumber,
    required this.email,
    this.website,
    this.npwp,
    required this.address,
    required this.province,
    required this.city,
    required this.zipCode,
    required this.country,
    required this.logo,
    required this.addedBy,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String registrationNumber;
  String contactNumber;
  String email;
  dynamic website;
  dynamic npwp;
  String address;
  String province;
  String city;
  String zipCode;
  String country;
  String logo;
  int addedBy;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["id"],
        name: json["name"],
        registrationNumber: json["registration_number"],
        contactNumber: json["contact_number"],
        email: json["email"],
        website: json["website"],
        npwp: json["npwp"],
        address: json["address"],
        province: json["province"],
        city: json["city"],
        zipCode: json["zip_code"],
        country: json["country"],
        logo: json["logo"],
        addedBy: json["added_by"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "registration_number": registrationNumber,
        "contact_number": contactNumber,
        "email": email,
        "website": website,
        "npwp": npwp,
        "address": address,
        "province": province,
        "city": city,
        "zip_code": zipCode,
        "country": country,
        "logo": logo,
        "added_by": addedBy,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Location {
  Location({
    required this.id,
    required this.companyId,
    required this.employeeId,
    required this.locationName,
    required this.contactNumber,
    required this.email,
    required this.npwp,
    required this.address,
    required this.province,
    required this.city,
    required this.zipCode,
    required this.country,
    required this.addedBy,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    this.latitude,
    this.longitude,
  });

  int id;
  int companyId;
  int employeeId;
  String locationName;
  String contactNumber;
  String email;
  String npwp;
  String address;
  String province;
  String city;
  String zipCode;
  String country;
  int addedBy;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic latitude;
  dynamic longitude;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"],
        companyId: json["company_id"],
        employeeId: json["employee_id"],
        locationName: json["location_name"],
        contactNumber: json["contact_number"],
        email: json["email"],
        npwp: json["npwp"],
        address: json["address"],
        province: json["province"],
        city: json["city"],
        zipCode: json["zip_code"],
        country: json["country"],
        addedBy: json["added_by"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_id": companyId,
        "employee_id": employeeId,
        "location_name": locationName,
        "contact_number": contactNumber,
        "email": email,
        "npwp": npwp,
        "address": address,
        "province": province,
        "city": city,
        "zip_code": zipCode,
        "country": country,
        "added_by": addedBy,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "latitude": latitude,
        "longitude": longitude,
      };
}
