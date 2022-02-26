import 'dart:html';


import 'package:flutter/material.dart';

import 'package:js/js.dart';
import 'package:magentahrdios/pages/employee/location/utalities/alert.dart';
import 'package:magentahrdios/pages/employee/location/utalities/api.dart';
import 'package:magentahrdios/pages/employee/location/utalities/constants.dart';
import 'package:magentahrdios/pages/employee/location/utalities/helper.dart';
import 'package:magentahrdios/pages/employee/location/widget/customer_scaffold.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({ Key? key}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  double _latitude = 0.0;
  double _longitude = 0.0;
  String _city = '';

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
        body: Center(

          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              OutlinedButton(
                onPressed: () => alert('Hello!! from JS'),
                child: const Text('Alert in Flutter Web'),
              ),
              OutlinedButton(
                onPressed: () {
                  // getCurrentPosition(allowInterop((pos) {
                  //   setState(() {
                  //     _latitude = pos.coords.latitude;
                  //     _longitude = pos.coords.longitude;
                  //   });
                  // }));
                  getCurrentPosition(allowInterop((pos){
                    setState(() {
                          _latitude = pos.coords.latitude;
                          _longitude = pos.coords.longitude;

                    });

                  }));
                },
                child: const Text('Mozilla GeoLocation'),
              ),
              Text('LAT : $_latitude'),
              Text('LONG : $_longitude'),
              OutlinedButton(
                onPressed: () async {
                  final _val = await LocationAPI().fetchData();
                  setState(() => _city = _val);
                },
                child: const Text('Location from API'),
              ),
              Text('CITY : $_city'),
            ],
          ),
        )
    );
  }
}