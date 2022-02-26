import 'dart:convert';
import 'dart:developer';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';



import 'package:magentahrdios/pages/admin/absence/tabmenu_absence.dart';
import 'package:magentahrdios/pages/admin/employees/DetailEmployee.dart';
import 'package:magentahrdios/pages/admin/employees/list.dart';
import 'package:magentahrdios/pages/admin/leave/tabmenu_offwork.dart';
import 'package:magentahrdios/pages/admin/permission/tabmenu.dart';
import 'package:magentahrdios/pages/admin/project/tabmenu_project.dart';
import 'package:magentahrdios/pages/admin/sick/tabmenu.dart';
import 'package:magentahrdios/pages/employee/account/profile.dart';
import 'package:magentahrdios/pages/employee/attendances/attendances.dart';
import 'package:magentahrdios/pages/employee/attendances/checkin.dart';
import 'package:magentahrdios/pages/employee/attendances/checkout.dart';
import 'package:magentahrdios/pages/employee/leave/LeaveList.dart';
import 'package:magentahrdios/pages/employee/login/login.dart';
// import 'package:magentahrdios/pages/employee/login/login.dart';
import 'package:magentahrdios/pages/employee/permission/list.dart';
import 'package:magentahrdios/pages/employee/sick/list.dart';
import 'package:magentahrdios/services/api_clien.dart';
import 'package:magentahrdios/utalities/color.dart';
import 'package:magentahrdios/utalities/constants.dart';
import 'package:magentahrdios/utalities/fonts.dart';
import 'package:page_transition/page_transition.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeAdmin extends StatefulWidget {
  @override
  _HomeAdminState createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  Map? _employee, _projects;
  List? _absence;
  Map? _permission;
  Map? _leave;
  Map? _sick;
  bool _isLoading_employee = true;
  bool _isLoading_project = true;
  bool _isLoading_absence = true;
  bool _isLoading_sick = true;
  bool _isLoading_permission = true;
  bool _isLoading_leave = true;
  var lengthPermission = 0, lengthSick = 0, lengthleave = 0;

  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  // final List<Notif> ListNotif = [];
  var _absenPending, user_id;
  var CHANNEL_CHECKIN_ID = 1;
  var CHANNEL_CHECKOUT_ID = 2;
  var checkinTime = new Time(07, 45, 0);
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

  final GlobalKey<ScaffoldState> scaffoldState = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text('Tap back again to leave'),
        ),
        child: RefreshIndicator(
          child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: SizedBox.expand(
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Stack(
                  children: <Widget>[
                    SizedBox.expand(
                      child: DraggableScrollableSheet(
                        initialChildSize: 0.3,
                        maxChildSize: 0.8,
                        minChildSize: 0.1,
                        builder: (BuildContext context, myscrollController) {
                          return Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  color: Colors.grey,
                                  width: 100,
                                  height: 20,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                        height: double.infinity,
                        width: double.infinity,
                        color: Colors.white),
                    Container(
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    width: double.infinity,
                                    color: baseColor,
                                    height: 230,
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(left: 10, top: 75),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            "Karyawan",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontFamily: "Roboto-medium",
                                                letterSpacing: 0.5),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  ///wodget employee
                                  //_buildemployee(),
                                  _listEmployee(),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10, top: 5),
                              child: Text("Main Menu",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "roboto-medium",
                                      fontSize: 15,
                                      letterSpacing: 0.5,
                                      fontWeight: FontWeight.w500)),
                            ),
                            _buildCardMenu(),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10, top: 5),
                              child: Text("Announcement",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "roboto-medium",
                                      fontSize: 15,
                                      letterSpacing: 0.5,
                                      fontWeight: FontWeight.w500)),
                            ),
                            // _buildInformation(),
                            _buildNoAbbouncement()
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          onRefresh: dataProject,
        ),
      ),
    );
  }

  Widget _buildNoAbbouncement() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              child: no_data_announcement,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Belum ada pengumuman",
            style: TextStyle(
                color: Colors.black,
                fontFamily: "roboto-regular",
                fontSize: 12,
                letterSpacing: 0.5,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }

  Widget _buildMenuOffwork() {
    return Column(children: <Widget>[
      new Container(
        width: 70,
        height: 70,
        child: InkWell(
          onTap: () {
            // Navigator.push(context, MaterialPageRoute(
            //     builder: (context) => Tabstask()
            // ));
            //Navigator.pushNamed(context, "tabmenu_offwork_admin-page");
            navigatorLeave();
          },
          child: Stack(
            children: [
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(margin: EdgeInsets.all(15.0), child: offwork),
              ),
              Container(
                child: _isLoading_leave == true
                    ? Text("")
                    : Container(
                        margin: EdgeInsets.only(top: 15, right: 10),
                        width: double.maxFinite,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              child: lengthleave == 0
                                  ? Text("")
                                  : CircleAvatar(
                                      radius: 10,
                                      backgroundColor: Colors.redAccent,
                                      child: Text(
                                        "${lengthleave}",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
      Text("Cuti",
          style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: "Roboto-regular",
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5))
    ]);
  }

  Widget _buildMenuSick() {
    return Column(children: <Widget>[
      new Container(
        width: 70,
        height: 70,
        child: InkWell(
          onTap: () {
            // Get.to(TabmenuSickPageAdmin());
            navigatorSick();
          },
          child: Stack(
            children: [
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(margin: EdgeInsets.all(15.0), child: sick),
              ),
              Container(
                child: _isLoading_sick == true
                    ? Text("")
                    : Container(
                        margin: EdgeInsets.only(top: 15, right: 10),
                        width: double.maxFinite,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              child: lengthSick == 0
                                  ? Text("")
                                  : CircleAvatar(
                                      radius: 10,
                                      backgroundColor: Colors.redAccent,
                                      child: Text(
                                        "${lengthSick}",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
      Text("Sakit",
          style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              letterSpacing: 0.5,
              fontFamily: "Roboto-regular"))
    ]);
  }

  Widget _buildMenuPermission() {
    return Column(children: <Widget>[
      new Container(
        width: 70,
        height: 70,
        child: InkWell(
          onTap: () {
            navigatorPermission();
          },
          child: Stack(
            children: [
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child:
                    Container(margin: EdgeInsets.all(15.0), child: permission),
              ),
              Container(
                child: _isLoading_permission == true
                    ? Text("")
                    : Container(
                        margin: EdgeInsets.only(top: 15, right: 10),
                        width: double.maxFinite,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              child: lengthPermission == 0
                                  ? Text("")
                                  : CircleAvatar(
                                      radius: 10,
                                      backgroundColor: Colors.redAccent,
                                      child: Text(
                                        "${lengthPermission}",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
      Text("Izin",
          style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: "Roboto-regular",
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5))
    ]);
  }

  Widget _buildMenucheckin() {
    return Column(children: <Widget>[
      new Container(
        width: 70,
        height: 70,
        child: InkWell(
          onTap: () {
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => Checkin()));

            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: CheckinPage()));
          },
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(margin: EdgeInsets.all(15.0), child: checkin),
          ),
        ),
      ),
      Text("Checkin",
          style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: "Roboto-regular",
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5))
    ]);
  }

  Widget _buildMenucheckout() {
    return Column(children: <Widget>[
      new Container(
        width: 70,
        height: 70,
        child: InkWell(
          onTap: () {
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => Checkout()));
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: CheckoutPage()));
          },
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(margin: EdgeInsets.all(15.0), child: checkout),
          ),
        ),
      ),
      Text("Checkout",
          style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: "Roboto-regular",
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5))
    ]);
  }

  Widget _buildMenuaabsenceApproval() {
    return Column(children: <Widget>[
      new Container(
        width: 70,
        height: 70,
        child: InkWell(
          onTap: () {
            // navigatorAttendances();
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => absence()));

            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft, child: absence()));
          },
          child: Stack(
            children: [
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(margin: EdgeInsets.all(15.0), child: absent),
              ),
              Container(
                child: _isLoading_absence == true
                    ? Text("")
                    : Container(
                        margin: EdgeInsets.only(top: 15, right: 10),
                        width: double.maxFinite,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              child: _absence!.length == 0
                                  ? Text("")
                                  : CircleAvatar(
                                      radius: 10,
                                      backgroundColor: Colors.redAccent,
                                      child: Text(
                                        "${_absence!.length}",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
      Text(
        "Kehadiran",
        style: subtitleMainMenu,
      )
    ]);
  }

  Widget _buildMenuaabsence() {
    return Column(children: <Widget>[
      new Container(
        width: 70,
        height: 70,
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft, child: absence()));
            //navigatorAttendances();
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => absence()));
          },
          child: Stack(
            children: [
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(margin: EdgeInsets.all(15.0), child: absent),
              ),
              Container(
                child: _isLoading_absence == true
                    ? Text("")
                    : Container(
                        margin: EdgeInsets.only(top: 15, right: 10),
                        width: double.maxFinite,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              child: _absence!.length == 0
                                  ? Text("")
                                  : CircleAvatar(
                                      radius: 10,
                                      backgroundColor: Colors.redAccent,
                                      child: Text(
                                        "${_absence!.length}",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
      Text(
        "Kehadiran",
        style: TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontFamily: "Roboto-regular",
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5),
      )
    ]);
  }

  Widget _buildMenuannouncement() {
    return Column(children: <Widget>[
      new Container(
        width: 70,
        height: 70,
        child: InkWell(
          onTap: () {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => Tabsappbudget()));
            Navigator.pushNamed(context, "Announcement_list_employee-page");
          },
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(margin: EdgeInsets.all(15.0), child: announcement),
          ),
        ),
      ),
      Text("Pengumuman", style: subtitleMainMenu)
    ]);
  }

  Widget _buildMenupayslip() {
    return Column(children: <Widget>[
      new Container(
        width: 70,
        height: 70,
        child: InkWell(
          onTap: () {
            // // Navigator.push(context,
            // //     MaterialPageRoute(builder: (context) => Tabsappbudget()));
            // Navigator.pushNamed(context, "pyslip_list_employee-page");

            // Services services = new Services();
            // services.payslipPermission(context, user_id);
          },
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(margin: EdgeInsets.all(15.0), child: pyslip),
          ),
        ),
      ),
      Text("Payslip",
          style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: "Roboto-regular",
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5))
    ]);
  }

  Widget _buildMenuloan() {
    return Column(children: <Widget>[
      new Container(
        width: 70,
        height: 70,
        child: InkWell(
          onTap: () {
            /*    Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ListLoanEmployeePag()));*/
          },
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(margin: EdgeInsets.all(15.0), child: loan),
          ),
        ),
      ),
      Text("Kasbon",
          style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              letterSpacing: 0.5,
              fontFamily: "Roboto-regular"))
    ]);
  }

  Widget _submission_leave() {
    return Column(children: <Widget>[
      new Container(
        width: 70,
        height: 70,
        child: InkWell(
          onTap: () {
            Get.back();
            // Navigator.pushNamed(context, "leave_list_employee-page");
            // Get.to(LeaveListEmployee(
            //   status: "approved",
            // ));
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: LeaveListEmployee(
                      status: "approved",
                    )));
          },
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(margin: EdgeInsets.all(15.0), child: offwork),
          ),
        ),
      ),
      Text("pengajuan Cuti",
          style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              letterSpacing: 0.5,
              fontFamily: "Roboto-regular"))
    ]);
  }

  Widget _submission_sick() {
    return Column(children: <Widget>[
      new Container(
        width: 70,
        height: 70,
        child: InkWell(
          onTap: () {
            Get.back();
            // Navigator.pushNamed(context, "leave_list_employee-page");
            // Get.to(ListSickPageEmployee(
            //   status: "approved",
            // ));
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: ListSickPageEmployee(
                      status: "approved",
                    )));
          },
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(margin: EdgeInsets.all(15.0), child: sick),
          ),
        ),
      ),
      Text("Pengajuan Sakit",
          style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: "Roboto-regular",
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5))
    ]);
  }

  Widget _submission_permission() {
    return Column(children: <Widget>[
      new Container(
        width: 70,
        height: 70,
        child: InkWell(
          onTap: () {
            // Navigator.pushNamed(context, "leave_list_employee-page");
            // Get.to(LeaveListEmployee(status: "approved",));
            // Get.to(ListPermissionPageEmployee(
            //   status: "approved",
            // ));
            Get.back();
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: ListPermissionPageEmployee(
                      status: "approved",
                    )));
          },
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(margin: EdgeInsets.all(15.0), child: permission),
          ),
        ),
      ),
      Text("Pengajuan izin",
          style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              letterSpacing: 0.5,
              fontFamily: "Roboto-regular"))
    ]);
  }

  Widget _buildMenuemployees() {
    return Column(children: <Widget>[
      new Container(
        width: 70,
        height: 70,
        child: InkWell(
          onTap: () {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => ListEmployee()));
            Get.back();
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child:ListEmployee()));
          },
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(margin: EdgeInsets.all(15.0), child: employees),
          ),
        ),
      ),
      Text("Karyawan",
          style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              letterSpacing: 0.5,
              fontFamily: "Roboto-regular"))
    ]);
  }

  Widget _buildmenudraggablescroll() {
    return Column(children: <Widget>[
      new Container(
        width: 70,
        height: 70,
        child: InkWell(
          onTap: () => showModalBottomSheet(
              backgroundColor: Colors.transparent,
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return FractionallySizedBox(
                  heightFactor: 0.4,
                  child: _draggableScroll(),
                );
              }),
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(margin: EdgeInsets.all(15.0), child: project),
          ),
        ),
      ),
      Text(
        "Fitur Lainnya",
        style: TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontFamily: "Roboto-regular",
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5),
      )
    ]);
  }

  Widget _buildMenuproject() {
    return Column(children: <Widget>[
      new Container(
        width: 70,
        height: 70,
        child: InkWell(
          onTap: () {
            // Get.to(TabsprojectAdmin());
          },
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(margin: EdgeInsets.all(15.0), child: project),
          ),
        ),
      ),
      Text(
        "Event",
        style: subtitleMainMenu,
      )
    ]);
  }

  Widget _buildCardMenu() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child: Container(
            width: double.infinity,
            child: Container(
              margin: EdgeInsets.only(top: 15, bottom: 15),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            _buildMenucheckin(),
                            _buildMenucheckout(),
                            _buildMenuaabsence(),
                            _buildMenupayslip()
                            // _buildMenuannouncement(),
                          ],
                        ),
                        Container(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            _buildMenuPermission(),
                            _buildMenuSick(),
                            _buildMenuOffwork(),
                            _buildmenudraggablescroll(),
                          ],
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget subbmission_menu() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child: Container(
            width: double.infinity,
            child: Container(
              margin: EdgeInsets.only(top: 15, bottom: 15),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            "Pengajuan",
                            style: TextStyle(
                                color: Colors.black, fontFamily: "SFBlack"),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            _submission_sick(),
                            _submission_permission(),
                            _submission_leave()
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget approval_menu() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child: Container(
            width: double.infinity,
            child: Container(
              margin: EdgeInsets.only(top: 15, bottom: 15),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            "Persetujuan",
                            style: TextStyle(
                                color: Colors.black, fontFamily: "SFBlack"),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            _buildMenuSick(),
                            _buildMenuPermission(),
                            _buildMenuOffwork(),
                            _buildMenuaabsence(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget attendances_menu() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child: Container(
            width: double.infinity,
            child: Container(
              margin: EdgeInsets.only(top: 15, bottom: 15),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            "Kehadiran",
                            style: TextStyle(
                                color: Colors.black, fontFamily: "SFBlack"),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            _buildMenucheckin(),
                            _buildMenucheckout(),
                            _buildMenuattendances(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget other_menu() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child: Container(
            width: double.infinity,
            child: Container(
              margin: EdgeInsets.only(top: 15, bottom: 15),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            "Lainnya",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Roboto-medium",
                                fontSize: 15,
                                letterSpacing: 0.5),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            _buildMenuemployees(),
                            _buildMenuloan(),
                            // _buildMenuproject(),
                            _buildMenupayslip(),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            _submission_permission(),
                            _submission_sick(),
                            _submission_leave()

                            // _buildMenucheckin(),
                            // _buildMenucheckout(),
                            // _buildMenuattendances(),
                            // _buildMenuannouncement(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildemployee(index) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft,
                child: DetailProfile(
                    id: _employee!['data'][index]['id']
                )));

      },
      child: Container(
        margin: EdgeInsets.only(left: 10),
        child: Column(
          children: <Widget>[
            _employee!['data'][index]['photo'] != null
                ? Container(
                    child: CircleAvatar(
                      backgroundColor: Colors.black.withOpacity(0.2),
                      radius: 30,
                      backgroundImage: NetworkImage(
                          "${image_ur}/${_employee!['data'][index]['photo']}"),
                    ),
                  )
                : Container(
                    child: Image.asset(
                    "assets/profile-default.png",
                    width: 60,
                    height: 60,
                  )),
            // Container(
            //   child: _employee!['data'][index]['photo'] == null
            //       ? CircleAvatar(
            //           radius: 30,
            //           backgroundImage: NetworkImage(photo_profile),
            //         )
            //       : CircleAvatar(
            //           radius: 30,
            //           backgroundImage: NetworkImage(
            //               "${image_ur}/${_employee!['data'][index]['photo']}"),
            //         ),
            // ),
            SizedBox(
              height: 10,
            ),
            Text(
              "${_employee!['data'][index]['first_name']}",
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Roboto-regular",
                  fontSize: 11,
                  letterSpacing: 0.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listEmployee() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 90,
            margin: EdgeInsets.only(top: 100),
            width: double.infinity,
            child: Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: _isLoading_employee == true
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            itemCount: _employee!['data'].length > 10
                                ? 10
                                : _employee!['data'].length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return _employee!['data'][index]
                                          ['mobile_access_type'] !=
                                      "admin"
                                  ? _buildemployee(index)
                                  : Text("");
                            }),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 5, top: 10),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: ListEmployee()));
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => ListEmployee()));
                    },
                    child: Text(
                      "Lihat Semua",
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 12,
                          fontFamily: "Roboto-regular",
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMenuattendances() {
    return Column(children: <Widget>[
      new Container(
        width: 70,
        height: 70,
        child: InkWell(
          onTap: () {
            navigatorAttendances();
          },
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(margin: EdgeInsets.all(15.0), child: absent),
          ),
        ),
      ),
      Text(
        "Kehadiran",
        style: subtitleMainMenu,
      )
    ]);
  }

  //-----ge data from api----
  Future _dataEmployee() async {
    try {
      setState(() {
        _isLoading_employee = true;
      });
      http.Response response =
          await http.get(Uri.parse("$base_url/api/employees"));
      _employee = jsonDecode(response.body);

      setState(() {
        _isLoading_employee = false;
      });
    } catch (e) {}
  }

  //ge data from api--------------------------------
  //data from api
  Future dataProject() async {
    try {
      setState(() {
        _isLoading_project = true;
      });

      http.Response response = await http.get(Uri.parse(
          "${baset_url_event}/api/projects/approved/employees/15?page=1&record=5"));
      _projects = jsonDecode(response.body);
      print("${_projects}");
      print(baset_url_event);

      setState(() {
        _isLoading_project = false;
      });
    } catch (e) {
      print(e);
    }
  }

  //ge data from api--------------------------------
  Future _dataAbsence() async {
    try {
      setState(() {
        _isLoading_absence = true;
      });

      http.Response response =
          await http.get(Uri.parse("$base_url/api/attendances?status=pending"));
      var _absence_data = jsonDecode(response.body);
      _absence = _absence_data['data']
          .where((prod) => prod["category"] == "present")
          .toList();
      print("data absen ${_absence!.length}");
      setState(() {
        _isLoading_absence = false;
      });
    } catch (e) {}
  }

  Future _datapermission() async {
    try {
      setState(() {
        _isLoading_permission = true;
      });

      http.Response response = await http.get(
          Uri.parse("$base_url/api/permission-submissions?status=pending"));
      _permission = jsonDecode(response.body);
      List list = _permission!['data'];

      setState(() {
        lengthPermission = list
            .where((i) => i['employee_id'].toString() != user_id.toString())
            .toList()
            .length;
        _isLoading_permission = false;
      });
    } catch (e) {}
  }

  Future _datasick() async {
    Uri.parse("$base_url/api/permission-submissions?status=pending");
    try {
      setState(() {
        _isLoading_sick = true;
      });

      http.Response response = await http
          .get(Uri.parse("$base_url/api/sick-submissions?status=pending"));
      _sick = jsonDecode(response.body);
      print("data sakit ${_sick}");
      List list = _sick!['data'];

      setState(() {
        lengthSick = list
            .where((i) => i['employee_id'].toString() != user_id.toString())
            .toList()
            .length;
        print("jumla sakit ${lengthSick}");
        _isLoading_sick = false;
      });
    } catch (e) {}
  }

  Future _dataLeave() async {
    try {
      setState(() {
        _isLoading_leave = true;
      });

      http.Response response = await http
          .get(Uri.parse("$base_url/api/leave-submissions?status=pending"));
      _leave = jsonDecode(response.body);
      List list = _leave!['data'];

      setState(() {
        lengthleave = list
            .where((i) => i['employee_id'].toString() != user_id.toString())
            .toList()
            .length;
        _isLoading_leave = false;
      });
    } catch (e) {}
  }

  Widget _buildNoproject() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              child: no_data_project,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Belum ada event yang sedang berjalan",
            style: subtitleMainMenu,
          )
        ],
      ),
    );
  }

  // @override
  // Future<void> sendNotification() async {
  //   String to = await FirebaseMessaging().getToken();
  //   print(to);
  //   String serverToken =
  //       'AAAAd5a4eRw:APA91bGlFuCRH2hAfwDLiUNdFeiYCXcnwyszIj0xwa_RF4IILoZjJiJ3NqbRfab6xI4Wn3DyfvdVMmrhVjUsmAzHRPClh6R5gb3aLEsFpZTm-ZAyDL28BFX6GrIQGnhpcnMfA6wTmdJJ';
  //   await http.post('https://fcm.googleapis.com/fcm/send',
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'key=$serverToken'
  //       },
  //       body: jsonEncode({
  //         'notification': {'title': title, 'body': body},
  //         'priority': 'high',
  //         'data': {'click_action': 'FLUTTER_NOTIFICATION_CLICK'},
  //         'to': '$to'
  //       }));
  // }
  //notification
  //notification

  Widget _buildteam(index_member, index) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          //container image
          Container(
            child: CircleAvatar(
              radius: 30,
              child: employee_profile,
            ),
          ),
        ],
      ),
    );
  }

  Widget _allFeatures() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            width: 50,
            height: 3,
          ),
          // subbmission_menu(),
          // approval_menu(),

          // attendances_menu(),
          other_menu()
        ],
      ),
    );
  }

  Widget _draggableScroll() {
    return DraggableScrollableSheet(
      initialChildSize: 1,
      maxChildSize: 1,
      minChildSize: 1,
      snap: true,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: new BoxDecoration(
              color: Colors.white, //new Color.fromRGBO(255, 0, 0, 0.0),
              borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(5.0),
                  topRight: const Radius.circular(5.0))),
          child: ListView.builder(
            controller: scrollController,
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              return _allFeatures();
            },
          ),
        );
      },
    );
  }

  Future getDatapref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      user_id = sharedPreferences.getString("user_id");
    });
  }

  void navigatorAttendances() async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => TabsAbsenceAdmin()));

    if (result == "update") {
      _dataAbsence();
    }
  }

  void navigatorSick() async {
    var result =
        // await Get.to(TabmenuSickPageAdmin());
        await Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft,
                child: TabmenuSickPageAdmin()));

    if (result == "update") {
      _datasick();
    }
  }

  void navigatorLeave() async {
    var result =
        // await Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => TabsMenuOffworkAdmin()));
        await Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft,
                child: TabsMenuOffworkAdmin()));

    if (result == "update") {
      _dataLeave();
    }
  }

  void navigatorPermission() async {
    var result =
        // await Get.to(TabmenuPermissionPageAdmin());
        await Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft,
                child: TabmenuPermissionPageAdmin()));

    if (result == "update") {
      _datapermission();
    }
  }

  showNotifcation(String title, String body, String data) async {
    // var android = new AndroidNotificationDetails(
    //     'chanel id', 'chanel name', 'CHANEL DESCRIPTION');
    // var ios = new IOSNotificationDetails();
    // var platform = new NotificationDetails(android: android, iOS: ios);
    //
    // await flutterLocalNotificationsPlugin.show(0, '$title', '$body', platform,
    //     payload: "$data");
  }

  void onSelectNotification(var payload) async {
    debugPrint("payload : ${payload}");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    // var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    // var iOS = new IOSInitializationSettings();
    // var initSetttings = new InitializationSettings(android: android, iOS: iOS);
    // flutterLocalNotificationsPlugin!.initialize(initSetttings,
    //     onSelectNotification: (String? payload) async {
    //   if (payload != null) {
    //    if (user_id!=null){
    //      Navigator.push(
    //          context,
    //          PageTransition(
    //              type: PageTransitionType.rightToLeft,
    //              child: CheckinPage()));
    //    }else{
    //      // Get.to(LoginEmployee());
    //      Navigator.push(
    //          context,
    //          PageTransition(
    //              type: PageTransitionType.rightToLeft,
    //              child:LoginEmployee()));
    //    }
    //
    //    // debugPrint('notification payload: $payload');
    //   }
    // });
   // checkinNotification();
    getDatapref();
    _dataAbsence();
    _dataEmployee();
    dataProject();
    _dataLeave();
    _datapermission();
    _datasick();

    // _firebaseMessaging.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     print("onMessage: ${message['notification']['data']}");
    //     final notif = message['notification'];
    //     final data = message['data'];
    //
    //     setState(() {
    //       ListNotif.add(
    //         Notif(
    //             title: notif['title'],
    //             body: notif['body'],
    //             id: data['id'],
    //             screen: data['id']),
    //       );
    //     });
    //     setState(() {
    //       showNotifcation(notif['title'], notif['body'], data['id']);
    //     });
    //   },
    //   onLaunch: (Map<String, dynamic> message) async {
    //     print("onLaunch: $message");
    //
    //     final notification = message['data'];
    //     setState(() {
    //       ListNotif.add(Notif(
    //         title: '${notification['title']}',
    //         body: '${notification['body']}',
    //       ));
    //     });
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     print("onResume: $message");
    //   },
    // );

    // _firebaseMessaging.requestNotificationPermissions(
    //     const IosNotificationSettings(sound: true, badge: true, alert: true));
    // super.initState();
    // flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    // var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    // var iOS = new IOSInitializationSettings();
    // var initSetttings = new InitializationSettings(android: android, iOS: iOS);
    // flutterLocalNotificationsPlugin.initialize(initSetttings,
    //     onSelectNotification: onSelectNotification);
  }

  checkinNotification() async {
    var android = new AndroidNotificationDetails(
      'channel id',
      'channel NAME',
      'CHANNEL DESCRIPTION',
      priority: Priority.high,
      importance: Importance.max,
      icon: 'icon',
      largeIcon: DrawableResourceAndroidBitmap('icon'),
      sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
    );
    var iOS = new IOSNotificationDetails(
        sound: 'a_long_cold_sting.wav',
        presentAlert: true,
        presentBadge: true,
        presentSound: true);
    var platform = new NotificationDetails(android: android, iOS: iOS);
    var platformChannelSpecifics =
        NotificationDetails(android: android, iOS: iOS);
    // await flutterLocalNotificationsPlugin.show(
    //     0, 'New Tutorial', 'Local Notification', platform,
    //     payload: 'AndroidCoding.in');

    // await flutterLocalNotificationsPlugin.schedule(CHANNEL_CHECKIN_ID, 'Reminder', "Buruan melalakukan checkin",
    //     scheduledNotificationDateTime, platformChannelSpecifics);
    await flutterLocalNotificationsPlugin?.showDailyAtTime(CHANNEL_CHECKIN_ID,
        "Reminder", "Lakukan checkin sebelum jam 07:55:00", checkinTime, platformChannelSpecifics);
    // await flutterLocalNotificationsPlugin.schedule(id, title, body, scheduledDate, notificationDetails)
  }
}
