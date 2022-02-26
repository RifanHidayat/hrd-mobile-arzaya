// import 'dart:convert';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:format_indonesia/format_indonesia.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:hrdmagenta/page/admin/l/home/navbar.dart';
// import 'package:hrdmagenta/page/employee/absence/MapsDetail.dart';
// import 'package:hrdmagenta/page/employee/absence/photoview.dart';
// import 'package:hrdmagenta/services/api_clien.dart';
// import 'package:hrdmagenta/utalities/alert_dialog.dart';
// import 'package:hrdmagenta/utalities/constants.dart';
// import 'package:hrdmagenta/utalities/font.dart';
// import 'package:intl/intl.dart';
// import 'package:http/http.dart' as http;
//
// class detail_absence_admin_notif extends StatefulWidget {
//   detail_absence_admin_notif({this.id});
//
//   var id;
//
//   _detail_absence_admin_notifState createState() =>
//       _detail_absence_admin_notifState();
// }
//
// class _detail_absence_admin_notifState
//     extends State<detail_absence_admin_notif> {
//   String _currentAddress;
//
//   final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
//   var _time, _date, _category, _loading;
//
//   Map _absence;
//
//   Future<bool> _onBackPressed() {
//     Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(builder: (BuildContext context) => NavBarAdmin()),
//         ModalRoute.withName('/'));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: IconThemeData(
//           color: Colors.black87, //modify arrow color from here..
//         ),
//         backgroundColor: Colors.white,
//         title: new Text(
//           "Detail Kehadiran",
//           style: TextStyle(color: Colors.black87),
//         ),
//       ),
//       body: _loading == true
//           ? Center(
//         child: CircularProgressIndicator(),
//       )
//           : WillPopScope(
//         onWillPop: _onBackPressed,
//         child: Container(
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height,
//           child: SingleChildScrollView(
//             child: Container(
//               margin: EdgeInsets.only(left: 15, right: 15, top: 15),
//               width: MediaQuery.of(context).size.width,
//               child: Column(
//                 children: <Widget>[
//                   _buildProfile(),
//                   _buildAbsenceType(),
//                   Divider(color: Colors.black12,),
//                   // _buildAbsencecategory(),
//                   // Divider(color: Colors.black12,),
//                   _buildDate(),
//                   Divider(color: Colors.black12,),
//                   _buildTime(),
//                   Divider(color: Colors.black12,),
//                   _buildRemark(),
//                   Divider(color: Colors.black12,),
//                   _buildAdress(),
//                   Divider(color: Colors.black12,),
//                   _buildgridtext(),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   _buildgrid(),
//
//                   SizedBox(
//                     height: 10,
//                   ),
//
//                   Container(
//                       child: _absence['data']['status'] == "pending"
//                           ? _buildpending()
//                           : _absence['data']['status'] == "rejected"
//                           ? _buildrejected()
//                           : _buildapproved()),
//                   //_buildrejected(),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   //convert lat dan long to address
//   _getAddressFromLatLng(double _lat, double _long) async {
//     try {
//       List<Placemark> p =
//       await geolocator.placemarkFromCoordinates(_lat, _long);
//       Placemark place = p[0];
//       setState(() {
//         _currentAddress =
//         "${place.locality}, ${place.postalCode}, ${place.country}";
//       });
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   //widget profile
//   Widget _buildProfile() {
//     return Container(
//       margin: EdgeInsets.all(20),
//       child: Row(
//         children: <Widget>[
//           Container(
//               child: CircleAvatar(
//                 backgroundImage: NetworkImage("$image_ur/${_absence['data']['employee']['photo']}",),
//                 backgroundColor: Colors.transparent,
//                 radius: 40,
//               )),
//           Container(
//             margin: EdgeInsets.only(left: 10, right: 10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Container(
//                   child: Text(
//                     "${_absence['data']['employee']['first_name']}",
//                     style: TextStyle(
//                         fontSize: 18,
//                         color: Colors.black87,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                   child: Text(
//                     "${_absence['data']['employee']['employee_id']}",
//                     style: TextStyle(
//                       fontSize: 15,
//                       color: Colors.black38,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ) //Container
//         ],
//       ),
//     );
//   }
//
//   //widget type
//   Widget _buildAbsenceType() {
//     return Container(
//       margin: EdgeInsets.only(left: 5),
//       width: double.infinity,
//
//       child: Row(
//         children: <Widget>[
//
//           Container(
//             margin: EdgeInsets.only(left: 10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Container(
//                   child: Text(
//                     "Type",
//                     style: titleAbsence,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                   child: Text(
//                     "${_absence['data']['type']}",
//                     style: subtitleAbsence,
//                   ),
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   Widget _buildRemark() {
//     return Container(
//       margin: EdgeInsets.only(left: 5),
//       width: double.infinity,
//
//       child: Row(
//         children: <Widget>[
//
//           Container(
//             margin: EdgeInsets.only(left: 10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Container(
//                   child: Text(
//                     "Catatan",
//                     style: titleAbsence,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                   width: MediaQuery.of(context).size.width - 100,
//                   child: (_absence['data']['note'] == null)
//                       ? Text(
//                     "-",
//                     style: titleAbsence,
//                   )
//                       : Text(
//                     "${_absence['data']['note']}",
//                     style: subtitleAbsence,
//                   ),
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   Widget _buildAbsencecategory() {
//     return Container(
//       margin: EdgeInsets.only(left: 5),
//       width: double.infinity,
//
//       child: Row(
//         children: <Widget>[
//
//           Container(
//             margin: EdgeInsets.only(left: 10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Container(
//                   child: Text(
//                     "Kategori",
//                     style: titleAbsence,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                   child: Text(
//                     "${_absence['data']['category']}",
//                     style: subtitleAbsence,
//                   ),
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
// //widget date
//   Widget _buildDate() {
//     return Container(
//       margin: EdgeInsets.only(left: 5),
//       width: double.infinity,
//
//       child: Row(
//         children: <Widget>[
//
//           Container(
//             margin: EdgeInsets.only(left: 10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Container(
//                   child: Text(
//                     "Tanggal ",
//                     style: titleAbsence,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                   child: Text(
//                     "${_date}",
//                     style: subtitleAbsence,
//                   ),
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
// //widget adress
//   Widget _buildAdress() {
//     return Container(
//       margin: EdgeInsets.only(left: 5),
//       width: double.infinity,
//       child: Row(
//         children: <Widget>[
//
//           Container(
//             margin: EdgeInsets.only(left: 10, bottom: 10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Container(
//                   child: Text(
//                     "Alamat",
//                     style: titleAbsence,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Column(
//                   children: [
//                     Container(
//                       width: MediaQuery.of(context).size.width - 100,
//                       child: _currentAddress == null
//                           ? Text("")
//                           : Text(
//                         "$_currentAddress ",
//                         style: subtitleAbsence,
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTime() {
//     return Container(
//       margin: EdgeInsets.only(left: 5),
//       width: double.infinity,
//
//       child: Row(
//         children: <Widget>[
//
//           Container(
//             margin: EdgeInsets.only(left: 10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Container(
//                   child: Text(
//                     "Waktu",
//                     style: titleAbsence,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                   child: Text(
//                     _time.toString(),
//                     style: subtitleAbsence,
//                   ),
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   Widget _buildgridtext() {
//     return Container(
//       height: 20,
//       child: GridView.count(
//         crossAxisCount: 2,
//         shrinkWrap: true,
//         primary: true,
//         physics: const NeverScrollableScrollPhysics(),
//         children: <Widget>[
//           //photos
//           Container(
//               margin: EdgeInsets.only(left: 10),
//               child: Text(
//                 "Foto",
//                 style: titleAbsence,
//               )),
//           //map
//
//           InkWell(
//             onTap: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => MapsDetail(
//                         latitude:
//                         _absence['data']['clock_in_latitude'] != null
//                             ? _absence['data']['clock_in_latitude']
//                             : _absence['data']['clock_out_latitude'],
//                         longitude:
//                         _absence['data']['clock_in_longitude'] != null
//                             ? _absence['data']['clock_in_longitude']
//                             : _absence['data']['clock_out_longitude'],
//                         departement_name: _absence['data']['employee']
//                         ['work_placement'],
//                         address: _currentAddress,
//                         profile_background: "",
//                         firts_name: _absence['data']['employee']
//                         ['first_name'],
//                         last_name: _absence['data']['employee']
//                         ['last_name'],
//                         office_latitude: _absence['data']
//                         ['office_latitude'],
//                         office_longitude: _absence['data']
//                         ['office_longitude'],
//                       )));
//             },
//             child: Container(
//               margin: EdgeInsets.only(right: 10, left: 10),
//               child: Text(
//                 "Lokasi",
//                 style: titleAbsence,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildgrid() {
//     return Container(
//       height: 200,
//       child: GridView.count(
//         physics: ClampingScrollPhysics(),
//         shrinkWrap: true,
//         primary: true,
//         crossAxisCount: 2,
//         children: <Widget>[
//           // photos
//           Container(
//             child: _buildphotos(),
//           ),
//           //map
//           Container(
//               margin: EdgeInsets.only(right: 10, left: 10), child: _builmap()),
//         ],
//       ),
//     );
//   }
//
//   Widget _builmap() {
//     return InkWell(
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => MapsDetail(
//                   latitude: _absence['data']['clock_in_latitude'] != null
//                       ? _absence['data']['clock_in_latitude']
//                       : _absence['data']['clock_out_latitude'],
//                   longitude: _absence['data']['clock_in_longitude'] != null
//                       ? _absence['data']['clock_in_longitude']
//                       : _absence['data']['clock_out_longitude'],
//                   departement_name: _absence['data']['employee']
//                   ['work_placement'],
//                   address: _currentAddress,
//                   profile_background: "",
//                   firts_name: _absence['data']['employee']['first_name'],
//                   last_name: _absence['data']['employee']['last_name'],
//                   office_latitude: _absence['data']['office_latitude'],
//                   office_longitude: _absence['data']['office_longitude'],
//                 )));
//       },
//       child: Container(
//           child: SizedBox(
//             width: 300.0,
//             height: 300.0,
//             child: Stack(
//               children: [
//                 GoogleMap(
//                     initialCameraPosition: CameraPosition(
//                         target: LatLng(
//                             double.parse(
//                                 _absence['data']['clock_in_latitude'] != null
//                                     ? _absence['data']['clock_in_latitude']
//                                     : _absence['data']['clock_out_latitude']),
//                             double.parse(
//                                 _absence['data']['clock_in_longitude'] != null
//                                     ? _absence['data']['clock_in_longitude']
//                                     : _absence['data']['clock_out_longitude'])),
//                         zoom: 11.0),
//                     markers: Set<Marker>.of(<Marker>[
//                       Marker(
//                         markerId: MarkerId("1"),
//                         position: LatLng(
//                             double.parse(
//                                 _absence['data']['clock_in_latitude'] != null
//                                     ? _absence['data']['clock_in_latitude']
//                                     : _absence['data']['clock_out_latitude']),
//                             double.parse(
//                                 _absence['data']['clock_in_longitude'] != null
//                                     ? _absence['data']['clock_in_longitude']
//                                     : _absence['data']['clock_out_longitude'])),
//                       ),
//                     ]),
//                     gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
//                       Factory<OneSequenceGestureRecognizer>(
//                             () => ScaleGestureRecognizer(),
//                       ),
//                     ].toSet()),
//                 InkWell(
//                   onTap: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => MapsDetail(
//                               latitude:
//                               _absence['data']['clock_in_latitude'] != null
//                                   ? _absence['data']['clock_in_latitude']
//                                   : _absence['data']['clock_out_latitude'],
//                               longitude:
//                               _absence['data']['clock_in_longitude'] != null
//                                   ? _absence['data']['clock_in_longitude']
//                                   : _absence['data']['clock_out_longitude'],
//                               departement_name: _absence['data']['employee']
//                               ['work_placement'],
//                               address: _currentAddress,
//                               profile_background: "",
//                               firts_name: _absence['data']['employee']
//                               ['first_name'],
//                               last_name: _absence['data']['employee']
//                               ['last_name'],
//                               office_latitude: _absence['data']
//                               ['office_latitude'],
//                               office_longitude: _absence['data']
//                               ['office_longitude'],
//                             )));
//                   },
//                   child: Container(
//                     width: 300,
//                     height: 200,
//                     color: Colors.transparent,
//                   ),
//                 )
//               ],
//             ),
//           )),
//     );
//   }
//
//   Widget _buildphotos() {
//     return Hero(
//         tag: "avatar-1",
//         child: Container(
//             margin: EdgeInsets.only(left: 10),
//             color: Colors.black87,
//             height: double.infinity,
//             child: InkWell(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => PhotoViewPage(
//                         image: _absence['data']['image'],
//                       )),
//                 );
//               },
//               child: _absence['data']['image'] == null
//                   ? Image.asset(
//                 "assets/absen.jpeg",
//                 width: double.infinity,
//                 height: double.infinity,
//                 fit: BoxFit.fill,
//               )
//                   : CachedNetworkImage(
//                 imageUrl: "$image_ur/${_absence['data']['image']}",
//                 fit: BoxFit.fill,
//                 placeholder: (context, url) =>
//                     Center(child: new CircularProgressIndicator()),
//                 errorWidget: (context, url, error) =>
//                 new Icon(Icons.error),
//               ),
//             )));
//   }
//
//   Widget _buildrejected() {
//     return Container(
//         child: _category == true
//             ? Column(
//           children: <Widget>[
//             Container(
//               color: Colors.redAccent,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   Center(
//                     child: CircleAvatar(
//                       backgroundColor: Colors.redAccent,
//                       child: Icon(
//                         Icons.close,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(left: 2),
//                     child: Text(
//                       "REJECTED",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 17,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             _buildrejectedby(),
//             _buildrejecteddate(),
//             // _buildrejectedon(),
//             _buildrejectednote()
//           ],
//         )
//             : Text(""));
//   }
//
//   Widget _buildrejectedby() {
//     return Container(
//       margin: EdgeInsets.only(left: 5),
//       width: double.infinity,
//
//       child: Row(
//         children: <Widget>[
//
//           Container(
//             margin: EdgeInsets.only(left: 10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Container(
//                   child: Text(
//                     "Ditolak oleh ",
//                     style: titleAbsence,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                   child: Text(
//                     "${_absence['data']['rejected_by']['first_name']} ${_absence['data']['rejected_by']['last_name']}",
//                     style: subtitleAbsence,
//                   ),
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   Widget _buildrejecteddate() {
//     return Container(
//       margin: EdgeInsets.only(left: 5),
//       width: double.infinity,
//
//       child: Card(
//         child: Row(
//           children: <Widget>[
//
//             Container(
//               margin: EdgeInsets.only(left: 10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Container(
//                     child: Text(
//                       "Ditolak pada",
//                       style: titleAbsence,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Container(
//                     child: Text(
//                       "${_absence['data']['rejected_at']}",
//                       style: subtitleAbsence,
//                     ),
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildrejectedon() {
//     return Container(
//       margin: EdgeInsets.only(left: 5),
//       width: double.infinity,
//
//       child: Card(
//         child: Row(
//           children: <Widget>[
//
//             Container(
//               margin: EdgeInsets.only(left: 10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Container(
//                     child: Text(
//                       "Rejected On",
//                       style: titleAbsence,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Container(
//                     // child: Text(
//                     //   "${widget.rejected_on}",
//                     //   style: subtitleAbsence,
//                     // ),
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildrejectednote() {
//     return Container(
//       margin: EdgeInsets.only(left: 5),
//       width: double.infinity,
//
//       child: Card(
//         child: Row(
//           children: <Widget>[
//
//             Container(
//               margin: EdgeInsets.only(left: 10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Container(
//                     child: Text(
//                       "Catatan",
//                       style: titleAbsence,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Container(
//                     width: MediaQuery.of(context).size.width - 100,
//                     child: _absence['data']['rejection_note'] == null
//                         ? Text(
//                       "-",
//                       style: subtitleAbsence,
//                     )
//                         : Text(
//                       "${_absence['data']['rejection_note']}",
//                       style: subtitleAbsence,
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   ///approved
//   Widget _buildapproved() {
//     return Container(
//         child: _category == true
//             ? Column(
//           children: <Widget>[
//             Container(
//               color: Colors.green,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   Center(
//                     child: CircleAvatar(
//                       backgroundColor: Colors.green,
//                       child: Icon(
//                         Icons.check,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(left: 2),
//                     child: Text(
//                       "APPROVED",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 17,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             _buildapprovedby(),
//             _buildapproveddate(),
//             //  _buildapprovedon(),
//             _buildapprovalnote()
//           ],
//         )
//             : Text(""));
//   }
//
//   Widget _buildapprovedby() {
//     return Container(
//       margin: EdgeInsets.only(left: 5),
//       width: double.infinity,
//
//       child: Card(
//         child: Row(
//           children: <Widget>[
//
//             Container(
//               margin: EdgeInsets.only(left: 10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Container(
//                     child: Text(
//                       "Disetujui Oleh",
//                       style: titleAbsence,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Container(
//                     width: MediaQuery.of(context).size.width - 100,
//                     child: Text(
//                       "${_absence['data']['approved_by']['first_name']} ${_absence['data']['approved_by']['last_name']}",
//                       style: subtitleAbsence,
//                     ),
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildapproveddate() {
//     return Container(
//       margin: EdgeInsets.only(left: 5),
//       width: double.infinity,
//
//       child: Card(
//         child: Row(
//           children: <Widget>[
//
//             Container(
//               margin: EdgeInsets.only(left: 10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Container(
//                     child: Text(
//                       "Disetujui Pada",
//                       style: titleAbsence,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Container(
//                     child: Text(
//                       "${_absence['data']['approved_at'] == null ? Text("") : _absence['data']['approved_at']}",
//                       style: subtitleAbsence,
//                     ),
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildapprovedon() {
//     return Container(
//       margin: EdgeInsets.only(left: 5),
//       width: double.infinity,
//       height: 80,
//       child: Card(
//         child: Row(
//           children: <Widget>[
//             Container(
//               child: Icon(
//                 Icons.timer_rounded,
//                 color: Colors.black38,
//                 size: 40,
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(left: 10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Container(
//                     child: Text(
//                       "Approved On",
//                       style: titleAbsence,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Container(
//                     // child: Text(
//                     //   "${widget.approved_on}",
//                     //   style: subtitleAbsence,
//                     // ),
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildapprovalnote() {
//     return Container(
//       margin: EdgeInsets.only(left: 5),
//       width: double.infinity,
//
//       child: Card(
//         child: Row(
//           children: <Widget>[
//
//             Container(
//               margin: EdgeInsets.only(left: 10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Container(
//                     child: Text(
//                       "Catatan",
//                       style: titleAbsence,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Container(
//                     width: MediaQuery.of(context).size.width - 100,
//                     child: _absence['data']['approval_note'] == null
//                         ? Text(
//                       "-",
//                       style: subtitleAbsence,
//                     )
//                         : Text(
//                       "${_absence['data']['approval_note']}",
//                       style: subtitleAbsence,
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future _dataAbsence() async {
//     try {
//       setState(() {
//         _loading = true;
//       });
//       http.Response response =
//       await http.get("$base_url/api/attendances/${widget.id}");
//       _absence = jsonDecode(response.body);
//       setState(() {
//         _loading = false;
//
//         _time = DateFormat('hh:mm:ss').format(DateTime.parse(
//             _absence['data']['clock_in'] != null
//                 ? _absence['data']['clock_in']
//                 : _absence['data']['clock_out']));
//         _date = Waktu(DateTime.parse(_absence['data']['date'])).yMMMd();
//         //  _getAddressFromLatLng(_absence['data']['clock_in_latitude']!=null?_absence['data']['clock_in_latitude']:_absence['data']['clock_out_latitude'],_absence['data']['clock_in_longitude']!=null?_absence['data']['clock_in_longitude']:_absence['data']['clock_out_longitude']);
//         if ((_absence['data']['category'] == "present") ||
//             (_absence['data']['category'] == "present")) {
//           _category = false;
//         } else {
//           _category = true;
//         }
//       });
//     } catch (e) {}
//   }
//
//   Widget _buildpending() {
//     return Container(
//       width: double.infinity,
//       height: 150,
//       child: GridView.count(
//         shrinkWrap: true,
//         primary: true,
//         physics: const NeverScrollableScrollPhysics(),
//         crossAxisCount: 2,
//         children: <Widget>[
//           //photos
//           Container(
//             margin: EdgeInsets.only(bottom: 130),
//             child: Container(
//               child: new RaisedButton(
//                 color: Colors.red,
//                 onPressed: () {
//                   alert_reject(context, widget.id, "1", "reject", "rejected_by",
//                       "rejection_note");
//                 },
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Center(
//                         child: new Text(
//                           "Reject",
//                           style: subtitleapprove,
//                         )),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           //map
//
//           Container(
//             margin: EdgeInsets.only(bottom: 130, left: 10),
//             child: Container(
//               child: new RaisedButton(
//                 color: Colors.green,
//                 onPressed: () {
//                   alert_approve(context, widget.id, "1", "approve",
//                       "approved_by", "approval_note");
//                 },
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Container(
//                       child: new Text("Approve", style: subtitleapprove),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _dataAbsence();
//
//     var waktu = Waktu();
//     print(waktu.yMMMMEEEEd());
//   }
// }
