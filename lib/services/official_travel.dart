import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:magentahrdios/services/api_clien.dart';
import 'package:magentahrdios/utalities/alert_dialog.dart';
import 'package:http/http.dart' as http;

class OfficialTravel{

  Future<void> rembers(BuildContext context, var employee_id,officialTravelId,List images,) async {
    loading(context);
   //  print(jsonEncode(images));
   //  Map<String, dynamic> output = jsonDecode(images.toString());
   // print("data ${images[0]['amount']}");
  //  print(images.toString());
    final response =
    await http.post(Uri.parse("$base_url/api/official-travel/employee/rembers"), body: {
      "employee_id": employee_id.toString(),
      "official_travel_id":officialTravelId.toString(),
      'images':jsonEncode(images)

    });
    print(images);
    final responseJson = jsonDecode(response.body);

    if (responseJson['code'] == 200) {
      toast_success("${responseJson['message']}");
      Get.back();
      Navigator.pop(context, 'update');
    } else {
      toast_error("${responseJson['message']}");
      Get.back();
      //print(responseJson.toString());
    }
  //
  //
   }
}