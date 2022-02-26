import 'package:flutter/material.dart';

class Pdf {
  final String employee_id;
  final String name;
  final String division;
  final String departement;
  final String job_title;
  final String status_karyawan;

  const Pdf(
      {required this.employee_id,
      required this.name,
      required this.division,
      required this.departement,
      required this.job_title,
      required this.status_karyawan});
}
