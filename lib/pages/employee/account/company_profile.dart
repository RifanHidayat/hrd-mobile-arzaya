import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:magentahrdios/services/api_clien.dart';
import 'package:magentahrdios/utalities/color.dart';
import 'package:toast/toast.dart';

class company_pfrofile extends StatefulWidget {
  company_pfrofile({this.id});

  var id;

  @override
  _company_pfrofileState createState() => _company_pfrofileState();
}

class _company_pfrofileState extends State<company_pfrofile> {
  Services services = new Services();
  var company_name, company_adress, company_phonenumber, company_email;
  bool? _isLoading;

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
          "Perusahaan",
          style: TextStyle(
              color: Colors.white,
              fontFamily: "Roboto-medium",
              fontSize: 18,
              letterSpacing: 0.5),
        ),
      ),
      body: _isLoading == true
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            _buildname(),
            _buildtelp(),
            _buildemail(),
            _buildadress()
          ],
        ),
      ),
    );
  }

//wodget name company
  Widget _buildname() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          //row company profile
          Container(
            child: Row(
              children: <Widget>[
                //container icon
                Container(
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 30,
                    child: Icon(
                      Icons.home_work,
                      color: Colors.black38,
                      size: 25,
                    ),
                  ),
                ),

                //container text componey profile
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Perusahaan",
                          style: TextStyle(
                              fontFamily: "SFReguler",
                              fontSize: 14,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: company_name == null
                              ? Text("-")
                              : Text(
                            company_name,
                            style: TextStyle(
                              fontFamily: "SFReguler",
                              fontSize: 14,
                              color: Colors.black38,
                            ),
                          ),
                        )
                      ],
                    )),
              ],
            ),
          ),
          new Divider(
            color: Colors.black12,
          ),
        ],
      ),
    );
  }

  //wodget about
  Widget _buildtelp() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          //row company profile
          Container(
            child: Row(
              children: <Widget>[
                //container icon
                Container(
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 30,
                    child: Icon(
                      Icons.phone,
                      color: Colors.black38,
                      size: 25,
                    ),
                  ),
                ),

                //container text componey profile
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Nomor telfon",
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: "SFReguler",
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: company_phonenumber == null
                              ? Text("-")
                              : Text(
                            company_phonenumber,
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: "SFReguler",
                              color: Colors.black38,
                            ),
                          ),
                        )
                      ],
                    )),
              ],
            ),
          ),
          new Divider(
            color: Colors.black12,
          ),
        ],
      ),
    );
  } //wodget about

  Widget _buildemail() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          //row company profile
          Container(
            child: Row(
              children: <Widget>[
                //container icon
                Container(
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 30,
                    child: Icon(
                      Icons.email,
                      color: Colors.black38,
                      size: 25,
                    ),
                  ),
                ),

                //container text componey profile
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Email",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,

                              fontFamily: "SFReguler",
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: company_email == null
                              ? Text("-")
                              : Text(
                            company_email,
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: "SFReguler",
                              color: Colors.black38,
                            ),
                          ),
                        )
                      ],
                    )),
              ],
            ),
          ),
          new Divider(
            color: Colors.black12,
          ),
        ],
      ),
    );
  }

  //wodget about
  Widget _buildadress() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          //row company profile
          Container(
            child: Row(
              children: <Widget>[
                //container icon
                Container(
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 30,
                    child: Icon(
                      Icons.location_on,
                      color: Colors.black38,
                      size: 25,
                    ),
                  ),
                ),

                //container text componey profile
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Alamat",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: company_adress == null
                              ? Text("-")
                              : Text(
                            company_adress,
                            style: TextStyle(
                              fontFamily: "SFReguler",
                              fontSize: 14,
                              color: Colors.black38,
                            ),
                          ),
                        )
                      ],
                    )),
              ],
            ),
          ),
          new Divider(
            color: Colors.black12,
          ),
        ],
      ),
    );
  }

  //function get employee

  ///function companies
  Future _companies(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    final response =
    await http.get(Uri.parse("$base_url/api/employees/${widget.id}/companies"));
    final data = jsonDecode(response.body);

    if (data['code'] == 200) {
      //final compaymodel = companiesFromJson(response.body);
      company_name = data['data']['name'];
      company_adress = data['data']['address'];
      company_email = data['data']['email'];
      company_phonenumber = data['data']['contact_number'];

      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _companies(context);

    // services.companies(context, "1").then((value) {
    // Toast.show("$", context)

    // });
  }
}
