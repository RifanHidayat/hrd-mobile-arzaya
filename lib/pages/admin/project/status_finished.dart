// import 'dart:convert';
//
// import 'package:flutter/material.dart';
//
// import 'package:http/http.dart' as http;
// import 'package:magentahrdios/pages/admin/project/shimmer_project.dart';
// import 'package:magentahrdios/services/api_clien.dart';
// import 'package:magentahrdios/utalities/color.dart';
// import 'package:magentahrdios/utalities/constants.dart';
// import 'package:percent_indicator/circular_percent_indicator.dart';
// import 'package:toast/toast.dart';
//
//
// class projecthistory extends StatefulWidget {
//   @override
//   _projecthistoryState createState() => _projecthistoryState();
// }
//
//
//
// class _projecthistoryState extends State<projecthistory> {
//   final _scaffoldKey = new GlobalKey<ScaffoldState>();
//   VoidCallback? _showPersBottomSheetCallBack;
//   Map? _projects;
//   bool _loading=false;
// //------------bottom sheet--------
//   void _showModalSheet() {
//     showModalBottomSheet(
//         context: context,
//         builder: (builder) {
//           return Container(
//
//             height: MediaQuery.of(context).size.height-40,
//             child: new Card(
//               elevation: 1,
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Container(
//                       margin: EdgeInsets.all(20),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//
//                           //project
//                           Text("Project",
//                             style: TextStyle(fontFamily: "OpenSans",
//                               color: textColor1,
//                               fontSize: 20,
//
//
//                             ),
//                           ),
//                           new Divider(
//                             color: Colors.black38,
//                           ),
//                           _detailproject(),
//                           _location(),
//                           _budgetAwal(),
//                           _budgetsisa(),
//
//                           //team
//                           Text("Team",
//                             style: TextStyle(fontFamily: "OpenSans",
//                               color: textColor1,
//                               fontSize: 20,
//
//
//                             ),
//                           ),
//                           new Divider(
//                             color: Colors.black38,
//                           ),
//                           SizedBox(height: 10,),
//                           _buildteam(),
//                           SizedBox(height: 10,),
//                           _buildteam1(),
//
//                           //Task
//                           SizedBox(height: 10,),
//                           Text("Task",
//                             style: TextStyle(fontFamily: "OpenSans",
//                               color: textColor1,
//                               fontSize: 20,
//
//
//                             ),
//                           ),
//                           new Divider(
//                             color: Colors.black38,
//                           ),
//                           SizedBox(height: 10,),
//                           _buildTask()
//
//
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//
//             ),
//           );
//         });
//   }
//
//
//   void _showBottomSheet() {
//     setState(() {
//       _showPersBottomSheetCallBack = null;
//     });
//
//     _scaffoldKey.currentState
//         ?.showBottomSheet((context) {
//       return new Container(
//         height: 100,
//         color: Colors.greenAccent,
//         child: new Center(
//           child: new Text("Hi BottomSheet"),
//         ),
//       );
//     })
//         .closed
//         .whenComplete(() {
//       if (mounted) {
//         setState(() {
//           _showPersBottomSheetCallBack = _showBottomSheet;
//         });
//       }
//     });
//   }
//
//
//
//   //widget-------------------------------
//   //content bottom sheet profile
//   Widget _buildteam(){
//     return Container(
//       child: Row(
//         children: <Widget>[
//           //container image
//           Container(
//             child: CircleAvatar(
//               backgroundColor: Colors.black38,
//               radius: 30,
//
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.only(left: 10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//
//                 Text("Rifan Hidayat",style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 15,
//                     fontWeight: FontWeight.bold
//
//                 ),),
//                 Text("Leader",style: TextStyle(
//                   color: Colors.black38,
//                   fontSize: 15,
//
//                 ),)
//
//               ],
//             ),
//
//           ),
//         ],
//       ),
//
//     );
//   }
// //widget event name
//   Widget _detailproject(){
//     return Container(
//       child: Row(
//         children: <Widget>[
//           //container image
//           Container(
//             child: CircleAvatar(
//               backgroundColor: Colors.white,
//               radius: 30,
//               child: Icon(
//                 Icons.label,
//                 size: 30,
//                 color: Colors.black38,
//               ),
//
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.only(left: 10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//
//                 Text("Event Name",style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 15,
//                     fontWeight: FontWeight.bold
//
//                 ),),
//                 Text("Seminar",style: TextStyle(
//                   color: Colors.black38,
//                   fontSize: 15,
//
//                 ),)
//
//               ],
//             ),
//
//           ),
//         ],
//       ),
//
//     );
//
//   }
//   Widget _location(){
//     return Container(
//       child: Row(
//         children: <Widget>[
//           //container image
//           Container(
//             child: CircleAvatar(
//               backgroundColor: Colors.white,
//               radius: 30,
//               child: Icon(
//                 Icons.location_on,
//                 size: 30,
//                 color: Colors.black38,
//               ),
//
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.only(left: 10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//
//                 Text("Location",style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 15,
//                     fontWeight: FontWeight.bold
//
//                 ),),
//                 Text("Jl Saturnus no 11A",style: TextStyle(
//                   color: Colors.black38,
//                   fontSize: 15,
//
//                 ),)
//
//               ],
//             ),
//
//           ),
//         ],
//       ),
//
//     );
//   }
//   //
//   Widget _budgetAwal(){
//     return Container(
//       child: Row(
//         children: <Widget>[
//           //container image
//           Container(
//             child: CircleAvatar(
//               backgroundColor: Colors.white,
//               radius: 30,
//               child: Icon(
//                 Icons.monetization_on ,
//                 size: 30,
//                 color: Colors.black38,
//               ),
//
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.only(left: 10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//
//                 Text("Budget",style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 15,
//                     fontWeight: FontWeight.bold
//
//                 ),),
//                 Text("Rp.100.000.000",style: TextStyle(
//                   color: Colors.black38,
//                   fontSize: 15,
//                 ),)
//
//               ],
//             ),
//
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _budgetsisa(){
//     return Container(
//       child: Row(
//         children: <Widget>[
//           //container image
//           Container(
//             child: CircleAvatar(
//               backgroundColor: Colors.white,
//               radius: 30,
//               child: Icon(
//                 Icons.monetization_on_outlined,
//                 size: 30,
//                 color: Colors.black38,
//               ),
//
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.only(left: 10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//
//                 Text("Sisa Budget",style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 15,
//                     fontWeight: FontWeight.bold
//
//                 ),),
//                 Text("Rp.10.000.000",style: TextStyle(
//                   color: Colors.black38,
//                   fontSize: 15,
//                 ),)
//
//               ],
//             ),
//
//           ),
//         ],
//       ),
//
//     );
//
//
//   }
//
//
//
//   Widget _buildteam1(){
//     return Container(
//       child: Row(
//         children: <Widget>[
//           //container image
//           Container(
//             child: CircleAvatar(
//               backgroundColor: Colors.black38,
//               radius: 30,
//
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.only(left: 10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//
//                 Text("Eza",style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 15,
//                     fontWeight: FontWeight.bold
//
//                 ),),
//                 Text("Position",style: TextStyle(
//                   color: Colors.black38,
//                   fontSize: 15,
//
//                 ),)
//
//               ],
//             ),
//
//           ),
//         ],
//       ),
//
//     );
//
//   }
//
//   Widget _buildTask(){
//     return Container(
//       width: double.infinity,
//       child: Center(
//         child: Column(
//           children: <Widget>[
//             new CircularPercentIndicator(
//               radius: 120.0,
//               lineWidth: 13.0,
//               animation: true,
//               percent: 0.7,
//               center: new Text(
//                 "70.0%",
//                 style:
//                 new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
//               ),
//               footer: new Text(
//                 "Progress in Project",
//                 style:
//                 new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
//               ),
//               circularStrokeCap: CircularStrokeCap.round,
//               progressColor: baseColor,
//             ),
//             SizedBox(height: 10,),
//
//
//           ],
//         ),
//       ),
//     );
//   }
//   //------ widget project----
//   Widget _buildproject(index){
//     return Container(
//
//         width: double.infinity,
//         child:Card(
//           elevation: 1,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//
//               Container(
//                 margin: EdgeInsets.all(10),
//                 child: Row(
//                   children: <Widget>[
//
//                     Expanded(
//                       flex: 1,
//                       child: Container(
//                         margin: EdgeInsets.only(right: 5,left: 5,top: 15),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: <Widget>[
//                             SizedBox(height: 10,),
//                             Text("Seminar",
//                               style: TextStyle(
//                                   fontSize: 18,
//                                   color: Colors.black87,
//                                   fontWeight: FontWeight.bold
//                               ),
//                             ),
//                             SizedBox(height: 5,),
//
//                             Text("Jalan Saturnus ujung No 11A",
//                               style: TextStyle(
//                                   fontSize: 15,
//                                   color: Colors.black38
//                               ),
//                             ),
//                             SizedBox(height: 5,),
//                             Text("Rp.30.000.000",
//                               style: TextStyle(
//                                   fontSize: 15,
//                                   color: Colors.green
//                               ),
//                             ),
//                             SizedBox(height: 10,),
//
//                             Container(
//                                 width: double.infinity,
//                                 height: 40,
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   crossAxisAlignment: CrossAxisAlignment.end ,
//                                   children: <Widget>[
//                                     //button detail
//                                     new RaisedButton(
//                                       padding: const EdgeInsets.all(8.0),
//                                       textColor: Colors.white,
//                                       color: btnColor1,
//
//                                       onPressed: (){
//                                         _showModalSheet();
//
//                                       },
//                                       child: new Text("Detail"),
//                                     ),
//
//
//                                     //button budgeting
//
//                                     Container(
//                                       margin: EdgeInsets.only(left: 5),
//                                       child: new  OutlineButton(
//                                         color: btnColor1,
//
//                                         onPressed: () {
//                                           // Navigator.push(context, MaterialPageRoute(
//                                           //     builder: (context) => budgetprojec()
//                                           // ));
//                                         },
//                                         child: Text('Budget',
//                                           style: TextStyle(color: btnColor1),
//                                         ),
//                                       ),
//                                     )
//
//                                   ],
//                                 )
//                             )
//
//
//                           ],
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//
//         )
//     );
//   }
//
//   Widget _buildnodata(){
//     return Container(
//       height: MediaQuery.of(context).size.height-250,
//
//
//
//
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Container(
//               child: no_data_project,
//             ),
//             SizedBox(height: 20,),
//             Container(
//                 child: Text("No projects yet",
//                   style: TextStyle(
//                       color: Colors.black38,
//                       fontSize: 18
//                   ),
//
//                 )
//             ),
//           ],
//         ),
//       ),
//     );
//
//   }
//
//
//   _searchBar() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: TextField(
//
//         decoration: InputDecoration(
//
//             hintText: 'Search project'
//         ),
//         onChanged: (text) {
//           // text = text.toLowerCase();
//           // setState(() {
//           //   _ModelListTampil = _ModelList.where((note) {
//           //     var noteTitle = note.kata.toLowerCase();
//           //     return noteTitle.contains(text);
//           //   }).toList();
//           // });
//         },
//       ),
//     );
//   }
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         color: Colors.white38,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Container(
//               margin: EdgeInsets.only(top: 10,left: 10),
//               child: Text(
//                 "displays all completed projects",
//                 style: TextStyle(
//                   color: Colors.black87
//                 ),
//
//               ),
//             ),
//             _searchBar(),
//             Expanded(
//               child: Container(
//                 child: _loading?Center(child: ShimmerProject(),):  ListView.builder(
//                     itemCount: _projects!['data'].length==0?1:_projects!['data'].length,
//                     itemBuilder:(context,index){
//
//                       return _projects!['data'].length.toString()=="0"? _buildnodata(): _buildproject(index);
//                     }),
//
//               ),
//             ),
//
//
//           ],
//         ),
//       ),
//
//     );
//   }
//
//
//
//   //ge data from api--------------------------------
//   Future _dataProject() async{
//     try{
//       setState(() {
//         _loading=true;
//       });
//       http.Response response=await http.get(Uri.parse("$base_url/api/events?status=closed"));
//       _projects=jsonDecode(response.body);
//
//
//       setState(() {
//         _loading=false;
//       });
//     }catch(e){
//
//     }
//   }
//
//
//
//
//   //inialisaasi state
//   @override
//   void initState() {
//     super.initState();
//     _dataProject();
//     _showPersBottomSheetCallBack = _showBottomSheet;
//   }
//
//
// }
