import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:format_indonesia/format_indonesia.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:magentahrdios/pages/employee/attendances/MapsDetail.dart';
import 'package:magentahrdios/pages/employee/attendances/map.dart';
import 'package:magentahrdios/pages/employee/attendances/photoview.dart';

import 'package:magentahrdios/services/api_clien.dart';
import 'package:magentahrdios/utalities/color.dart';
import 'package:magentahrdios/utalities/fonts.dart';
import 'package:page_transition/page_transition.dart';


class AttendancesDetailPage extends StatefulWidget {
  AttendancesDetailPage(
      {this.status,
      this.employee,
      this.date,
      this.time,
      this.latitude,
      this.image,
      this.type,
      this.longitude,
      this.note,
      this.approval_note,
      this.approved_by,
      this.approved_on,
      this.rejected_by,
      this.rejected_on,
      this.rejection_note,
      this.firts_name_employee,
      this.last_name_employee,
      this.work_placement,
      this.office_latitude,
      this.office_longitude,
      this.employee_id,
      this.photo,
      this.category});

  var status,
      employee,
      type,
      date,
      time,
      latitude,
      longitude,
      image,
      approved_by,
      approved_on,
      rejected_by,
      rejected_on,
      note,
      rejection_note,
      approval_note,
      firts_name_employee,
      last_name_employee,
      work_placement,
      office_latitude,
      office_longitude,
      employee_id,
      photo,
      category;

  _AttendancesDetailPageState createState() => _AttendancesDetailPageState();
}

class _AttendancesDetailPageState extends State<AttendancesDetailPage> {
  String? _currentAddress;

