import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:format_indonesia/format_indonesia.dart';
import 'package:get/get.dart';
import 'package:magentahrdios/pages/announcement/attachment.dart';
import 'package:magentahrdios/services/api_clien.dart';
import 'package:magentahrdios/utalities/color.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CareerPage extends StatefulWidget {
  @override
  _CareerPageState createState() => _CareerPageState();
}

class _CareerPageState extends State<CareerPage> {
  bool _loading = true;
  List?_careers;
  var user_id;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDatapref();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.mediaQuery.size.width,
        height: Get.mediaQuery.size.height,
        child: _loading==true?Center(
          child: CircularProgressIndicator(
          color: baseColor,
          ),
        ): Container(
          margin: EdgeInsets.only(top: 20),
          child: ListView.builder(
            itemCount: _careers!.length,


            itemBuilder: (context,index) {
              return Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          child: Text(
                            "${Waktu(DateTime.parse(_careers![index]['date'])).yMMMMEEEEd()}",
                            style: TextStyle(
                                color: baseColor,
                                fontSize: 13,
                                fontFamily: "roboto-bold"),
                          ),
                        ),
                        index==0?Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            width: double.maxFinite,
                            child: Container(
                              width: 60,
                              height: 20,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(
                                  left: 20, right: 20, top: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: greenColorInfo),
                              child: Text(
                                "Active",
                                style: TextStyle(
                                  color: greenColor,
                                  fontSize: 10,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ),
                        ):Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            width: double.maxFinite,
                            child: Container(
                              width: 0,
                              height: 20,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: greenColorInfo),
                              child: Text(
                                "",
                                style: TextStyle(
                                  color: greenColor,
                                  fontSize: 10,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: Text(
                        "Jabatan : ${_careers![index]['position_setting']['position']}",
                        style: TextStyle(
                          color: blackColor4,
                          letterSpacing: 0.5,
                          fontFamily: "roboto-regular",
                          fontSize: 12
                        ),
                      ),
                    ),
                    _careers![index]['attachment']!=""?ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: DetailAttachentPage(attachment: _careers![index]['attachment'],)));
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(redBaseColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                        ),
                        child: const Text(
                          "LAMPIRAN",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontFamily: "Roboto-regular"),
                        )):Container(),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      height: 2,
                      color: Colors.black.withOpacity(0.1),
                    )
                  ],
                ),
              );
            }
          ),
        ),
      ),
    );
  }

  Future getDatapref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      user_id = sharedPreferences.getString("user_id");
      _dataLeave(user_id);
    });
  }

  Future _dataLeave(var user_id) async {
    try {
      setState(() {
        _loading = true;
      });
      http.Response response =
          await http.get(Uri.parse("$base_url/api/employees/$user_id/careers"));
      var data = jsonDecode(response.body);
      _careers=data['data']['careers'];
      // _reviews=data['data']['reviews'];
      setState(() {
        _loading = false;
      });
    } catch (e) {
      print("${e}");
    }
  }
}
