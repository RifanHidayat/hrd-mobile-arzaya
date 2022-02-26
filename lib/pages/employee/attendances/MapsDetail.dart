import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:magentahrdios/models/map.dart';
import 'package:magentahrdios/services/api_clien.dart';
import 'package:magentahrdios/utalities/color.dart';
import 'package:magentahrdios/utalities/constants.dart';
import 'package:magentahrdios/utalities/fonts.dart';

import 'package:permission_handler/permission_handler.dart';

class MapsDetail extends StatefulWidget {
  @override
  _MapsDetailState createState() => _MapsDetailState();

  MapsDetail(
      {this.address,
      this.longitude,
      this.latitude,
      this.gender,
      this.last_name,
      this.firts_name,
      this.profile_background,
      this.office_latitude,
      this.office_longitude,
      this.departement_name});

  var address,
      latitude,
      longitude,
      gender,
      firts_name,
      last_name,
      profile_background,
      distance,
      office_latitude,
      office_longitude,
      departement_name;
}

class _MapsDetailState extends State<MapsDetail> {
  GoogleMapController? _controller;
  Position? position;
  BitmapDescriptor? companyIcon;
  BitmapDescriptor? _markerIcon;
  Set<Circle> _circles = HashSet<Circle>();

  Widget _child = Center(
    child: Text('Loading...'),
  );
  BitmapDescriptor? _sourceIcon;

  double _pinPillPosition = -100;

  PinData _currentPinData = PinData(
      pinPath: '',
      avatarPath: '',
      location: LatLng(0, 0),
      locationName: '',
      labelColor: Colors.grey);

  PinData? _sourcePinInfo;

  Future<void> getPermission() async {
    // PermissionStatus permission = await PermissionHandler()
    //     .checkPermissionStatus(PermissionGroup.location);
    //
    // if (permission == PermissionStatus.denied) {
    //   await PermissionHandler()
    //       .requestPermissions([PermissionGroup.locationAlways]);
    // }

    var geolocator = Geolocator();

    GeolocationStatus geolocationStatus =
        await geolocator.checkGeolocationPermissionStatus();

    switch (geolocationStatus) {
      case GeolocationStatus.denied:
        showToast('Access denied');
        break;
      case GeolocationStatus.disabled:
        showToast('Disabled');
        break;
      case GeolocationStatus.restricted:
        showToast('restricted');
        break;
      case GeolocationStatus.unknown:
        showToast('Unknown');
        break;
      case GeolocationStatus.granted:
        showToast('Accesss Granted');
        _getCurrentLocation();
    }
  }

  void _getCurrentLocation() async {
    Position res = await Geolocator().getCurrentPosition();
    setState(() {
      position = res;
      _child = _mapWidget();
    });
  }

  Set<Marker> _createMarker() {
    return <Marker>[
      ///company marker
      Marker(
          markerId: MarkerId('company'),
          position: LatLng(double.parse(widget.office_latitude),
              double.parse(widget.office_longitude)),
          // icon: BitmapDescriptor.fromAsset("assets/office.png")
          icon:_markerIcon!),

      ///user marker
      Marker(
          markerId: MarkerId('user'),
          position: LatLng(
              double.parse(widget.latitude), double.parse(widget.longitude)),
          // icon: BitmapDescriptor.fromAsset("assets/emplyee_maps.png")
          icon: BitmapDescriptor.defaultMarker),
    ].toSet();
  }
  Future<void> _createMarkerImageFromAsset(BuildContext context) async {
    if (_markerIcon == null) {
      final ImageConfiguration imageConfiguration =
      createLocalImageConfiguration(context, size: Size.square(48));
      BitmapDescriptor.fromAssetImage(
          imageConfiguration, 'assets/office.png')
          .then(_updateBitmap);
    }
  }
  void _updateBitmap(BitmapDescriptor bitmap) {
    setState(() {
      _markerIcon = bitmap;
    });
  }


