import 'dart:convert';
import 'package:flutter/material.dart';


import 'package:http/http.dart' as http;
import 'package:magentahrdios/pages/employee/attendances/shimmer.dart';
import 'package:magentahrdios/services/api_clien.dart';
import 'package:magentahrdios/utalities/constants.dart';
import 'package:magentahrdios/utalities/fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class leave_status extends StatefulWidget {
  leave_status({this.type});

  var type;

  @override
  _leave_statusState createState() => _leave_statusState();
}

class _leave_statusState extends State<leave_status> {
  var user_id;

  Map? _absence;
  bool _loading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _loading
            ? Center(
          child: ShimmerAbsence(),
        )
            : ListView.builder(
          // itemCount: _budgeting['data']['cash_flow'].length,
            itemCount:
            _absence!['data'].length == 0 ? 1 : _absence!['data'].length,
            itemBuilder: (context, index) {
              return _absence!['data'].length == 0
                  ? _buildnodata()
                  : _buildlistabsence(index);
            }),

        //
      ),
    );
  }

  Widget _buildlistabsence(index) {
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 100,
          child: Card(
            elevation: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 5,
                        top: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Container(
                              width: double.infinity,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  //container text
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(),
                                  ),
                                  Flexible(
                                    child: Container(
                                      margin:
                                      EdgeInsets.only(top: 10, left: 10),
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[],
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
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

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
                  "Belum ada cuti dengan status ${widget.type}",
                  style: subtitleMainMenu,
                )),
          ],
        ),
      ),
    );
  }

  //ge data from api--------------------------------
  Future _dataAbsence(var user_id) async {
    try {
      setState(() {
        _loading = true;
      });
      http.Response response = await http.get(
          Uri.parse("$base_url/api/employees/$user_id/attendances?status=${widget.type}"));
      _absence = jsonDecode(response.body);
      setState(() {
        _loading = false;
      });
    } catch (e) {}
  }

  void getDatapref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      user_id = sharedPreferences.getString("user_id");
      _dataAbsence(user_id);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDatapref();
  }
}
