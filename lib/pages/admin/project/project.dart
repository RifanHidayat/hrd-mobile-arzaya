// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:magentahrdios/pages/admin/project/shimmer_project.dart';
// import 'package:magentahrdios/services/api_clien.dart';
// import 'package:magentahrdios/utalities/color.dart';
// import 'package:magentahrdios/utalities/constants.dart';
// import 'package:magentahrdios/utalities/fonts.dart';
//
// import 'package:percent_indicator/circular_percent_indicator.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// class Project_admin extends StatefulWidget {
//   Project_admin({this.status});
//
//   var status;
//
//   @override
//   _Project_adminState createState() => _Project_adminState();
// }
//
// class _Project_adminState extends State<Project_admin> {
//   //variable
//   final _scaffoldKey = new GlobalKey<ScaffoldState>();
//   var user_id;
//
//   VoidCallback? _showPersBottomSheetCallBack;
//   Map? _projects;
//   bool _loading = true;
//
// //---projects---
//   Widget _buildproject() {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       child: Container(
//         child: Flex(
//           direction: Axis.horizontal,
//           children: <Widget>[
//             Expanded(
//               child: _loading
//                   ? Center(
//                       child: ShimmerProject(),
//                     )
//                   : ListView.builder(
//                       itemCount: _projects!['data'].length == 0
//                           ? 1
//                           : _projects!['data'].length,
//                       itemBuilder: (context, index) {
//                         return _projects!['data'].length == 0
//                             ? _buildnodata()
//                             : _buildProgress(index);
//                       }),
//               //   child: _buildNoproject(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildProgress(index) {
//     return Container(
//       margin: EdgeInsets.only(top: 20),
//       width: MediaQuery.of(context).size.width,
//       height: 200,
//       child: Card(
//         child: Container(
//           margin: EdgeInsets.only(left: 10, right: 10),
//           child: Row(
//             children: [
//               Container(
//                 width: MediaQuery.of(context).size.width * 0.65,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Text("${_projects!['data'][index]['title']}",
//                         style: subtitleMainMenu),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Container(
//                       child: Text(
//                           "${_projects!['data'][index]['city']['name']}, ${_projects!['data'][index]['city']['province']['name']}",
//                           style: TextStyle(
//                               color: Colors.black38,
//                               fontFamily: "SFReguler",
//                               fontSize: 14)),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Expanded(
//                       child: _loading
//                           ? Center(
//                               child: CircularProgressIndicator(),
//                             )
//                           : Center(
//                               child: Container(
//                                 margin: EdgeInsets.only(top: 20, bottom: 20),
//                                 child: Column(
//                                   children: [
//                                     Expanded(
//                                       child: ListView.builder(
//                                           itemCount: 1,
//                                           scrollDirection: Axis.horizontal,
//                                           itemBuilder: (context, index_member) {
//                                             return _buildteam(
//                                                 index_member, index);
//                                           }),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                       //   child: _buildNoproject(),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                     width: MediaQuery.of(context).size.width * 0.35 - 25,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         Container(
//                           child: Container(
//                               alignment: Alignment.center,
//                               margin: EdgeInsets.only(top: 3, bottom: 3),
//                               child: Text(
//                                 "in progress",
//                                 style: TextStyle(
//                                     color: Colors.white, fontSize: 10),
//                               )),
//                           decoration: BoxDecoration(
//                             color: Colors.green,
//                             borderRadius: new BorderRadius.only(
//                               topLeft: const Radius.circular(10.0),
//                               topRight: const Radius.circular(10.0),
//                               bottomLeft: const Radius.circular(10.0),
//                               bottomRight: const Radius.circular(10.0),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 1,
//                           child: Container(
//                             margin: EdgeInsets.only(bottom: 10),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 new CircularPercentIndicator(
//                                   radius: 110.0,
//                                   lineWidth: 10.0,
//                                   animation: true,
//                                   percent: _projects!['data'][index]
//                                           ['progress'] /
//                                       100,
//                                   center: new Text(
//                                     "${_projects!['data'][index]['progress']}%",
//                                     style: new TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 17.0),
//                                   ),
//                                   circularStrokeCap: CircularStrokeCap.round,
//                                   progressColor: baseColor,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     )),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildnodata() {
//     return Container(
//       height: MediaQuery.of(context).size.height - 150,
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Container(
//               child: no_data_project,
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Container(
//                 child: Text(
//               "Belum ada event",
//               style: TextStyle(color: Colors.black38, fontSize: 18),
//             )),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildteam(index_member, index) {
//     return Container(
//       margin: EdgeInsets.only(top: 10),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: <Widget>[
//           //container image
//           Container(
//             child: CircleAvatar(
//               radius: 30,
//               child: employee_profile,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   //---end projects---
//
// //---main contex-----
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: RefreshIndicator(
//         child: Container(
//           width: Get.mediaQuery.size.width,
//           height: Get.mediaQuery.size.height,
//           child: Container(color: Colors.white38, child: _buildproject()),
//         ),
//         onRefresh: getDatapref,
//       ),
//     );
//   }
//
//   //ge data from api
// //ge data from api--------------------------------
//   Future dataProject() async {
//     try {
//       setState(() {
//         _loading = true;
//       });
//       http.Response response =
//           await http.get(Uri.parse("$base_url/api/events?status=${widget.status}"));
//       _projects = jsonDecode(response.body);
//       print(_projects);
//
//       setState(() {
//         _loading = false;
//       });
//     } catch (e) {}
//   }
//
//   Future getDatapref() async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     setState(() {
//       user_id = sharedPreferences.getString("user_id");
//     });
//   }
//
//   //inislisasi state
//   @override
//   void initState() {
//     super.initState();
//     //show modal detail project
//     getDatapref();
//     dataProject();
//   }
// }
//
// //
// // //------------bottom sheet--------
// //   void _showModalSheet(var index) {
// //     showModalBottomSheet(
// //         context: context,
// //         builder: (builder) {
// //           return Container(
// //             height: MediaQuery.of(context).size.height - 40,
// //             child: new Card(
// //               elevation: 1,
// //               child: SingleChildScrollView(
// //                 child: Column(
// //                   children: [
// //                     Container(
// //                       margin: EdgeInsets.all(20),
// //                       child: Column(
// //                         mainAxisAlignment: MainAxisAlignment.start,
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: <Widget>[
// //                           //project
// //                           Text(
// //                             "Event",
// //                             style: TextStyle(
// //                               fontFamily: "OpenSans",
// //                               color: textColor1,
// //                               fontSize: 20,
// //                             ),
// //                           ),
// //
// //                           new Divider(
// //                             color: Colors.black38,
// //                           ),
// //
// //                           _detailproject(index),
// //                           _buildstardate(index),
// //                           _buildenddate(index),
// //
// //                           _buildlocation(index),
// //                           _budgetAwal(index),
// //                           _budgetsisa(index),
// //
// //                           //team
// //                           Text(
// //                             "Members",
// //                             style: TextStyle(
// //                               fontFamily: "OpenSans",
// //                               color: textColor1,
// //                               fontSize: 20,
// //                             ),
// //                           ),
// //                           new Divider(
// //                             color: Colors.black38,
// //                           ),
// //                           SizedBox(
// //                             height: 10,
// //                           ),
// //                           Container(
// //                             width: double.infinity,
// //                             height: 200,
// //                             child: _loading == true
// //                                 ? Center(
// //                                     child: CircularProgressIndicator(),
// //                                   )
// //                                 : ListView.builder(
// //                                     itemCount: _projects['data'][index]
// //                                             ['members']
// //                                         .length,
// //                                     scrollDirection: Axis.vertical,
// //                                     itemBuilder: (context, index_member) {
// //                                       return _buildteam(index_member, index);
// //                                     }),
// //                           ),
// //
// //                           //Task
// //                           SizedBox(
// //                             height: 10,
// //                           ),
// //                           Text(
// //                             "Task",
// //                             style: TextStyle(
// //                               fontFamily: "OpenSans",
// //                               color: textColor1,
// //                               fontSize: 20,
// //                             ),
// //                           ),
// //                           new Divider(
// //                             color: Colors.black38,
// //                           ),
// //                           SizedBox(
// //                             height: 10,
// //                           ),
// //                           _buildTask(index)
// //                         ],
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           );
// //         });
// //   }
// //
// //   void _showBottomSheet() {
// //     setState(() {
// //       _showPersBottomSheetCallBack = null;
// //     });
// //
// //     _scaffoldKey.currentState
// //         .showBottomSheet((context) {
// //           return new Container(
// //             height: 100,
// //             child: new Center(
// //               child: new Text("Hi BottomSheet"),
// //             ),
// //           );
// //         })
// //         .closed
// //         .whenComplete(() {
// //           if (mounted) {
// //             setState(() {
// //               _showPersBottomSheetCallBack = _showBottomSheet;
// //             });
// //           }
// //         });
// //   }
// //
// //
// //
// // //widget event name
// //   Widget _detailproject(index) {
// //     return Container(
// //       child: Row(
// //         children: <Widget>[
// //           //container image
// //           Container(
// //             child: CircleAvatar(
// //               backgroundColor: Colors.white,
// //               radius: 30,
// //               child: Icon(
// //                 Icons.label,
// //                 size: 30,
// //                 color: Colors.black38,
// //               ),
// //             ),
// //           ),
// //           Container(
// //             margin: EdgeInsets.only(left: 10),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: <Widget>[
// //                 Text(
// //                   "Title Event",
// //                   style: TextStyle(
// //                       color: Colors.black,
// //                       fontSize: 15,
// //                       fontWeight: FontWeight.bold),
// //                 ),
// //                 Text(
// //                   "${_projects['data'][index]['title']}",
// //                   style: TextStyle(
// //                     color: Colors.black38,
// //                     fontSize: 15,
// //                   ),
// //                 )
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildstardate(index) {
// //     return Container(
// //       child: Row(
// //         children: <Widget>[
// //           //container image
// //           Container(
// //             child: CircleAvatar(
// //               backgroundColor: Colors.white,
// //               radius: 30,
// //               child: Icon(
// //                 Icons.access_time_outlined,
// //                 size: 30,
// //                 color: Colors.black38,
// //               ),
// //             ),
// //           ),
// //           Container(
// //             margin: EdgeInsets.only(left: 10),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: <Widget>[
// //                 Text(
// //                   "Start Date",
// //                   style: TextStyle(
// //                       color: Colors.black,
// //                       fontSize: 15,
// //                       fontWeight: FontWeight.bold),
// //                 ),
// //                 Text(
// //                   "${_projects['data'][index]['start_date']}",
// //                   style: TextStyle(
// //                     color: Colors.black38,
// //                     fontSize: 15,
// //                   ),
// //                 )
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildlocation(index) {
// //     return Container(
// //       child: Row(
// //         children: <Widget>[
// //           //container image
// //           Container(
// //             child: CircleAvatar(
// //               backgroundColor: Colors.white,
// //               radius: 30,
// //               child: Icon(
// //                 Icons.location_on,
// //                 size: 30,
// //                 color: Colors.black38,
// //               ),
// //             ),
// //           ),
// //           Container(
// //             margin: EdgeInsets.only(left: 10),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: <Widget>[
// //                 Text(
// //                   "Location",
// //                   style: TextStyle(
// //                       color: Colors.black,
// //                       fontSize: 15,
// //                       fontWeight: FontWeight.bold),
// //                 ),
// //                 Text(
// //                   "${_projects['data'][index]['city']['name']}",
// //                   style: TextStyle(
// //                     color: Colors.black38,
// //                     fontSize: 15,
// //                   ),
// //                 )
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildenddate(index) {
// //     return Container(
// //       child: Row(
// //         children: <Widget>[
// //           //container image
// //           Container(
// //             child: CircleAvatar(
// //               backgroundColor: Colors.white,
// //               radius: 30,
// //               child: Icon(
// //                 Icons.access_time_rounded,
// //                 size: 30,
// //                 color: Colors.black38,
// //               ),
// //             ),
// //           ),
// //           Container(
// //             margin: EdgeInsets.only(left: 10),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: <Widget>[
// //                 Text(
// //                   "End Date",
// //                   style: TextStyle(
// //                       color: Colors.black,
// //                       fontSize: 15,
// //                       fontWeight: FontWeight.bold),
// //                 ),
// //                 Text(
// //                   "${_projects['data'][index]['end_date']}",
// //                   style: TextStyle(
// //                     color: Colors.black38,
// //                     fontSize: 15,
// //                   ),
// //                 )
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   //
// //   Widget _budgetAwal(index) {
// //     return Container(
// //       child: Row(
// //         children: <Widget>[
// //           //container image
// //           Container(
// //             child: CircleAvatar(
// //               backgroundColor: Colors.white,
// //               radius: 30,
// //               child: Icon(
// //                 Icons.monetization_on,
// //                 size: 30,
// //                 color: Colors.black38,
// //               ),
// //             ),
// //           ),
// //           Container(
// //             margin: EdgeInsets.only(left: 10),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: <Widget>[
// //                 Text(
// //                   "Balance",
// //                   style: TextStyle(
// //                       color: Colors.black,
// //                       fontSize: 15,
// //                       fontWeight: FontWeight.bold),
// //                 ),
// //                 Text(
// //                   "IDR ${_projects['data'][index]['budget_summary']['balance']}",
// //                   style: TextStyle(
// //                     color: Colors.black38,
// //                     fontSize: 15,
// //                   ),
// //                 )
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _budgetsisa(index) {
// //     return Container(
// //       child: Row(
// //         children: <Widget>[
// //           //container image
// //           Container(
// //             child: CircleAvatar(
// //               backgroundColor: Colors.white,
// //               radius: 30,
// //               child: Icon(
// //                 Icons.monetization_on_outlined,
// //                 size: 30,
// //                 color: Colors.black38,
// //               ),
// //             ),
// //           ),
// //           Container(
// //             margin: EdgeInsets.only(left: 10),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: <Widget>[
// //                 Text(
// //                   "Remaining budget",
// //                   style: TextStyle(
// //                       color: Colors.black,
// //                       fontSize: 15,
// //                       fontWeight: FontWeight.bold),
// //                 ),
// //                 Text(
// //                   "IDR ${_projects['data'][index]['budget_summary']['balance'] - _projects['data'][index]['budget_summary']['total_expense']}",
// //                   style: TextStyle(
// //                     color: Colors.black38,
// //                     fontSize: 15,
// //                   ),
// //                 )
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildTask(index) {
// //     return Container(
// //       width: double.infinity,
// //       child: Center(
// //         child: Column(
// //           children: <Widget>[
// //             new CircularPercentIndicator(
// //               radius: 120.0,
// //               lineWidth: 13.0,
// //               animation: true,
// //               percent: _projects['data'][index]['progress'] / 100,
// //               center: new Text(
// //                 "${_projects['data'][index]['progress']}%",
// //                 style:
// //                     new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
// //               ),
// //               footer: new Text(
// //                 "Progress in Project",
// //                 style:
// //                     new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
// //               ),
// //               circularStrokeCap: CircularStrokeCap.round,
// //               progressColor: baseColor,
// //             ),
// //             SizedBox(
// //               height: 10,
// //             ),
// //             Container(
// //               child: new RaisedButton(
// //                 textColor: Colors.white,
// //                 color: btnColor1,
// //                 onPressed: () {
// //                   Navigator.pop(context);
// //                   Navigator.push(
// //                       context,
// //                       MaterialPageRoute(
// //                           builder: (context) => Tabstasks(
// //                                 task: _projects['data'][index].toString(),
// //                                 id: index.toString(),
// //                               )));
// //                 },
// //                 child: new Text("Task"),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //
// //   //------ widget project----
// //   // Widget _buildproject(index) {
// //   //   return Center(
// //   //     child: Container(
// //   //         width: double.infinity,
// //   //         child: Card(
// //   //           elevation: 1,
// //   //           child: Column(
// //   //             crossAxisAlignment: CrossAxisAlignment.start,
// //   //             children: [
// //   //               Container(
// //   //                 margin: EdgeInsets.all(10),
// //   //                 child: Row(
// //   //                   children: <Widget>[
// //   //
// //   //                     Expanded(
// //   //                       flex: 1,
// //   //                       child: Container(
// //   //                         margin: EdgeInsets.only(right: 5, left: 5, top: 15),
// //   //                         child: Column(
// //   //                           crossAxisAlignment: CrossAxisAlignment.start,
// //   //                           mainAxisAlignment: MainAxisAlignment.start,
// //   //                           children: <Widget>[
// //   //                             SizedBox(
// //   //                               height: 10,
// //   //                             ),
// //   //                             Text(
// //   //                               "${_projects['data'][index]['title']}",
// //   //                               style: TextStyle(
// //   //                                   fontSize: 18,
// //   //                                   color: Colors.black87,
// //   //                                   fontWeight: FontWeight.bold),
// //   //                             ),
// //   //                             SizedBox(
// //   //                               height: 5,
// //   //                             ),
// //   //                             Text(
// //   //                               "${_projects['data'][index]['city']['name']}",
// //   //                               style: TextStyle(
// //   //                                   fontSize: 15, color: Colors.black38),
// //   //                             ),
// //   //                             SizedBox(
// //   //                               height: 15,
// //   //                             ),
// //   //                             Text(
// //   //                               "IDR ${_projects['data'][index]['budget_summary']['balance']}",
// //   //                               style: TextStyle(
// //   //                                   fontSize: 15, color: Colors.green),
// //   //                             ),
// //   //                             SizedBox(
// //   //                               height: 10,
// //   //                             ),
// //   //                             Container(
// //   //                                 width: double.infinity,
// //   //                                 height: 40,
// //   //                                 child: Row(
// //   //                                   mainAxisAlignment: MainAxisAlignment.end,
// //   //                                   crossAxisAlignment: CrossAxisAlignment.end,
// //   //                                   children: <Widget>[
// //   //                                     //button detail
// //   //                                     new RaisedButton(
// //   //                                       padding: const EdgeInsets.all(8.0),
// //   //                                       textColor: Colors.white,
// //   //                                       color: btnColor1,
// //   //                                       onPressed: () {
// //   //                                         _showModalSheet(index);
// //   //                                       },
// //   //                                       child: new Text("Detail"),
// //   //                                     ),
// //   //
// //   //                                     //button budgeting
// //   //
// //   //                                     Container(
// //   //                                       margin: EdgeInsets.only(left: 5),
// //   //                                       child: new OutlineButton(
// //   //                                         onPressed: () {
// //   //                                           Navigator.push(
// //   //                                               context,
// //   //                                               MaterialPageRoute(
// //   //                                                   builder: (context) => budgetproject(
// //   //                                                       event_id: _projects['data']
// //   //                                                               [index]['id']
// //   //                                                           .toString(),
// //   //                                                       title_event: _projects['data']
// //   //                                                           [index]['title'],
// //   //                                                       active_budget:
// //   //                                                           _projects['data'][index]['budget_effective_date']
// //   //                                                               .toString(),
// //   //                                                       expired_budget:
// //   //                                                           _projects['data'][index]['budget_expire_date']
// //   //                                                               .toString(),
// //   //                                                       balance: _projects['data']
// //   //                                                                       [index]
// //   //                                                                   ['budget_summary']
// //   //                                                               ['balance']
// //   //                                                           .toString(),
// //   //                                                       remaining_budget: "${_projects['data'][index]['budget_summary']['balance'] - _projects['data'][index]['budget_summary']['total_expense']}")));
// //   //                                         },
// //   //                                         child: Text(
// //   //                                           'Budget',
// //   //                                           style: TextStyle(color: btnColor1),
// //   //                                         ),
// //   //                                       ),
// //   //                                     )
// //   //                                   ],
// //   //                                 ))
// //   //                           ],
// //   //                         ),
// //   //                       ),
// //   //                     )
// //   //                   ],
// //   //                 ),
// //   //               ),
// //   //             ],
// //   //           ),
// //   //         )),
// //   //   );
// //   // }
