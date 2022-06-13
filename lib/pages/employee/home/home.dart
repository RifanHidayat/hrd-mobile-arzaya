import 'dart:convert';

import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:format_indonesia/format_indonesia.dart';
import 'package:intl/intl.dart';

import 'package:magentahrdios/models/notifacations.dart';
import 'package:magentahrdios/pages/announcement/detail.dart';
import 'package:magentahrdios/pages/employee/attendances/attendances.dart';
import 'package:magentahrdios/pages/employee/attendances/checkin.dart';
import 'package:magentahrdios/pages/employee/attendances/checkout.dart';
import 'package:magentahrdios/pages/employee/leave/LeaveList.dart';
import 'package:magentahrdios/pages/employee/login/login.dart';
import 'package:magentahrdios/pages/employee/notification/notification.dart';
import 'package:magentahrdios/pages/employee/official_travel/add_official_travel.dart';
import 'package:magentahrdios/pages/employee/official_travel/official_travel.dart';
import 'package:magentahrdios/pages/employee/permission/list.dart';
import 'package:magentahrdios/pages/employee/sick/list.dart';
import 'package:magentahrdios/services/api_clien.dart';
import 'package:magentahrdios/utalities/color.dart';
import 'package:magentahrdios/utalities/constants.dart';
import 'package:magentahrdios/utalities/fonts.dart';
import 'package:page_transition/page_transition.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeEmployee extends StatefulWidget {
  @override
  _HomeEmployeeState createState() => _HomeEmployeeState();
}

enum statusLogin { signIn, notSignIn }

class _HomeEmployeeState extends State<HomeEmployee> {
  final GlobalKey<ScaffoldState> scaffoldState = new GlobalKey<ScaffoldState>();

  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
//  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

  // final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  final List<Notif> ListNotif = [];
  Map? _projects;
  bool _loading = true,isLoadingNotif=true;
  var notifiactionTotal="0";
  List? attendances;
  var user_id, address, name;
  var employeeId, photo;
  var CHANNEL_CHECKIN_ID = 1;
  var CHANNEL_CHECKOUT_ID = 2;
  var officialTravelLength = 0;
  var employeeType = "";
  var checkinTime = new Time(07, 45, 0);
  List announcement = [];

  //-----main menu-----
  Widget _buildMenucheckin() {
    return Column(children: <Widget>[
      Container(
        width: 70,
        height: 70,
        child: InkWell(
          onTap: () {
            //Get.to(CheckinPage());
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
      const Text("Checkin",
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
            //  Get.to(CheckoutPage());
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
      const Text("Checkout",
          style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: "Roboto-regular",
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5))
    ]);
  }

  Widget _buildMenuaabsence() {
    return Column(children: <Widget>[
      Container(
        width: 70,
        height: 70,
        child: InkWell(
          onTap: () {
            // Get.to(absence());
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft, child: absence()));
            // Navigator.push(
            //     context,
            //     PageTransition(
            //         type: PageTransitionType.rightToLeft, child: absence()));
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => absence()));
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
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => Tabsproject()));
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
      Text("Event", style: subtitleMainMenu)
    ]);
  }

