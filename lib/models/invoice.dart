import 'package:flutter/cupertino.dart';

import 'package:magentahrdios/models/pdf.dart';
import 'package:magentahrdios/models/supplier.dart';

import 'employee.dart';

class Invoice {
  final InvoiceInfo info;
  final Employee employee;
  final Supplier supplier;
  final Pdf pdf;
  final List<InvoiceItem> items;

  final List<DeductionItem> itemss;

  const Invoice({
    required this.info,
    required this.supplier,
    required this.pdf,
    required this.items,
    required this.employee,
    required this.itemss,
  });
}

class InvoiceInfo {
  final String description;
  final String number;
  final DateTime date;
  final DateTime dueDate;

  const InvoiceInfo({
    required this.description,
    required this.number,
    required this.date,
    required this.dueDate,
  });
}

class InvoiceItem {
  final String name;
  final String email;
  final String age;
  final String income;
  final String country;
  final String area;

  const InvoiceItem(
      {required this.name,
      required this.email,
      required this.age,
      required this.income,
      required this.country,
      required this.area});

  factory InvoiceItem.fromJson(Map<String, dynamic> json) {
    return InvoiceItem(
        name: json['name'],
        email: json['email'],
        age: json['age'],
        income: json['income'],
        country: json['country'],
        area: json['area']);
  }
}

class DeductionItem {
  final String description;

  final String unitPrice;

  const DeductionItem({
    required this.description,
    required this.unitPrice,
  });
}