  ///set raidus
  Set<Circle> circles = Set.from([
    Circle(
        circleId: CircleId("1"),
        center: LatLng(-6.9529516, 107.6684227),
        radius: 20,
        strokeColor: baseColor,
        fillColor: baseColor.withOpacity(0.25),
        strokeWidth: 1)
  ]);

  void showToast(message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        // timeInSecForIos: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void setSourceAndDestinationIcons() async {
    companyIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/home.png');
  }

  ///style map json
  void _setStyle(GoogleMapController controller) async {
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');

    controller.setMapStyle(value);
  }

  Widget _mapWidget() {
    return GoogleMap(
      mapType: MapType.normal,
      markers: _createMarker(),
      initialCameraPosition: CameraPosition(
          target: LatLng(
              double.parse(widget.latitude), double.parse(widget.longitude)),
          zoom: 16.0),
      onMapCreated: (GoogleMapController controller) {
        _controller = controller;
        // _setStyle(controller);

        // _setStyle(controller);
      },
      tiltGesturesEnabled: false,
      onTap: (LatLng location) {
        setState(() {
          _pinPillPosition = -100;
        });
      },
      onCameraMove: null,
      circles: _circles,
    );
  }

  @override
  Widget build(BuildContext context) {
    _createMarkerImageFromAsset(context);
    return Scaffold(
        body: Stack(
      children: <Widget>[
        _child,
        AnimatedPositioned(
          bottom: _pinPillPosition,
          right: 0,
          left: 0,
          duration: Duration(milliseconds: 200),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.all(20),
              height: 70,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      blurRadius: 20,
                      offset: Offset.zero,
                      color: Colors.grey.withOpacity(0.5),
                    )
                  ]),
            ),
          ),
        ),
        new Positioned(
            top: MediaQuery.of(context).size.height * 0.6,
            child: new Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(5.0),
                      topRight: const Radius.circular(5.0),
                    )),
                child: _info()))
      ],
    ));
  }

  Widget _info() {
    return Container(
      child: Container(
        child: Column(
          children: <Widget>[
            ///widget profile
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: widget.profile_background != null
                          ? CircleAvatar(
                              radius: 30.0,
                              backgroundImage: NetworkImage(
                                  "${image_ur}/${widget.profile_background}"),
                              backgroundColor: Colors.transparent,
                            )
                          : Image.asset(
                              "assets/profile-default.png",
                              width: 70,
                              height: 70,
                            )),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 60,
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            "${widget.firts_name}",
                            style: TextStyle(
                              fontSize: 15,
                              letterSpacing: 0.5,
                              fontFamily: "Roboto-medium",
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Text(
                            "",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black38,
                            ),
                          ),
                        ),

                        //detail acount
                      ],
                    ),
                  ) //Container
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 25, top: 30),
              //Row for time n location
              child: Row(
                children: <Widget>[
                  //container  icon location
                  Container(
                    child: Row(
                      children: <Widget>[
                        //container for name location
                        InkWell(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Alamat",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Roboto-medium",
                                        fontSize: 15,
                                        letterSpacing: 0.5)),
                                SizedBox(
                                  height: 10,
                                ),
                                if (widget.address != null &&
                                    widget.address != null)
                                  Container(
                                    width: Get.mediaQuery.size.width / 2 + 40,
                                    child: Text(
                                      widget.address,
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.5),
                                          fontSize: 13,
                                          fontFamily: "Roboto-regular",
                                          letterSpacing: 0.5),
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
            ),

            ///widget location
          ],
        ),
      ),
    );
  }

  void _setCircles() {
    _circles.add(
      Circle(
          circleId: CircleId("0"),
          center: LatLng(double.parse(widget.office_latitude),
              double.parse(widget.office_longitude)),
          // center: LatLng(double.parse(widget.latmainoffice),
          //     double.parse(widget.longMainoffice)),
          radius: 20,
          strokeColor: baseColor1,
          fillColor: baseColor.withOpacity(0.25),
          strokeWidth: 1),
    );
  }

  @override
  void initState() {
    getPermission();
    // _setSourceIcon();
    super.initState();
    _setCircles();
  }
}
