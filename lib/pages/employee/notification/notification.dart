import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:format_indonesia/format_indonesia.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:magentahrdios/services/api_clien.dart';
import 'package:magentahrdios/services/attendances.dart';
import 'package:magentahrdios/utalities/color.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  var employeeId;
  var isLoading = true;
  List? attendances;
  var NoteTextCtr = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getDataPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        // iconTheme: IconThemeData(
        //   color: Colors.white, //modify arrow color from here..
        // ),
        backgroundColor: baseColor,
        title: new Text(
          "Notification",
          style: TextStyle(
              color: Colors.white,
              fontFamily: "Roboto-medium",
              fontSize: 18,
              letterSpacing: 0.5),
        ),
      ),
      body: isLoading == true
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(attendances!.length, (index) {
                      return Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "${Waktu(DateTime.parse("${attendances![index]['date']}")).yMMMMEEEEd()}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: "Roboto-regular",
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.5),
                              ),
                            ),
                            Column(
                              children: List.generate(
                                  attendances![index]['data'].length, (index1) {
                                var data = attendances![index]['data'][index1];

                                return Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Card(
                                    child: Container(
                                      width: Get.mediaQuery.size.width,
                                      height: Get.mediaQuery.size.height / 6,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.all(10),
                                                child: Text(
                                                  "${DateFormat("HH:mm:ss").format(DateTime.parse(data['clock_out'].toString()))}",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      fontFamily:
                                                          "Roboto-regular",
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      letterSpacing: 0.5),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  width: double.maxFinite,
                                                  alignment:
                                                      Alignment.centerRight,
                                                  margin: EdgeInsets.all(10),
                                                  child:
                                                      data['overtime_approval_status'] ==
                                                              null
                                                          ? InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  NoteTextCtr
                                                                          .text =
                                                                      data[
                                                                          'note'];
                                                                });
                                                                alert(
                                                                    data['id'],
                                                                    "${data['employee']['first_name']!}",
                                                                    data[
                                                                        'clock_out']);
                                                              },
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              3),
                                                                  color: Colors
                                                                      .black12,
                                                                ),
                                                                child: Padding(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(2),
                                                                    child: Icon(
                                                                      Icons
                                                                          .check,
                                                                      size: 15,
                                                                      color: Colors
                                                                          .black45,
                                                                    )),
                                                              ),
                                                            )
                                                          : Container(
                                                              child: Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                width: 73,
                                                                height: 17,
                                                                decoration: BoxDecoration(
                                                                    color: data['overtime_approval_status'] ==
                                                                            "approved"
                                                                        ? greenColorInfo
                                                                        : redColorInfo,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10)),
                                                                child:
                                                                    Container(
                                                                  child: Text(
                                                                    "${data['overtime_approval_status']}"
                                                                        .toUpperCase(),
                                                                    style: TextStyle(
                                                                        color: data['overtime_approval_status'] ==
                                                                                "approved"
                                                                            ? greenColor
                                                                            : redColor,
                                                                        fontFamily:
                                                                            "Roboto-regular",
                                                                        fontSize:
                                                                            10,
                                                                        letterSpacing:
                                                                            0.5),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            height: 1,
                                            color:
                                                Colors.black.withOpacity(0.5),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 10, top: 10),
                                            child: Text(
                                              "${data['employee']['first_name']!} (${data['employee']['employee_id']})",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontFamily: "Roboto-medium",
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 0.5),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 10, top: 5),
                                            child: Text(
                                              "Ket Lembur: ${data['note']}",
                                              style: TextStyle(
                                                  color: Colors.black
                                                      .withOpacity(0.7),
                                                  fontSize: 11,
                                                  fontFamily: "Roboto-regular",
                                                  fontWeight: FontWeight.w300,
                                                  letterSpacing: 0.5),
                                            ),
                                          ),
                                          data['overtime_approval_status'] !=
                                                  null
                                              ? Container(
                                                  margin: EdgeInsets.only(
                                                      left: 10, top: 5),
                                                  child: Text(
                                                    "${data['overtime_approval_status'] == "approved" ? "Disetujui Oleh" : "Ditolak Oleh "} ${data['approval_by'] != null ? data['approval_by']['first_name'] : "-"} ",
                                                    style: TextStyle(
                                                        color: Colors.black
                                                            .withOpacity(0.7),
                                                        fontSize: 11,
                                                        fontFamily:
                                                            "Roboto-regular",
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        letterSpacing: 0.5),
                                                  ),
                                                )
                                              : Container()
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            )
                          ],
                        ),
                      );
                    })),
              ),
            ),
    );
  }

  _getDataPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      employeeId = sharedPreferences.getString("user_id");

      fetchAttendances(employeeId.toString());
    });
  }

  Future fetchAttendances(var id) async {
    try {
      setState(() {
        isLoading = true;
      });
      http.Response response =
          await http.get(Uri.parse("$base_url/api/notification/${employeeId}"));

      attendances = jsonDecode(response.body);
      //print("data ${jsonDecode(response.body[0])}");

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print("${e}");
    }
  }

  var alertStyle = AlertStyle(
      titleStyle: TextStyle(
          color: Colors.black, fontSize: 15, fontFamily: "Roboto-bold"),
      descStyle: TextStyle(
          color: Colors.black,
          fontSize: 13,
          fontFamily: "Roboto-regular",
          fontWeight: FontWeight.w300,
          letterSpacing: 0.5));

  void alert(id, name, date) async {
    var alert = await Alert(
        style: alertStyle,
        context: context,
        title: "Approval Lembur",
        desc: "Berikut ini data lembur ${name}  pada ${date}",

        //   // desc: "Apaka kamu yakin melakukan check out pada pukul ${time} ",
        content: Column(
          children: <Widget>[
            TextField(
              controller: NoteTextCtr,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Keterangan Lembur',
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            color: baseColor,
            onPressed: () {
              print(NoteTextCtr.text);
              AttendancesApi().overtimeApproval(
                  context, id, "approved", NoteTextCtr.text, employeeId);
            },
            child: Text(
              "Approve",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          DialogButton(
            color: redColor,
            onPressed: () {
              AttendancesApi().overtimeApproval(
                  context, id, "rejected", NoteTextCtr.text, employeeId);
            },
            child: Text(
              "Reject",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
    // if (alert=="update"){
    //   //_getDataPref();
    //
    // }

    // Alert(
    //
    //   context: context,
    //   type: AlertType.warning,
    //   title: "Approval",
    //   // desc: "Apaka kamu yakin melakukan check out pada pukul ${time} ",
    //   desc: "Berikut ini data lembur ${name} ",
    //   buttons: [
    //     DialogButton(
    //       child: Text(
    //         "Iya",
    //         style: TextStyle(color: Colors.white, fontSize: 20),
    //       ),
    //       onPressed: () {
    //         // Navigator.pop(context);
    //         // var date=DateFormat('yyyy-MM-dd').format(DateTime.now());
    //         // var time=DateFormat('HH:mm:ss').format(DateTime.now());
    //         // validator.validation_checkout(
    //         //     context,
    //         //     photos,
    //         //     remark,
    //         //     lat,
    //         //     long,
    //         //     employee_id,
    //         //     date,
    //         //     time,
    //         //     departement_name,
    //         //     distance,
    //         //     office_latitude,
    //         //     office_longitude,
    //         //     category,isLembur);
    //       },
    //       color: btnColor1,
    //     ),
    //     DialogButton(
    //       child: Text(
    //         "Batalkan",
    //         style: TextStyle(color: Colors.white, fontSize: 20),
    //       ),
    //       onPressed: () => Navigator.pop(context),
    //       color: Colors.black38,
    //     )
    //   ],
    // ).show();
  }
}
