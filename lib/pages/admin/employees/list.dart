import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:magentahrdios/pages/employee/account/profile.dart';
import 'package:magentahrdios/services/api_clien.dart';
import 'package:magentahrdios/utalities/color.dart';
import 'package:page_transition/page_transition.dart';

class ListEmployee extends StatefulWidget {
  @override
  _ListEmployeeState createState() => _ListEmployeeState();
}

class _ListEmployeeState extends State<ListEmployee> {
  ///widget
  Map? _employee;
  bool? _isLoading;
  List _employees = [];

  Widget _buildemployees(index) {
    return InkWell(
      onTap: () {
        // Get.to(DetailProfile(
        //   id: _employees[index]['id'],
        // ));
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft,
                child: DetailProfile(
                    id: _employee!['data'][index]['id']
                )));
      },
      child: Container(
        margin: EdgeInsets.only(left: 5, top: 15),
        child: Row(
          children: <Widget>[
            _employees[index]['photo'] != null
                ? Container(
              child: CircleAvatar(
                backgroundColor: Colors.black.withOpacity(0.2),
                radius: 30,
                backgroundImage: NetworkImage(
                    "${image_ur}/${_employees[index]['photo']}"),
              ),
            )
                : Container(
                child: Image.asset(
                  "assets/profile-default.png",
                  width: 60,
                  height: 60,
                )),
            // Container(
            //   child: CircleAvatar(
            //     radius: 30,
            //     backgroundImage:
            //         NetworkImage("${image_ur}/${_employees[index]['photo']}"),
            //   ),
            // ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${_employees[index]["first_name"]} ",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Roboto-medium",
                        letterSpacing: 0.5,
                        fontSize: 14),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    _employees[index]["employee_id"],
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                        fontSize: 12,
                        fontFamily: "Roboto-regular",letterSpacing: 0.5),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 100,
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Divider(
                        color: Colors.black,
                      ),
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

  Widget _listemployee() {
    return Container(
      child: Expanded(
        child: Container(
          child: _isLoading == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: _employees.length,
                  itemBuilder: (context, index) {
                    return _employees[index]['mobile_access_type'] != "admin"
                        ? _buildemployees(index)
                        : Text("");
                  }),
        ),
      ),
    );
  }

  ///faunction
  _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
          decoration: InputDecoration(hintText: 'Search...'),
          onChanged: (text) {
            _employees = _employee!['data'];
            setState(() {
              _employees = _employees.where((data) {
                var noteTitle = data['first_name'].toLowerCase();
                return noteTitle.contains(text);
              }).toList();
            });
          }),
    );
  }

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
          "Karyawan",
          style: TextStyle(
              color: Colors.white,
              fontFamily: "Roboto-medium",
              fontSize: 18,
              letterSpacing: 0.5),
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            // Container(
            //   width: double.infinity,
            //   height: 150,
            //   color: Colors.redAccent[100],
            // ),
            _searchBar(),
            _listemployee()
          ],
        ),
      ),
    );
  }

  //ge data from api--------------------------------
  Future dataEmployee() async {
    try {
      setState(() {
        _isLoading = true;
      });
      http.Response response =
          await http.get(Uri.parse("$base_url/api/employees"));
      _employee = jsonDecode(response.body);
      _employees = _employee!['data'];
      // var data= _employee['data'].wher((data) => data["first_name"].toString().contains("Panut")
      // ).toList();
      // print(data);

      setState(() {
        _isLoading = false;
      });
    } catch (e) {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataEmployee();
  }
}
