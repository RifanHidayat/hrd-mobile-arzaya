import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:magentahrdios/pages/employee/attendances/map.dart';
import 'package:magentahrdios/services/api_clien.dart';
import 'package:magentahrdios/utalities/alert_dialog.dart';
import 'package:magentahrdios/utalities/color.dart';
import 'package:magentahrdios/utalities/fonts.dart';
import 'package:magentahrdios/vaidasi/validator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class CheckinPage extends StatefulWidget {
  @override
  _CheckinPageState createState() => _CheckinPageState();
}

class _CheckinPageState extends State<CheckinPage> {
  ///variable
  File? _image;
  Map? _employee;
  bool _isLoading = true;
  bool _loading_image = true;
  bool _disposed = false;


  // final Geolocator geolocator = Geolocator()..forceAndroidLocationManag;
  Position? _currentPosition;
  String? _currentAddress;
  var Cremark = new TextEditingController();
  var time,
      _lat,
      _long,
      _employee_id,
      _check_in,
      _category_absent,
      _firts_name,
      _last_name,
      _profile_background,
      _gender,
      _departement_name,
      _lat_mainoffice,
      _long_mainoffice;
  String? base64;
  Validasi validator = new Validasi();
  double _distance = 0.0;

  ///main context
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
          "Checkin",
          style: TextStyle(
              color: Colors.white,
              fontFamily: "Roboto-medium",
              fontSize: 18,
              letterSpacing: 0.5),
        ),
      ),
      body: _isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                color: baseColor1,
              ),
            )
          : SingleChildScrollView(
              child: Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height + 50,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child:
                            _distance > 20 ? _builddistaceCompany() : Text(""),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        child: _image == null
                            ? _buildPhoto()
                            : InkWell(
                                onTap: () {
                                  aksesCamera();
                                },
                                child: Image.file(_image!,
                                    width: 200, height: 200, fit: BoxFit.fill),
                              ),
                      ),
                      _buildText(),
                      SizedBox(
                        height: 15,
                      ),
                      _buildCategoryabsence(),
                      SizedBox(
                        height: 15,
                      ),
                      _buildLocation(),
                      SizedBox(
                        height: 20,
                      ),
                      _buildremark(),
                      SizedBox(
                        height: 10,
                      ),
                      _buildtime(),
                    //  _buildCategoryabsence(),
                      Expanded(
                        child: Container(

                          width: double.infinity,
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              _buildfingerprint(),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  ///widge widget
  //Widger photo default
  Widget _buildPhoto() {
    return Container(
      child: InkWell(
        onTap: () {
          aksesCamera();
        },
        child: Container(
          margin: EdgeInsets.only(top: 15),
          child: Image.asset("assets/photo.png",
              width: 200, height: 200, fit: BoxFit.fill),
        ),
      ),
    );
  }

  // -------end photo default-----
  //Widget text
  Widget _buildText() {
    return Container(
      child: Container(
        margin: EdgeInsets.all(15.0),
        child: Text(
          "Take Your Photo",
          style: TextStyle(fontSize: 20, color: Colors.black.withOpacity(0.2),fontFamily: "Roboto-medium",letterSpacing: 0.5),
        ),
      ),
    );
  }

  //build remark
  Widget _buildremark() {
    return Container(
      margin: EdgeInsets.only(left: 40, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Catatan",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Roboto-mdium",
                  letterSpacing: 0.5)),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: Cremark,
            maxLines: 3,
            cursorColor: Theme.of(context).cursorColor,
            maxLength: 100,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(5.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(width: 0, color: Colors.red),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: baseColor, width: 2.0),
                borderRadius: BorderRadius.circular(5.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: blackColor.withOpacity(0.5), width: 1.0),
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _startJam() {
    Timer.periodic(new Duration(seconds: 1), (_) {
      var tgl = new DateTime.now();
      var formatedjam = new DateFormat.Hms().format(tgl);
      if (!_disposed) {
        setState(() {
          time = formatedjam;
          // _getCurrentLocation();
          _getDistance(_lat_mainoffice, _long_mainoffice, _lat, _long);
        });
      }
    });
  }

  Widget _buildtime() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: 20,
          margin: EdgeInsets.only(left: 25),
          child: TextFormField(
            enabled: false,
            cursorColor: Theme.of(context).cursorColor,
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              icon: Icon(
                Icons.timer,
                color: Colors.black,
                size: 30,
              ),
              labelText: '$time',
              labelStyle: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontFamily: "Roboto-regular",
                  letterSpacing: 0.5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryabsence() {
    return Container(
      margin: EdgeInsets.only(left: 25, right: 25),
      width: double.maxFinite,
      padding: const EdgeInsets.all(0.0),
      child: Row(
        children: [
          Container(
            child: Icon(
              Icons.merge_type,
              color: Colors.black12,
              size: 30,
            ),
          ),
          Expanded(
            child: Container(
              width: double.maxFinite,
              margin: EdgeInsets.only(left: 10),
              child: DropdownButton<String>(
                isExpanded: true,

                value: _category_absent,
                //elevation: 5,
                style: TextStyle(color: Colors.black),

                items: <String>[
                  'Kantor',
                  'Perdin',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                hint: Text(
                  "Kantor",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                onChanged: (String? value) {
                  setState(() {
                    print("${value}");
                    _category_absent = value;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocation() {
    return Container(
      margin: EdgeInsets.only(left: 25),
      //Row for time n location
      child: Row(
        children: <Widget>[
          //container  icon location
          Container(
            child: Row(
              children: <Widget>[
                // Container(
                //   child: Icon(
                //     Icons.location_on,
                //     color: Colors.black12,
                //     size: 30,
                //   ),
                // ),
                //container for name location
                InkWell(
                  onTap: () {
                    // print(_long_mainoffice);
                    // print(_lat_mainoffice);

                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: Maps(
                              address: _currentAddress,
                              longitude: _long,
                              latitude: _lat,
                              firts_name: _firts_name,
                              last_name: _last_name,
                              profile_background: _profile_background,
                              gender: _gender,
                              departement_name: _departement_name,
                              distance: _distance,
                              latmainoffice: _lat_mainoffice,
                              longMainoffice: _long_mainoffice,
                            )));

                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => Maps(
                    //               address: _currentAddress,
                    //               longitude: _long,
                    //               latitude: _lat,
                    //               firts_name: _firts_name,
                    //               last_name: _last_name,
                    //               profile_background: _profile_background,
                    //               gender: _gender,
                    //               departement_name: _departement_name,
                    //               distance: _distance,
                    //               latmainoffice: _lat_mainoffice,
                    //               longMainoffice: _long_mainoffice,
                    //             )));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Lokasi",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Roboto-mdium",
                                letterSpacing: 0.5)),
                        SizedBox(
                          height: 10,
                        ),
                        if (_currentPosition != null && _currentAddress != null)
                          Container(
                            width: Get.mediaQuery.size.width / 2 + 50,
                            child: Text(
                              "$_currentAddress",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontFamily: "Roboto-regular",
                                  letterSpacing: 0.5,
                                  fontSize: 13),
                            ),
                          ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  //Widger photo
  Widget _buildfingerprint() {
    return InkWell(
      onTap: () {
        upload();
      },
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20),

        width: Get.mediaQuery.size.width,

        child: ElevatedButton(
            onPressed: () {
              upload();
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(baseColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              )),
            ),
            child: const Text(
              "Checkin",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: "Roboto-regular"),
            )),
        // child: Card(
        //   color: baseColor,
        //
        //   elevation: 1,
        //   shape: RoundedRectangleBorder(
        //
        //     borderRadius: BorderRadius.circular(30.0),
        //   ),
        //   child: Container(
        //     margin: EdgeInsets.all(15.0),
        //     child: Image.asset(
        //       "assets/fingerprint.png",
        //     ),
        //   ),
        // ),
      ),
    );
  }

  Future upload() async {
    var date = DateFormat("yyyy:MM:dd").format(DateTime.now());
    if (_category_absent == null) {
      _category_absent = "Kantor";
    }

    validation_checkin(
        context,
        base64.toString(),
        Cremark.text,
        _lat.toString(),
        _long.toString(),
        _employee_id,
        date,
        time,
        _departement_name,
        _distance,
        _lat_mainoffice,
        _long_mainoffice,
        _category_absent,
        "present");
    // if (_category_absent.toString().toLowerCase() != 'present') {
    //   if (base64.toString() == "null") {
    //     Toast.show("Foto wajib digunakan", context,
    //         duration: 5, gravity: Toast.BOTTOM);
    //   } else if (Cremark.text.toString().isEmpty) {
    //     Toast.show("Remarks tidak boleh kosong", context,
    //         duration: 5, gravity: Toast.BOTTOM);
    //   } else {
    //     //Toast.show("$_category_absent", context);
    //     validation_checkin(
    //         context,
    //         base64.toString(),
    //         Cremark.text,
    //         _lat.toString(),
    //         _long.toString(),
    //         _employee_id,
    //         date,
    //         time,
    //         _departement_name,
    //         _distance,
    //         _lat_mainoffice,
    //         _long_mainoffice,
    //         "present");
    //   }
    // } else {
    //   validation_checkin(
    //       context,
    //       base64.toString(),
    //       Cremark.text,
    //       _lat.toString(),
    //       _long.toString(),
    //       _employee_id,
    //       date,
    //       time,
    //       _departement_name,
    //       _distance,
    //       _lat_mainoffice,
    //       _long_mainoffice,
    //       _category_absent.toString().toLowerCase());
    // }
  }

  ///fucntion
  //akses kamera
  aksesCamera() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      var f = await image.readAsBytes();
      setState(() {
        _image = File(image.path);
        base64 = base64Encode(f);
      });
    } else {
      toast_success("No file selected");
    }
  }

  Widget _builddistaceCompany() {
    return Container(
      color: baseColor1.withOpacity(0.4),
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10, right: 20, top: 5, bottom: 5),
            child: Icon(
              Icons.info,
              color: blackColor,
            ),
          ),
          Container(
              child: Text(
            "Anda  berada di luar area kantor",
            style: TextStyle(
                color: blackColor,
                fontFamily: "Roboto-regular",
                letterSpacing: 0.5),
          ))
        ],
      ),
    );
  }

  //get curret locatin lat dan long
  _getCurrentLocation() {
    Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _lat = _currentPosition!.latitude;
        _long = _currentPosition!.longitude;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  //convert lat dan long to address
  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await Geolocator().placemarkFromCoordinates(
          _currentPosition?.latitude, _currentPosition?.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  _getDataPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      _employee_id = sharedPreferences.getString("user_id");

      dataEmployee(_employee_id.toString());
    });
  }

  /**/
  _getDistance(latMainoffice, longMainoffice, currentlat, currentlong) async {
    try {
      _distance = 0;
      final double d = await Geolocator().distanceBetween(
          double.parse(latMainoffice),
          double.parse(longMainoffice),
          currentlat,
          currentlong);
      setState(() {
        _distance = d;
        print("$d");
        // print(d);
      });
    } catch (e) {
      print(e);
    }
  }



  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void initState() {
    // BitmapDescriptor.fromAssetImage(
    //         ImageConfiguration(devicePixelRatio: 2.5), 'assets/office.png')
    //     .then((onValue) {
    //   pinCompany = onValue;
    // });
    super.initState();
    _getCurrentLocation();
    _startJam();
    _getDataPref();
  }

  Future dataEmployee(var id) async {
    try {
      setState(() {
        _isLoading = true;
      });
      http.Response response =
          await http.get(Uri.parse("$base_url/api/employees/$id"));
      _employee = jsonDecode(response.body);

      setState(() {
        _departement_name = _employee!['data']['work_placement'];

        _gender = _employee!['data']['gender'];
        // _last_name = _employee['data']['last_name'];
        _profile_background = _employee!['data']['photo'];
        _firts_name = _employee!['data']['first_name'];
        _lat_mainoffice = _employee!['data']['location']['latitude'];
        _long_mainoffice = _employee!['data']['location']['longitude'];

        // print(_lat_mainoffice);

        _isLoading = false;
      });

      setState(() {
        _getCurrentLocation();
        _getDistance(_lat_mainoffice, _long_mainoffice, _lat, _long);
      });
    } catch (e) {}
  }


}
