import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:magentahrdios/pages/employee/login/login.dart';

import 'package:magentahrdios/pages/opening/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  var username,
      contac,
      first_name,
      last_name,
      email,
      gender,
      employee_id,
      profile_background;
  var user_id, value;

  void saveDataEmployee(
      int value,
      String user_id,
      String employee_id,
      String username,
      first_name,
      last_name,
      email,
      profile_background,
      contact,
      depaertement_id,
      departement_name,
      departement_lat,
      departement_long,
      String gender) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt("value", value);
    sharedPreferences.setString("user_id", user_id);
    sharedPreferences.setString("employee_id", employee_id);
    sharedPreferences.setString("username", username);
    sharedPreferences.setString("first_name", first_name);
    sharedPreferences.setString("last_name", last_name);

    sharedPreferences.setString("email", email);
    sharedPreferences.setString("profile_background", profile_background);


    sharedPreferences.setString("contact", contact);

    sharedPreferences.setString("departement_id", depaertement_id);
    sharedPreferences.setString("departement_name", departement_name);
    sharedPreferences.setString("gender", gender);

    sharedPreferences.setString("departement_lat", departement_lat);
    sharedPreferences.setString("departement_long", departement_long);





  }

  void logout(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) => LoginEmployee()),
      ModalRoute.withName('/Employee'),
    );
  }
}
