import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:format_indonesia/format_indonesia.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:magentahrdios/pages/employee/permission/add.dart';
import 'package:magentahrdios/pages/employee/permission/shimmer_effect.dart';
import 'package:magentahrdios/pages/employee/permission/tabmenu.dart';
import 'package:magentahrdios/services/api_clien.dart';
import 'package:magentahrdios/utalities/color.dart';
import 'package:magentahrdios/utalities/constants.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ListPermissionPageEmployee extends StatefulWidget {
  ListPermissionPageEmployee({this.status});

  var status;

  @override
  _ListPermissionPageEmployeeState createState() =>
      _ListPermissionPageEmployeeState();
}

class _ListPermissionPageEmployeeState
    extends State<ListPermissionPageEmployee> {
  //variable
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  var user_id;
  var _permission;

  bool _loading = true;
  var pendingCount = 0;

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
              "Belum ada pengajuan izin",
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
      appBar: AppBar(
        actions: <Widget>[
          // Container(
          //   width: 10,
          //   height: 5,
          //   color: redBaseColor,
          // ),
          Stack(
            children: [
              pendingCount > 0
                  ? Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        alignment: Alignment.center,
                        width: 13,
                        height: 13,
                        child: Text(
                          "${pendingCount}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: redBaseColor.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(30)),
                      ),
                    )
                  : Container(),
              PopupMenuButton<String>(
                onSelected: choiceAction,
                itemBuilder: (BuildContext context) {
                  return Constants.PermissionStatus.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
            ],
          )
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        // iconTheme: IconThemeData(
        //   color: Colors.white, //modify arrow color from here..
        // ),
        backgroundColor: baseColor,
        title: new Text(
          "Pengajuan Izin",
          style: TextStyle(
              color: Colors.white,
              fontFamily: "Roboto-medium",
              fontSize: 18,
              letterSpacing: 0.5),
        ),
      ),
      // appBar: AppBar(
      //   actions: <Widget>[
      //     PopupMenuButton<String>(
      //       onSelected: choiceAction,
      //       itemBuilder: (BuildContext context) {
      //         return Constants.PermissionStatus.map((String choice) {
      //           return PopupMenuItem<String>(
      //             value: choice,
      //             child: Text(choice),
      //           );
      //         }).toList();
      //       },
      //     )
      //   ],
      //   iconTheme: IconThemeData(
      //     color: Colors.black87, //modify arrow color from here..
      //   ),
      //   backgroundColor: Colors.white,
      //   title: new Text(
      //     "Pengajuan Izin",
      //     style: TextStyle(color: Colors.black87),
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Get.to(AddPermissionPageEmployee());
          addPermission();
          // Navigator.push(
          //     context,
          //     PageTransition(
          //         type: PageTransitionType.rightToLeft,
          //         child: AddPermissionPageEmployee()));
        },
        child: Icon(Icons.add),
        backgroundColor: baseColor,
      ),
      body: RefreshIndicator(
        child: Container(
          child: Container(
            margin: EdgeInsets.only(top: 10),
            color: Colors.white38,
            child: Container(
              child: _loading
                  ? Center(
                      child: ShimmerProject(),
                    )
                  : ListView.builder(
                      itemCount: _permission['data'].length <= 0
                          ? 1
                          : _permission['data'].length,
                      // itemCount:1,

                      itemBuilder: (context, index) {
                        return _permission['data'].length.toString() == '0'
                            ? _buildnodata()
                            : _leave(index);
                        return _leave(1);
                      }),
            ),
          ),
        ),
        onRefresh: getDatapref,
      ),
    );
  }

  Widget _leave(index) {
    var id = _permission['data'][index]['id'];
    var date_of_filing = _permission['data'][index]['date_of_filing'];
    var permission_dates = _permission['data'][index]['permission_dates'];
    var description = _permission['data'][index]['description'];
    var category = _permission['data'][index]['permission_category']['name'];
    var max_day = _permission['data'][index]['permission_category']['max_day'];

    // var date_of_filing=DateFormat().format(DateFormat().parse(_leaves['data'][index]['date_of_filing'].toString()));
    return Card(
      elevation: 1,
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
                  "${Waktu(DateTime.parse(_permission['data'][index]['date_of_filing'].toString())).yMMMMEEEEd()}",
                  style: TextStyle(
                      color: baseColor,
                      fontFamily: "Roboto-medium",
                      letterSpacing: 0.5,
                      fontSize: 14),
                  textAlign: TextAlign.end,
                ),
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
                width: Get.mediaQuery.size.width,
                child: Text(
                  "${category} (Maksimal:${max_day}  Hari)",
                  style: TextStyle(
                      color: Colors.black87, fontFamily: "Roboto-medium"),
                  textAlign: TextAlign.start,
                ),
              ),

              SizedBox(
                height: 10,
              ),
              Container(
                child: Text(
                  "Tanggal Izin",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: "Roboto-regular"),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Flex(direction: Axis.horizontal, children: [
                Expanded(
                    child: Container(
                  child: Text(
                    "${permission_dates}",
                    style: TextStyle(
                        color: blackColor3,
                        fontFamily: "Roboto-regular",
                        fontSize: 12),
                  ),
                ))
              ]),
              SizedBox(
                height: 15,
              ),

              description != null
                  ? Container(
                      child: Text(
                        "Keterangan",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontFamily: "Roboto-regular"),
                      ),
                    )
                  : Container(),
              SizedBox(
                height: 5,
              ),
              description != null
                  ? Flex(direction: Axis.horizontal, children: [
                      Expanded(
                          child: Container(
                        child: Text(
                          "${_permission['data'][index]['description'].toString()}",
                          style: TextStyle(
                              color: blackColor3,
                              fontSize: 12,
                              fontFamily: "Roboto-regular"),
                        ),
                      ))
                    ])
                  : Container(),
              SizedBox(
                height: 15,
              ),

              // _leaves['data'][index]['status']=="aproved"?Container():btnAction(id,_leaves['data'][index]['date_of_filing'],_leaves['data'][index]['leave_dates'],_leaves['data'][index]['description'])
            ],
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
            margin: EdgeInsets.only(right: 10),
            width: 40,
            height: 40,
            child: Ink(
              decoration: BoxDecoration(
                color: Colors.black12,
              ),
              child: IconButton(
                iconSize: 20,
                icon: Icon(
                  Icons.edit_outlined,
                  color: Colors.black45,
                ),
                onPressed: () {
                  // Get.to(LeaveEdit(
                  //   id: id,
                  //   date_of_filing: date_of_filing,
                  //   leave_dates: leave_dates,
                  //   description: description,));
                  //editLeave(id, date_of_filing, leave_dates, description);
                },
              ),
            ),
          ),
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
                  Icons.restore_from_trash_outlined,
                  color: Colors.black45,
                ),
                onPressed: () {
                  //print('pressed');
                  Services services = new Services();
                  // services.deleteLeave(context, id);
                  Alert(
                    context: context,
                    type: AlertType.warning,
                    title: "Apakah anda yakin?",
                    desc: "Data akan dihapus",
                    buttons: [
                      DialogButton(
                        child: Text(
                          "batalkan",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () => Navigator.pop(context),
                        color: Colors.grey,
                      ),
                      DialogButton(
                        child: Text(
                          "Iya",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () {
                          Get.back();
                          services.deleteLeave(context, id).then((value) {
                            _dataPermission(user_id);
                          });
                        },
                        gradient: LinearGradient(
                            colors: [Colors.green, Colors.green]),
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

  // void editLeave(var id,date_of_filing,leave_dates,description) async{
  //   var result=await Get.to(LeaveE(
  //     id: id,
  //     date_of_filing: date_of_filing,
  //     leave_dates: leave_dates,
  //     description: description,));
  //   if (result=="update"){
  //     _dataPermission(user_id);
  //   }
  // }
  //ge data from api--------------------------------
  Future _dataPermission(var user_id) async {
    try {
      setState(() {
        _loading = true;
      });
      http.Response response = await http.get(Uri.parse(
          "$base_url/api/employees/$user_id/permission-submissions?status=${widget.status}"));
      _permission = jsonDecode(response.body);

      setState(() {
        _loading = false;
      });
    } catch (e) {}
  }

  Future _countPending(var user_id) async {
    try {
      setState(() {
        // _loading = true;
      });
      http.Response response = await http.get(Uri.parse(
          "$base_url/api/employees/$user_id/permission-submissions?status=pending"));
      var data = jsonDecode(response.body);
      List list = await data['data'] ?? [];

      setState(() {
        ///_loading = false;
        pendingCount = list.length;
      });
    } catch (e) {
      print("error ${e}");
    }
  }

  Future getDatapref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      user_id = sharedPreferences.getString("user_id");
      _dataPermission(user_id);
      _countPending(user_id);
    });
  }

  void addPermission() async {
    var result = await Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeft,
            child: AddPermissionPageEmployee()));

    if (result == "update") {
       _dataPermission(user_id);
      _countPending(user_id);
    }
  }

  void statusPermission() async {
    var result = await Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeft,
            child: TabMenuPermissionPageEmployee()));

    if (result == "update") {
       _dataPermission(user_id);
      _countPending(user_id);
    }
  }

  @override
  void initState() {
    super.initState();
    //show modal detail project
    getDatapref();
  }

  void choiceAction(String choice) {
    if (choice == Constants.Permission) {
      Get.testMode = true;
      // Get.to(TabMenuPermissionPageEmployee());
      statusPermission();
      // Navigator.push(
      //     context,
      //     PageTransition(
      //         type: PageTransitionType.rightToLeft,
      //         child: TabMenuPermissionPageEmployee()));
    }
  }
}