  // final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  var _time, _date, _category;
  // MapboxMapController? mapController;
  GeoCode? geoCode = GeoCode();

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
          "Detail Kehadiran",
          style: TextStyle(
              color: Colors.white,
              fontFamily: "Roboto-medium",
              fontSize: 18,
              letterSpacing: 0.5),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 15, right: 15, top: 15),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    "Kehadiran Tercatat Pada ${Waktu(DateTime.parse(_date.toString())).yMMMMEEEEd()} ${_time}",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Roboto-medium",
                        letterSpacing: 0.5,
                        fontSize: 13),
                  ),
                ),
                //  _buildAbsenceType(),
                // Divider(color: Colors.black12,),
                // _buildAbsencecategory(),
                // Divider(color: Colors.black12,),
                // _buildDate(),
                // Divider(color: Colors.black12,),
                // _buildTime(),
                // // Divider(color: Colors.black12,),
                // // _buildRemark(),
                // Divider(color: Colors.black12,),
                SizedBox(
                  height: 30,
                ),
                _buildAdress(),

                _buildNote(),


                _buildgridtext(),

                SizedBox(
                  height: 10,
                ),
                _buildgrid(),

                SizedBox(
                  height: 10,
                ),
                Container(
                    child: widget.status == "pending"
                        ? Text("")
                        : widget.status == "rejected"
                            ? _buildrejected()
                            : _buildapproved()),
                //_buildrejected(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //convert lat dan long to address
  _getAddressFromLatLng() async {
    // try {
    //   Address? address = await geoCode!.reverseGeocoding(
    //       latitude: double.parse(widget.latitude),
    //       longitude: double.parse(widget.longitude));
    //   setState(() {
    //     _currentAddress =
    //         "${address.streetAddress} ${address.region} ${address.city} ";
    //   });
    // } catch (e) {
    //   print(e);
    // }
    try {
      List<Placemark> p = await Geolocator().placemarkFromCoordinates(
          double.parse(widget.latitude), double.parse(widget.longitude));
      Placemark place = p[0];
      setState(() {
        _currentAddress =
        "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  //widget profile
  Widget _buildProfile() {
    return Container(
      margin: EdgeInsets.all(20),
      child: Row(
        children: <Widget>[
          Container(
              child: CircleAvatar(
            backgroundImage:
                NetworkImage('${image_ur}/photos/default-photo.png'),
            backgroundColor: Colors.transparent,
            radius: 40,
          )),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    "${widget.firts_name_employee}",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text(
                    "${widget.employee_id}",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black38,
                    ),
                  ),
                ),
              ],
            ),
          ) //Container
        ],
      ),
    );
  }

  // //widget type
  // Widget _buildAbsenceType() {
  //   return Container(
  //     margin: EdgeInsets.only(left: 5),
  //     width: double.infinity,
  //
  //     child: Row(
  //       children: <Widget>[
  //
  //         Container(
  //           margin: EdgeInsets.only(left: 10),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: <Widget>[
  //               Container(
  //                 child: Text(
  //                   "Type",
  //                   style: titleAbsence,
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: 10,
  //               ),
  //               Container(
  //                 child: Text(
  //                   "${widget.type}",
  //                   style: subtitleAbsence,
  //                 ),
  //               )
  //             ],
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  Widget _buildRemark() {
    return Container(
      margin: EdgeInsets.only(left: 5),
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    "Catatan",
                    style: titleAbsence,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 100,
                  child: (widget.note == null)
                      ? Text(
                          "-  ",
                          style: titleAbsence,
                        )
                      : Text(
                          "${widget.note}",
                          style: subtitleAbsence,
                        ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAbsencecategory() {
    return Container(
      margin: EdgeInsets.only(left: 5),
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    "Kategori",
                    style: titleAbsence,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: widget.category == "present"
                      ? Text(
                          "Hadir",
                          style: subtitleAbsence,
                        )
                      : Container(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

//widget date
  Widget _buildDate() {
    return Container(
      margin: EdgeInsets.only(left: 5),
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    "Tanggal",
                    style: titleAbsence,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text(
                    "${_date}",
                    style: subtitleAbsence,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

//widget adress
  Widget _buildAdress() {
    return Container(
      margin: EdgeInsets.only(left: 5),
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    "Alamat",
                    style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 0.5,
                        fontFamily: "Roboto-medium",
                        fontSize: 15),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 100,
                      child: _currentAddress == null
                          ? Text("")
                          : Text(
                              "${_currentAddress}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  letterSpacing: 0.5,
                                  fontFamily: "Roboto-regular"),
                            ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
  //widget adress
  Widget _buildNote() {
    return Container(
      margin: EdgeInsets.only(left: 5),
      width: double.infinity,
      child: Row(
        children: <Widget>[
          widget.note!=null?Container(
            margin: EdgeInsets.only(left: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    "Catatan",
                    style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 0.5,
                        fontFamily: "Roboto-medium",
                        fontSize: 15),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 100,
                      child:  Text(
                        "${widget.note}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          letterSpacing: 0.5,

                        ))),
                  ],
                )
              ],
            ),
          ):Container()
        ],
      ),
    );
  }


  Widget _buildTime() {
    return Container(
      margin: EdgeInsets.only(left: 5),
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    "Waktu",
                    style: titleAbsence,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text(
                    _time.toString(),
                    style: subtitleAbsence,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildgridtext() {
    return Container(
      height: 20,
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        primary: true,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          //photos
          Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                "Foto",
                style: TextStyle(
                    color: blackColor,
                    fontFamily: "Roboto-medium",
                    fontSize: 15),
              )),
          //map

          InkWell(
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => Maps(
              //           latitude: widget.latitude,
              //           longitude: widget.longitude,
              //           departement_name: widget.work_placement,
              //           address: _currentAddress,
              //           profile_background: "",
              //           firts_name: widget.firts_name_employee,
              //           last_name: widget.last_name_employee,
              //           latmainoffice: widget.office_latitude,
              //           longMainoffice: widget.office_longitude,
              //         )));
            },
            child: Container(
              margin: EdgeInsets.only(right: 10, left: 10),
              child: Text(
                "Lokasi",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: "Roboto-medium"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildgrid() {
    return Container(
      height: 200,
      child: GridView.count(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        primary: true,
        crossAxisCount: 2,
        children: <Widget>[
          // photos
          Container(
            child: _buildphotos(),
          ),
          //map
          Container(
              margin: EdgeInsets.only(right: 10, left: 10), child: _builmap()),
        ],
      ),
    );
  }

  Widget _builmap() {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => Maps(
        //           latitude: widget.latitude,
        //           longitude: widget.longitude,
        //           departement_name: widget.work_placement,
        //           address: _currentAddress,
        //           profile_background: "",
        //           firts_name: widget.firts_name_employee,
        //           last_name: widget.last_name_employee,
        //           latmainoffice: widget.office_latitude,
        //           longMainoffice: widget.office_longitude,
        //         )));
      },
      child: InkWell(
        onTap: () {
          print("tes");
        },
        child: Container(

            child: SizedBox(
              width: 300.0,
              height: 300.0,
              child: Stack(
                children: [
                  GoogleMap(
                      initialCameraPosition: CameraPosition(
                          target: LatLng(double.parse(widget.latitude),
                              double.parse(widget.longitude)),
                          zoom: 11.0),
                      markers: Set<Marker>.of(<Marker>[
                        Marker(
                          markerId: MarkerId("1"),
                          position: LatLng(double.parse(widget.latitude),
                              double.parse(widget.longitude)),
                        ),
                      ]),
                      gestureRecognizers:
                      <Factory<OneSequenceGestureRecognizer>>[
                        Factory<OneSequenceGestureRecognizer>(
                              () => ScaleGestureRecognizer(),
                        ),
                      ].toSet()),
                  InkWell(
                    onTap: () {
                      print(widget.longitude);
                      print(widget.latitude);
                      print(widget.office_latitude);
                      print(widget.office_longitude);

                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: MapsDetail(
                                latitude: widget.latitude,
                                longitude: widget.longitude,
                                departement_name: "1",
                                address: _currentAddress,
                                profile_background: null,
                                firts_name: widget.firts_name_employee,
                                last_name: "1",
                                office_latitude: widget.office_latitude,
                                office_longitude:  widget.office_longitude,

                              )));
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => Maps(
                      //           latitude: widget.latitude,
                      //           longitude: widget.longitude,
                      //           departement_name: "1",
                      //           address: _currentAddress,
                      //           profile_background: "",
                      //           firts_name: widget.firts_name_employee,
                      //           last_name: "1",
                      //           latmainoffice: widget.office_latitude,
                      //           longMainoffice: widget.office_longitude,
                      //         )));
                    },
                    child: Container(
                      width: 300,
                      height: 200,
                      color: Colors.transparent,
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }

  // Widget _builmap() {
  //   return InkWell(
  //     onTap: () {
  //       Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //               builder: (context) => Maps(
  //                     latitude: widget.latitude,
  //                     longitude: widget.longitude,
  //                     departement_name: widget.work_placement,
  //                     address: _currentAddress,
  //                     profile_background: "",
  //                     firts_name: widget.firts_name_employee,
  //                     last_name: widget.last_name_employee,
  //                     latmainoffice: widget.office_latitude,
  //                     longMainoffice: widget.office_longitude,
  //                   )));
  //     },
  //     child: InkWell(
  //       onTap: () {},
  //       child: Container(
  //           color: Colors.redAccent,
  //           child: SizedBox(
  //             width: 300.0,
  //             height: 300.0,
  //             child: Stack(
  //               children: [
  //                 MapboxMap(
  //                   accessToken:
  //                       "pk.eyJ1Ijoia2l0dG9rYXR0byIsImEiOiJja2t5eTducm4wYmhwMnFwNXI4ejA4cGhuIn0.xoSKS41bJtuetZ8v5p_aiQ",
  //                   onMapCreated: _onMapCreated,
  //                   onStyleLoadedCallback: () {
  //                     mapController!.addSymbol(SymbolOptions(
  //                         geometry: LatLng(double.parse(widget.latitude),
  //                             double.parse(widget.longitude)),
  //                         textField: "",
  //                         iconImage: "assetImageEmployee",
  //                         iconSize: 0.5,
  //                         textOffset: Offset(0, 2)));
  //                   },
  //                   initialCameraPosition: CameraPosition(
  //                       target: LatLng(double.parse(widget.latitude),
  //                           double.parse(widget.longitude)),
  //                       zoom: 15),
  //                 ),
  //                 InkWell(
  //                   onTap: () {
  //                     // print(_currentAddress);
  //                     // Navigator.push(
  //                     //     context,
  //                     //     MaterialPageRoute(
  //                     //         builder: (context) => MapsDetail(
  //                     //           latitude: widget.latitude,
  //                     //           longitude: widget.longitude,
  //                     //           departement_name: widget.work_placement,
  //                     //           address: _currentAddress,
  //                     //           profile_background: "",
  //                     //           firts_name: widget.firts_name_employee,
  //                     //           last_name: widget.last_name_employee,
  //                     //           office_latitude: widget.office_latitude,
  //                     //           office_longitude: widget.office_longitude,
  //                     //         )));
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
  //     ),
  //   );
  // }

  Widget _buildphotos() {
    return Hero(
        tag: "avatar-1",
        child: Container(
            margin: EdgeInsets.only(left: 10),
            color: Colors.black87,
            height: double.infinity,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PhotoViewPage(
                            image: widget.image,
                          )),
                );
              },
              child: widget.image == null
                  ? Image.asset(
                      "assets/absen.jpeg",
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.fill,
                    )
                  : CachedNetworkImage(
                      imageUrl: "${image_ur}/${widget.image}",
                      fit: BoxFit.fill,
                      placeholder: (context, url) =>
                          Center(child: new CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          new Icon(Icons.error),
                    ),
            )));
  }

  Widget _buildrejected() {
    return Container(
        child: _category == true
            ? Column(
                children: <Widget>[
                  Container(
                    color: Colors.redAccent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.redAccent,
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 2),
                          child: Text(
                            "REJECTED",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _buildrejectedby(),
                  Divider(
                    color: Colors.black12,
                  ),
                  _buildrejecteddate(),
                  Divider(
                    color: Colors.black12,
                  ),
                  // _buildrejectedon(),
                  _buildrejectednote(),
                  Divider(
                    color: Colors.black12,
                  ),
                ],
              )
            : Text(""));
  }

  Widget _buildrejectedby() {
    return Container(
      margin: EdgeInsets.only(left: 5),
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    "Ditolak oleh",
                    style: titleAbsence,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text(
                    "${widget.rejected_by}",
                    style: subtitleAbsence,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildrejecteddate() {
    return Container(
      margin: EdgeInsets.only(left: 5),
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    "Ditolak pada",
                    style: titleAbsence,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 100,
                  child: Text(
                    "${widget.rejected_on}",
                    style: subtitleAbsence,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // void _onMapCreated(MapboxMapController controller) async {
  //   mapController = controller;
  //   _onStyleLoaded();
  // }

  // Future<void> addImageFromAsset(String name, String assetName) async {
  //   final ByteData bytes = await rootBundle.load(assetName);
  //   final Uint8List list = bytes.buffer.asUint8List();
  //   return mapController!.addImage(name, list);
  // }

  // void _onStyleLoaded() {
  //   addImageFromAsset("assetImage", "assets/office.png");
  //   addImageFromAsset("assetImageEmployee", "assets/emplyee_maps.png");
  // }

  Widget _buildrejectedon() {
    return Container(
      margin: EdgeInsets.only(left: 5),
      width: double.infinity,
      child: Card(
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(
                      "Rejected On",
                      style: titleAbsence,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Text(
                      "${widget.rejected_on}",
                      style: subtitleAbsence,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildrejectednote() {
    return Container(
      margin: EdgeInsets.only(left: 5),
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    "Catatan",
                    style: titleAbsence,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 100,
                  child: widget.rejection_note == null
                      ? Text(
                          "-",
                          style: subtitleAbsence,
                        )
                      : Text(
                          "${widget.rejection_note} ",
                          style: subtitleAbsence,
                        ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  ///approved
  Widget _buildapproved() {
    return Container(
        child: _category == true
            ? Column(
                children: <Widget>[
                  Container(
                    color: Colors.green,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.green,
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 2),
                          child: Text(
                            "APPROVED",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _buildapprovedby(),
                  Divider(
                    color: Colors.black12,
                  ),
                  _buildapproveddate(),
                  Divider(
                    color: Colors.black12,
                  ),
                  //  _buildapprovedon(),
                  _buildapprovalnote(),
                  Divider(
                    color: Colors.black12,
                  ),
                ],
              )
            : Text(""));
  }

  Widget _buildapprovedby() {
    return Container(
      margin: EdgeInsets.only(left: 5),
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    "Disetujui oleh ",
                    style: titleAbsence,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 100,
                  child: Text(
                    "${widget.approved_by}",
                    style: subtitleAbsence,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildapproveddate() {
    return Container(
      margin: EdgeInsets.only(left: 5),
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    "Disetujui pada",
                    style: titleAbsence,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 100,
                  child: Text(
                    "${widget.approved_on}",
                    style: subtitleAbsence,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildapprovedon() {
    return Container(
      margin: EdgeInsets.only(left: 5),
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    "Approved On",
                    style: titleAbsence,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text(
                    "${widget.approved_on}",
                    style: subtitleAbsence,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildapprovalnote() {
    return Container(
      margin: EdgeInsets.only(left: 5),
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    "catatan",
                    style: titleAbsence,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 100,
                  child: widget.approval_note == null
                      ? Text(
                          "-",
                          style: subtitleAbsence,
                        )
                      : Text(
                          "${widget.approval_note}",
                          style: subtitleAbsence,
                        ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    print(widget.latitude);
    // TODO: implement initState
    super.initState();
    _getAddressFromLatLng();
    var waktu = Waktu();
    print(waktu.yMMMMEEEEd());

    _time = widget.time;
    _date = widget.date;
    print("image ${widget.image}");
    if ((widget.category == "present") || (widget.category == "present")) {
      _category = false;
    } else {
      _category = true;
    }
  }
}
