import 'package:flutter/cupertino.dart';

import 'employee.dart';

class Payslip {
  final InvoiceInfo info;
  final Employee dataemployee;

  final List<InvoiceItem> items;

  const Payslip({
    required this.info,
    required this.dataemployee,
    required this.items,
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
  final String income;
  final ammount;

  const InvoiceItem({
    required this.income,
    required this.ammount,
  });
}
