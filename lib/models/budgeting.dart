// git init// To parse this JSON data, do
// //
// //     final budgeting = budgetingFromJson(jsonString);
//
 import 'dart:convert';

Budgeting budgetingFromJson(String str) => Budgeting.fromJson(json.decode(str));

String budgetingToJson(Budgeting data) => json.encode(data.toJson());

class Budgeting {
  Budgeting({
    required this.message,
    required this.error,
    required this.code,
    required this.data,
  });

  String message;
  bool error;
  int code;
  Data data;

  factory Budgeting.fromJson(Map<String, dynamic> json) => Budgeting(
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
    required this.totalIncome,
    required this.totalExpense,
    required this.balance,
    required this.cashFlow,
  });

  int totalIncome;
  int totalExpense;
  int balance;
  List<dynamic> cashFlow;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalIncome: json["total_income"],
        totalExpense: json["total_expense"],
        balance: json["balance"],
        cashFlow: List<dynamic>.from(json["cash_flow"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "total_income": totalIncome,
        "total_expense": totalExpense,
        "balance": balance,
        "cash_flow": List<dynamic>.from(cashFlow.map((x) => x)),
      };
}
