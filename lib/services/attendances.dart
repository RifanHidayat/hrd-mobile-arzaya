import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:magentahrdios/pages/employee/notification/notification.dart';
import 'package:magentahrdios/services/api_clien.dart';
import 'package:magentahrdios/utalities/alert_dialog.dart';

class AttendancesApi{
  Future<void> overtimeApproval(BuildContext context, var id, status,note,employeeId) async {
    loading(context);
    final response = await http.patch(
        Uri.parse("$base_url/api/attendances/${id}/overtime"),body: {
          "status":status.toString(),
          "note":note.toString(),
          "employee_id":employeeId.toString(),
          'date':DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
    });

    final responseJson = jsonDecode(response.body);
    if (responseJson['code'] == 200) {
      Get.back();
      Get.back();

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => NotificationPage()));
      toast_success("${responseJson['message']}");

    } else {
      Get.back();
      toast_error("${responseJson['message']}");
    }
  }
}