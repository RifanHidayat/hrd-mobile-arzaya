import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magentahrdios/pages/employee/login/login.dart';
import 'package:magentahrdios/pages/opening/welcome.dart';
import 'package:magentahrdios/utalities/color.dart';
import 'package:magentahrdios/utalities/constants.dart';

class SplassScreen extends StatefulWidget {
  @override
  _SplassScreenState createState() => _SplassScreenState();
}

class _SplassScreenState extends State<SplassScreen> {
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: Get.mediaQuery.size.height,
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: Get.mediaQuery.size.height / 2 - 100,
                child: Container(
                  width: Get.mediaQuery.size.width,
                  child: Center(
                    child: Image.asset(
                      "assets/logo.jpg",
                      width: 250,
                      height: 100,
                    ),
                  ),
                ),
              ),
              Positioned(
                  top: Get.mediaQuery.size.height / 2 ,
                  child: Container(
                    width: Get.mediaQuery.size.width,
                    child: Center(
                      child: Text(
                        "Arzaya | Outsourced Accounting & Tax Services",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Roboto-Regular",
                            fontSize: 13),
                      ),
                    ),
                  )),
              Positioned(
                  bottom: 40,
                  left: Get.mediaQuery.size.width / 2 - 10,
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 100),
                      child: Container(
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator(
                          color: baseColor,
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Future<Timer> startTimer() async {
    return Timer(Duration(seconds: 6), onDone);
  }

  void onDone() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginEmployee()));
  }
}
