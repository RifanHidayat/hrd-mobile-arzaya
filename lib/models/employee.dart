import 'package:flutter/material.dart';

class Employee {
  final String name;
  final String employee_id;
  final String work_placement;
  final String status_karyawan;
  final String status_ptkp;
  final String lama_bergabung;
  final String lama_bekerja;

  const Employee(
      {required this.name,
      required this.employee_id,
      required this.work_placement,
      required this.status_karyawan,
      required this.status_ptkp,
      required this.lama_bekerja,
      required this.lama_bergabung});
}
