import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:format_indonesia/format_indonesia.dart';
import 'package:get/get.dart';
import 'package:magentahrdios/pages/admin/project/shimmer_project.dart';
import 'package:magentahrdios/pages/employee/leave/LeaveEdit.dart';
import 'package:magentahrdios/pages/employee/leave/TabMenuLeave.dart';
import 'package:magentahrdios/services/api_clien.dart';
import 'package:magentahrdios/utalities/color.dart';
import 'package:magentahrdios/utalities/constants.dart';

import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class LeaveListStatusAdmin extends StatefulWidget {
  LeaveListStatusAdmin({this.status});

  var status;

  @override
  _LeaveListStatusAdminState createState() => _LeaveListStatusAdminState();
}

class _LeaveListStatusAdminState extends State<LeaveListStatusAdmin> {
  //variable
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  var user_id;
  var _leaves;

  Map? _projects;
  bool _loading = true;

  Widget _buildnodata() {
    return Container(
      height: MediaQuery.of(context).size.height - 150,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: no_data_leave,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                child: Text(
              "Tidak ada cuti",
              style: TextStyle(color: Colors.black38, fontSize: 18),
            )),
          ],
        ),
      ),
    );
  }

//main contex---------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        child: Container(
          child: Container(
            color: Colors.white38,
            child: Container(
              child: _loading
                  ? Center(
                      child: ShimmerProject(),
                    )
                  : ListView.builder(
                      itemCount: _leaves['data'].length <= 0
                          ? 1
                          : _leaves['data'].length,
                      itemBuilder: (context, index) {
                        return _leaves['data'].length.toString() == '0'
                            ? _buildnodata()
                            : _leave(index);
                      }),
            ),
          ),
        ),
        onRefresh: getDatapref,
      ),
    );
  }

  Widget _leave(index) {
    var id = _leaves['data'][index]['id'];
    var date_of_filing = _leaves['data'][index]['date_of_filing'];
    var leave_dates = _leaves['data'][index]['leave_dates'];
    var description = _leaves['data'][index]['description'];

    // var date_of_filing=DateFormat().format(DateFormat().parse(_leaves['data'][index]['date_of_filing'].toString()));
    return InkWell(
      onTap: () {},
      child: Card(
        elevation: 2,
        child: Container(
          margin: EdgeInsets.only(top: 10, bottom: 20),
          width: Get.mediaQuery.size.width,
          child: Container(
            margin: EdgeInsets.only(top: 10, left: 5, right: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: Get.mediaQuery.size.width,
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    "${Waktu(DateTime.parse(_leaves['data'][index]['date_of_filing'].toString())).yMMMMEEEEd()}",
                    style: TextStyle(
                        color: baseColor,
                        fontFamily: "Roboto-medium",
                        letterSpacing: 0.5,
                        fontSize: 14),
                    textAlign: TextAlign.end,
                  ),
                  // child: Text(
                  //   DateFormat('dd/MM/yyyy').format(DateTime.parse(
                  //       _leaves['data'][index]['date_of_filing'].toString())),
                  //   style: TextStyle(
                  //       color: baseColor, fontFamily: "Roboto-regular"),
                  //   textAlign: TextAlign.end,
                  // ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  height: 1,
                  color: blackColor3,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text(
                    "${_leaves['data'][index]['employee']['first_name']} (${_leaves['data'][index]['employee']['employee_id']})",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Roboto-bold",
                        fontSize: 15,
                        letterSpacing: 0.5),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                Container(
                  child: Text(
                    "Tanggal Cuti",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Roboto-regular",
                        fontSize: 13,
                        letterSpacing: 0.5),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Flex(direction: Axis.horizontal, children: [
                  Expanded(
                      child: Container(
                    child: Text(
                      _leaves['data'][index]['leave_dates'] == null
                          ? ""
                          : "[${_leaves['data'][index]['leave_dates'].toString()}]",
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontFamily: "Roboto-regular",
                          fontSize: 13,
                          letterSpacing: 0.5),
                    ),
                  ))
                ]),
                SizedBox(
                  height: 10,
                ),

                _leaves['data'][index]['description'] != null
                    ? Container(
                        child: Text(
                          "Keterangan",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Roboto-regular",
                              fontSize: 13,
                              letterSpacing: 0.5),
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 5,
                ),

                Flex(direction: Axis.horizontal, children: [
                  Expanded(
                      child: Container(
                    child: Text(
                      _leaves['data'][index]['description'] == null
                          ? ""
                          : _leaves['data'][index]['description'].toString(),
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontFamily: "SFReguler"),
                    ),
                  ))
                ]),
                SizedBox(
                  height: 15,
                ),
                // _leaves['data'][index]['status']=="approved"?Container():btnAction(id,_leaves['data'][index]['date_of_filing'],_leaves['data'][index]['leave_dates'],_leaves['data'][index]['description'])
                _leaves['data'][index]['status'] == "pending"
                    ? btnAction(
                        id,
                        _leaves['data'][index]['date_of_filing'],
                        _leaves['data'][index]['leave_dates'],
                        _leaves['data'][index]['description'])
                    : _leaves['data'][index]['status'] == "approved"
                        ? detailApproval(index)
                        : detailRejection(index)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget btnAction(id, date_of_filing, leave_dates, description) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            child: Ink(
              decoration: BoxDecoration(
                color: Colors.black12,
              ),
              child: IconButton(
                iconSize: 20,
                icon: Icon(
                  Icons.check,
                  color: Colors.black45,
                ),
                onPressed: () {
                  //print('pressed');
                  Services services = new Services();
                  // services.deleteLeave(context, id);
                  var remarkController = new TextEditingController();
                  Alert(
                    context: context,
                    type: AlertType.warning,
                    title: "Apakah kamu yakin?",
                    desc: "Data akan di Approve/Reject",
                    content: Column(
                      children: <Widget>[
                        // TextField(
                        //   controller: remarkController,
                        //   decoration: InputDecoration(
                        //     labelText: 'Catatan',
                        //   ),
                        // ),
                      ],
                    ),
                    buttons: [
                      DialogButton(
                        child: Text(
                          "Approve",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () {
                          Get.back();
                          services
                              .leaveAproval(context, id, "approve")
                              .then((value) {
                            _dataLeave(user_id);
                          });
                        },
                        color: Colors.green,
                      ),
                      DialogButton(
                        child: Text(
                          "Reject",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () {
                          Get.back();
                          services
                              .leaveAproval(context, id, "reject")
                              .then((value) {
                            _dataLeave(user_id);
                          });
                        },
                        gradient:
                            LinearGradient(colors: [Colors.red, Colors.red]),
                      )
                    ],
                  ).show();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget detailApproval(index) {
    return Container(
      width: Get.mediaQuery.size.width,
      child: Column(
        children: [
          Container(
            width: Get.mediaQuery.size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(2),
                        bottomRight: Radius.circular(2),
                        topRight: Radius.circular(2),
                        bottomLeft: Radius.circular(2)),
                    color: Colors.green,
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(7),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Approved",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "SFReguler",
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget detailRejection(index) {
    return Container(
      width: Get.mediaQuery.size.width,
      child: Column(
        children: [
          Container(
            width: Get.mediaQuery.size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(2),
                        bottomRight: Radius.circular(2),
                        topRight: Radius.circular(2),
                        bottomLeft: Radius.circular(2)),
                    color: Colors.red,
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(7),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Rejected",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "SFReguler",
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void editLeave(var id, date_of_filing, leave_dates, description) async {
    var result = await Get.to(LeaveEdit(
      id: id,
      date_of_filing: date_of_filing,
      leave_dates: leave_dates,
      description: description,
    ));
    if (result == "update") {
      _dataLeave(user_id);
    }
  }

  //ge data from api--------------------------------
  Future _dataLeave(var user_id) async {
    try {
      setState(() {
        _loading = true;
      });
      http.Response response = await http.get(
          Uri.parse("$base_url/api/leave-submissions?status=${widget.status}"));
      _leaves = jsonDecode(response.body);
      setState(() {
        _loading = false;
      });
    } catch (e) {}
  }

  Future getDatapref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      user_id = sharedPreferences.getString("user_id");
      _dataLeave(user_id);
    });
  }

  @override
  void initState() {
    super.initState();
    //show modal detail project
    getDatapref();
  }

  void choiceAction(String choice) {
    if (choice == Constants.Leave) {
      Get.testMode = true;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TabsMenuLeavestatus()),
      );
      //print(choice);
    }
  }
}