  Widget _buildMenuloan() {
    return Column(children: <Widget>[
      SizedBox(
        width: 70,
        height: 70,
        child: InkWell(
          onTap: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => ListLoanEmployeePage()));
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
      const Text("Kasbon",
          style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: "Roboto-regular",
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5))
    ]);
  }

  // Widget _officialTravel() {
  //   return Column(children: <Widget>[
  //     new Container(
  //       width: 70,
  //       height: 70,
  //       child: InkWell(
  //         onTap: () {
  //                     Navigator.push(
  //                         context,
  //                         PageTransition(
  //                             type: PageTransitionType.rightToLeft,
  //                             child: OfficialTravelPage()));
  //                     // Navigator.push(
  //                     //     context,
  //                     //     MaterialPageRoute(
  //                     //         builder: (context) => ListLoanEmployeePage()));
  //         },
  //         child: Stack(
  //           children: [
  //             Card(
  //               elevation: 1,
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(10.0),
  //               ),
  //               child: Container(margin: EdgeInsets.all(15.0),  child: Container(
  //                   margin: EdgeInsets.all(15.0),
  //             child: Image.asset(
  //               "assets/travel.png",
  //               width: 25,
  //               height: 15,
  //             )),),
  //             ),
  //             Container(
  //               child: Container(
  //                 margin: EdgeInsets.only(top: 15, right: 10),
  //                 width: double.maxFinite,
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.end,
  //                   children: [
  //                     Container(
  //                       child: officialTravelLength == 0
  //                           ? Text("")
  //                           : CircleAvatar(
  //                         radius: 10,
  //                         backgroundColor: Colors.redAccent,
  //                         child: Text(
  //                           "${officialTravelLength}",
  //                           style: TextStyle(color: Colors.white),
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //
  //           ],
  //         ),
  //       ),
  //     ),
  //     Text("Perdin",
  //         style: TextStyle(
  //             color: Colors.black,
  //             fontSize: 12,
  //             fontFamily: "Roboto-regular",
  //             fontWeight: FontWeight.w500,
  //             letterSpacing: 0.5))
  //   ]);
  // }
  Widget _officialTravel() {
    return Column(children: <Widget>[
      SizedBox(
        width: 70,
        height: 70,
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: OfficialTravelPage()));
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => ListLoanEmployeePage()));
          },
          child: Stack(
            children: [
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                    margin: EdgeInsets.all(15.0),
                    child: Image.asset(
                      "assets/travel.png",
                      width: 35,
                      height: 35,
                    )),
              ),
              Container(
                child: Container(
                  margin: EdgeInsets.only(top: 15, right: 10),
                  width: double.maxFinite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        child: officialTravelLength == 0
                            ? Text("")
                            : CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.redAccent,
                                child: Text(
                                  "${officialTravelLength}",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      const Text("Perdin",
          style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: "Roboto-regular",
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5))
    ]);
  }

  Widget _buildMenuoffwork() {
    return Column(children: <Widget>[
      new Container(
        width: 70,
        height: 70,
        child: InkWell(
          onTap: () {
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
      Text("Cuti",
          style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: "Roboto-regular",
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5))
    ]);
  }

  Widget _buildMenusick() {
    return Column(children: <Widget>[
      new Container(
        width: 70,
        height: 70,
        child: InkWell(
          onTap: () {
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
      Text("Sakit",
          style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: "Roboto-regular",
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5))
    ]);
  }

  Widget _buildMenupermission() {
    return Column(children: <Widget>[
      new SizedBox(
        width: 70,
        height: 70,
        child: InkWell(
          onTap: () {
            // Navigator.pushNamed(context, "leave_list_employee-page");
            // Get.to(ListPermissionPageEmployee(
            //   status: "approved",
            // ));
            // // Get.to(ListPermissionPageEmployee(
            // //   status: "approved",
            // // ));
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
      Text("izin",
          style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: "Roboto-regular",
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5))
    ]);
  }

  Widget _buildmenupyslip() {
    return Column(children: <Widget>[
      new Container(
        width: 70,
        height: 70,
        child: InkWell(
          onTap: () {
            //Navigator.pushNamed(context, "pyslip_list_employee-page");
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
      const Text("Payslip",
          style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: "Roboto-regular",
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5))
    ]);
  }

  Widget _buildMainMenu() {
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
                            _buildmenupyslip(),
                            // _buildMenuloan()
                          ],
                        ),
                        Container(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            _officialTravel(),
                            _buildMenupermission(),
                            _buildMenusick(),
                            _buildMenuoffwork(),
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

  //----end main menu---

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

//----end announcement-----
  Widget _buildInformation() {
    return InkWell(
      onTap: () {
        // Get.to(DetailAnnouncement());
      },
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Card(
                elevation: 1,
                child: Container(
                  margin: EdgeInsets.only(top: 15, bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Stack(
                              children: [
                                Container(
                                  color: Color.fromRGBO(255, 255, 255, 2),
                                  width: double.infinity,
                                  height: 170,
                                  child: Image.asset(
                                    "assets/announcement.jpg",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Container(
                                  height: 200,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 20, right: 20),
                                        width: double.maxFinite,
                                        child: Text(
                                          "Cuti bersama dimulai dari tanggal 6 - 7 mei 2021",
                                          style: titlteannoucement1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              width: double.maxFinite,
                              child: Text(
                                "Cuti bersama dimulai dari tanggal 6 - 7 mei 2021",
                                style: titlteannoucement,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              width: double.maxFinite,
                              child: Text(
                                "2 November 2021",
                                style: TextStyle(color: Colors.black38),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //----end announcement


  Widget _buildNoAbbouncement() {
    return _loading == false
        ? Container(
            child: announcement.length > 0
                ? Container(
  child: Column(
  children: List.generate(announcement.length, (index) {
    return  InkWell(
      onTap: (){
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft,
                child: AnnouncementDetail(
                  createdAt: announcement[index]['created_at'],
                  title: announcement[index]['title'],
                  description: announcement[index]['description'],
                  attachment: announcement[index]['attachment'],
                )));

      },
      child: Container(
        margin: EdgeInsets.only(left: 10,right: 10),

        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 170,
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(10)),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(10),
                        ),
                        child: Container(
                          margin: EdgeInsets.all(25),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "${announcement[index]['title']}",
                                style: TextStyle(
                                    color: baseColor,
                                    letterSpacing: 0.5,
                                    fontSize: 16),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(

                                "Di Posting pada ${Waktu(DateTime.parse(announcement[index]['created_at'])).yMMMMEEEEd()}",
                                style: TextStyle(
                                    letterSpacing: 0.4,
                                    color: Colors.black.withOpacity(0.3),
                                    fontSize: 12),
                              ),
                              SizedBox(height: 10,),

                              Container(
                                child: RichText(
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    strutStyle: StrutStyle(fontSize: 10.0),
                                    text: TextSpan(
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "Roboto-regular",
                                          letterSpacing: 0.5,
                                          fontSize: 12),
                                      text:
                                      "${announcement[index]['description']}",
                                    )),
                                // child: Text(
                                //   "Saya berada dalam kondisi sakit kepala dan tidak bisa banyak berpikir. Mohon pengertiannya, terimakasih. :",
                                //   style: TextStyle(
                                //       color: Colors.black,
                                //       fontFamily: "inter-light",
                                //       letterSpacing: 0.5,
                                //       fontSize: 10),
                                // ),
                              ),
                              // Text(
                              //   "${announcement[index]['description']}",
                              //   style: TextStyle(
                              //       letterSpacing: 0.5,
                              //       color: Colors.black,
                              //       fontSize: 12),
                              // ),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 40,
                    height: 20,
                    decoration: BoxDecoration(
                        color: baseColor1,
                        borderRadius: BorderRadius.circular(25)),
                    child: Text(
                      "New",
                      style: TextStyle(
                          letterSpacing:0.5,
                          color: Colors.white,
                          fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );


  }),
  ),
  )
                : Container(
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
                  ),
          )
        : Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3.5,
          child: Center(
      child: CircularProgressIndicator(color: baseColor,),
    ),
        );
  }

  //data from api
  Future dataProject(user_id) async {
    try {
      setState(() {
        _loading = true;
      });

      http.Response response = await http.get(Uri.parse(
          "${baset_url_event}/api/projects/approved/employees/${user_id}?page=1&record=5"));
      _projects = jsonDecode(response.body);
      print("${_projects}");
      print(baset_url_event);

      setState(() {
        _loading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDatapref();

    // flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    // var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    // var iOS = new IOSInitializationSettings();
    // var initSetttings = new InitializationSettings(android: android, iOS: iOS);
    // flutterLocalNotificationsPlugin!.initialize(initSetttings,
    //     onSelectNotification: (String? payload) async {
    //       if (payload != null) {
    //         Navigator.push(
    //             context,
    //             PageTransition(
    //                 type: PageTransitionType.rightToLeft,
    //                 child: CheckinPage()));
    //
    //         // debugPrint('notification payload: $payload');
    //       }else{
    //         // Get.to(LoginEmployee());
    //         Navigator.push(
    //             context,
    //             PageTransition(
    //                 type: PageTransitionType.rightToLeft,
    //                 child:LoginEmployee()));
    //       }
    //
    //     });
    // checkinNotification();
  }

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
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Stack(
                children: <Widget>[
                  Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: Colors.white),
                  Container(
                    height: double.infinity,
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(0),
                            child: Center(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    width: Get.mediaQuery.size.width,
                                    color: baseColor,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 20,
                                          top: 50,
                                          right: 20,
                                          bottom: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            child: photo == null
                                                ? Image.asset(
                                                    "assets/profile-default.png",
                                                    width: 70,
                                                    height: 70,
                                                  )
                                                : CircleAvatar(
                                                    backgroundColor: Colors
                                                        .black
                                                        .withOpacity(0.2),
                                                    radius: 35,
                                                    backgroundImage:
                                                        NetworkImage(
                                                      "${image_ur}/${photo}",
                                                    ),
                                                  ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 20, top: 25),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Hi, ${name ?? ""}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      letterSpacing: 0.5,
                                                      fontFamily:
                                                          "roboto-regular",
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "${employeeType ?? ""}",
                                                  style: TextStyle(
                                                      color: Colors.white
                                                          .withOpacity(0.3),
                                                      fontSize: 13,
                                                      letterSpacing: 0.5,
                                                      fontFamily:
                                                          "Roboto-regular",
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                              child: Container(
                                            alignment: Alignment.topRight,
                                            width: double.maxFinite,
                                            margin: EdgeInsets.only(
                                                left: 20, top: 25),
                                            child: Stack(
                                              children: [
                                                InkWell(
                                                  onTap:(){
                                                    Navigator.push(
                                                        context,
                                                        PageTransition(
                                                            type: PageTransitionType.rightToLeft,
                                                            child: NotificationPage()));
                                              },
                                                  child: Container(
                                                    child: Icon(
                                                      Icons
                                                          .notifications_outlined,
                                                      color: Colors.white,
                                                      size: 20,
                                                    ),
                                                  ),
                                                ),
                                               notifiactionTotal!=0? Container(
                                                  width: 15,
                                                  height: 15,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: redBaseColor,
                                                  ),
                                                  child: Text("${notifiactionTotal}",style: TextStyle(fontSize: 10,color: Colors.white),textAlign: TextAlign.center,),
                                                ):Container(),
                                              ],
                                            ),
                                          ))
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 15,
                          ),

                          Container(
                            margin: EdgeInsets.only(left: 10, top: 5),
                            child: const Text("Main Menu",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "roboto-medium",
                                    fontSize: 15,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w500)),
                          ),
                          _buildMainMenu(),

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
                          Container(


                              child: _buildNoAbbouncement())
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          onRefresh: getDatapref,
        ),
      ),
    );
  }

  Future getDatapref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      user_id = sharedPreferences.getString("user_id");
      name = sharedPreferences.getString("first_name");
      _employee(user_id);
      _fetchOfficialTravel(user_id);
      fetchAttendances(user_id);

    });
    setState(() {
      dataProject(user_id);
    });
  }

  Future _employee(id) async {
    final response = await http.get(Uri.parse("$base_url/api/employees/${id}"));
    final data = jsonDecode(response.body);

    if (data['code'] == 200) {
      //build personal information
      setState(() {
        name = data['data']['first_name'];
        photo = data['data']['photo'];
        employeeId = data['data']['employee_id'];
        employeeType = data['data']['career']!=null?data['data']['career']['position_setting']['name  ']:null;
        _fetchAnnouncement();
      });
    } else {}
  }

  //notification
  // showNotifcation(String title, String body, String data) async {
  //   Future getDatapref() async {
  //     SharedPreferences sharedPreferences =
  //         await SharedPreferences.getInstance();
  //     setState(() {
  //       user_id = sharedPreferences.getString("user_id");
  //     });
  //     setState(() {
  //       dataProject(user_id);
  //     });
  //   }
  // }

  Future _fetchOfficialTravel(var user_id) async {
    try {
      setState(() {
        _loading = true;
      });
      http.Response response = await http.get(
          Uri.parse("${base_url}/api/official-travel/employee/${user_id}"));
      List data = jsonDecode(response.body);
      data.forEach((element) {
        var dates = element['official_travel_dates'].toString().split(',');
        dates.sort((a, b) {
          //sorting in ascending order
          return DateTime.parse(a).compareTo(DateTime.parse(b));
        });
        if (DateTime.parse(dates[0].toString()).isAfter(DateTime.now())) {
          setState(() {
            officialTravelLength += 1;
          });
        }
      });
      print("data ${data}");
      print(user_id);

      // print(response.body);

      setState(() {
        _loading = false;
      });
    } catch (e) {
      print("${e}");
    }
  }
  Future fetchAttendances(var id) async {
    try {
      setState(() {
        isLoadingNotif = true;
      });
      http.Response response =
      await http.get(Uri.parse("$base_url/api/notification/${user_id}/total"));


      setState(() {

        notifiactionTotal=response.body;

        ;
      });
      //print("data ${jsonDecode(response.body[0])}");

      setState(() {
        isLoadingNotif = false;
      });
    } catch (e) {
      print("${e}");
    }
  }
  Future _fetchAnnouncement() async {
    try {
      setState(() {
        _loading = true;
      });
      var date = DateFormat('yyyy-MM-dd').format(DateTime.now());
      http.Response response = await http.get(Uri.parse(
          "${base_url}/api/announcement?start_date=${date}&position=${employeeType}"));
      List data = jsonDecode(response.body);
      print("dataqq ${data.length}");
      setState(() {
        announcement=data;
      });

      // print(response.body);

      setState(() {
        _loading = false;
      });
    } catch (e) {
      print("${e}");
    }
  }


}
