import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:magentahrdios/pages/change_password/chnage_password.dart';
import 'package:magentahrdios/pages/employee/account/company_profile.dart';
import 'package:magentahrdios/pages/employee/account/profile.dart';
import 'package:magentahrdios/services/api_clien.dart';
import 'package:magentahrdios/shared_preferenced/sessionmanage.dart';
import 'package:magentahrdios/utalities/color.dart';
import 'package:magentahrdios/utalities/constants.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AccountEmployee extends StatefulWidget {
  @override
  _AccountEmployeeState createState() => _AccountEmployeeState();
}

class _AccountEmployeeState extends State<AccountEmployee> {
  bool _detailData = false;
  bool _lessData = true;
  String? username,
      contac,
      first_name,
      last_name,
      email,
      gender,
      employee_id,
      employee_type="",
      departement_name,
      position="",
      profile_background = "";
  var user_id, value, photo;
  SharedPreference session = new SharedPreference();
  Services services = new Services();

  //text settings
  Widget _buildText() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Settings",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold)),
          new Divider(
            color: Colors.black12,
          ),
        ],
      ),
    );
  }

  Widget _buildTextacount() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Profile",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontFamily: "Roboto-medum")),
          new Divider(
            color: Colors.black12,
          ),
        ],
      ),
    );
  }

  //wodget company
  Widget _buildCompany() {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => company_pfrofile(id: user_id)));
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft,
                child: company_pfrofile(
                  id: user_id,
                )));
      },
      child: Container(
        margin: EdgeInsets.all(5),
        child: Column(
          children: [
            //row company profile
            Container(
              child: Row(
                children: <Widget>[
                  //container icon
                  Container(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 20,
                      child: Icon(
                        Icons.home_work,
                        color: baseColor,
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
                            "Profile perusahaan",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              letterSpacing: 0.5,
                              fontFamily: "Roboto-medium",
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Lihat profile perusahaan kam",
                            style: TextStyle(
                                fontSize: 11,
                                color: Colors.black.withOpacity(0.5),
                                letterSpacing: 0.5,
                                fontFamily: "Roboto-regular"),
                          )
                        ],
                      )),

                  //container arrow right
                  Flexible(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.black.withOpacity(0.3),
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            new Divider(
              color: Colors.black12,
            ),
          ],
        ),
      ),
    );
  }

  //wodget company
  Widget _buildChangepassword() {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => change_password(
        //               id: user_id,
        //               username: username,
        //               email: email,
        //             )));

        Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: change_password(
          id: user_id,
          username: username,
          email: email,
        )));
      },
      child: Container(
        margin: EdgeInsets.all(5),
        child: Column(
          children: [
            //row company profile
            Container(
              child: Row(
                children: <Widget>[
                  //container icon
                  Container(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 20,
                      child: Icon(
                        Icons.lock,
                        color: baseColor,
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
                            "Ganti Password",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              letterSpacing: 0.5,
                              fontFamily: "Roboto-medium",
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Ganti password kamu",
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.black.withOpacity(0.5),
                              letterSpacing: 0.5,
                              fontFamily: "Roboto-regular",
                            ),
                          )
                        ],
                      )),

                  //container arrow right
                  Flexible(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.black.withOpacity(0.3),
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            new Divider(
              color: Colors.black12,
            ),
          ],
        ),
      ),
    );
  }

  //wodget profile
  Widget _buildprofile() {
    return InkWell(
      onTap: () {
        // Get.to(DetailProfile(
        //   id: user_id,
        // ));
        Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: DetailProfile(id: user_id,)));
      },
      child: Container(
        margin: EdgeInsets.all(5),
        child: Column(
          children: [
            //row company profile
            Container(
              child: Row(
                children: <Widget>[
                  //container icon
                  Container(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 20,
                      child: Icon(
                        Icons.person,
                        color: baseColor,
                        size: 25,
                      ),
                    ),
                  ),

                  //container text componey profile
                  Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Profile",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              letterSpacing: 0.5,
                              fontFamily: "Roboto-medium",
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Lihat detail profile kamu",
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.black.withOpacity(0.5),
                              letterSpacing: 0.5,
                              fontFamily: "Roboto-medium",
                            ),
                          )
                        ],
                      )),

                  //container arrow right
                  Flexible(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.black.withOpacity(0.3),
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            new Divider(
              color: Colors.black12,
            ),
          ],
        ),
      ),
    );
  }

//---end profile----

  //wodget logout
  Widget _buildlogout() {
    return InkWell(
      onTap: () {
        //session.logout(context);

        _showConfirmlogout(context);
      },
      child: Container(
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
                      backgroundColor: Colors.white,
                      radius: 20,
                      child: Icon(
                        Icons.logout,
                        color: baseColor,
                        size: 25,
                      ),
                    ),
                  ),

                  //container text componey profile
                  Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Logout",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              letterSpacing: 0.5,
                              fontFamily: "Roboto-medium",
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "logout sebagai $first_name",
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.black.withOpacity(0.5),
                              letterSpacing: 0.5,
                              fontFamily: "Roboto-regular",
                            ),
                          )
                        ],
                      )),

                  //container arrow right
                  Flexible(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.black.withOpacity(0.3),
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            new Divider(
              color: Colors.black12,
            ),
          ],
        ),
      ),
    );
  }

//wodget about
  Widget _buildabout() {
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
                    backgroundColor: Colors.white,
                    radius: 20,
                    child: Icon(
                      Icons.info,
                      color: baseColor,
                      size: 25,
                    ),
                  ),
                ),

                //container text componey profile
                Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "About",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            letterSpacing: 0.5,
                            fontFamily: "Roboto-medium",
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Versi aplikasi 1.0.0",
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.black.withOpacity(0.5),
                            letterSpacing: 0.5,
                            fontFamily: "Roboto-regular",
                          ),
                        )
                      ],
                    )),

                //container arrow right
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

//-----end abut----

  //wodget username
  Widget _buildusername() {
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
                    backgroundColor: Colors.white,
                    radius: 20,
                    child: Icon(
                      Icons.person,
                      color: Colors.black38,
                      size: 25,
                    ),
                  ),
                ),

                //container text componey profile
                Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Username",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "$username",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black38,
                          ),
                        )
                      ],
                    )),
              ],
            ),
          ),
          new Divider(
            color: Colors.black38,
          ),
        ],
      ),
    );
  }

//-----end username----

  //wodget gender
  Widget _buildgender() {
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
                    backgroundColor: Colors.white,
                    radius: 20,
                    child: Icon(
                      Icons.image,
                      color: Colors.black38,
                      size: 25,
                    ),
                  ),
                ),

                //container text componey profile
                Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Gender",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: gender == 'male'
                              ? Text(
                                  "Pria",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black38,
                                  ),
                                )
                              : gender == "female"
                                  ? Text(
                                      "Wanita",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black38,
                                      ),
                                    )
                                  : Text(
                                      "-",
                                      style: TextStyle(
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
        ],
      ),
    );
  }

//-----end gender----

  //wodget username
  Widget _buildemployeeid() {
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
                    backgroundColor: Colors.white,
                    radius: 20,
                    child: Icon(
                      Icons.featured_video,
                      color: Colors.black38,
                      size: 25,
                    ),
                  ),
                ),

                Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Employee Id",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "$employee_id",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black38,
                          ),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

//-----end employee id----

  //wodget email
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
                    backgroundColor: Colors.white,
                    radius: 20,
                    child: Icon(
                      Icons.email,
                      color: Colors.black38,
                      size: 25,
                    ),
                  ),
                ),

                //container text componey profile
                Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Email",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "$email",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black38,
                          ),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

//-----end username----

  //wodget phone number
  Widget _buildphone() {
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
                    backgroundColor: Colors.white,
                    radius: 20,
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
                          "Phone",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "$contac",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black38,
                          ),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

//-----end phone number----

//main menu settings
  Widget _buildSettings() {
    return Container(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildHeader(),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Column(
                children: <Widget>[
                  _buildprofile(),
                  _buildCompany(),
                  _buildChangepassword(),
                  _buildlogout(),
                  _buildabout()
                ],
              ),
            )
          ],
        ));
  }

  //--------end settings---------

  Widget _buildHeader() {
    return Container(
      width: Get.mediaQuery.size.width,
      height: Get.mediaQuery.size.height * 0.3,
      color: baseColor,
      child: Column(
        children: <Widget>[
          photo == null
              ? Container(
                  margin: EdgeInsets.only(top: 50),
                  child: Image.asset(
                    "assets/profile-default.png",
                    width: 70,
                    height: 70,
                  ),
                )
              : Container(
                  margin: EdgeInsets.only(top: 50),
                  child: CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage("${image_ur}/${photo}"),
                  ),
                ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Text(
              "${first_name??""}",
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 0.5,
                fontSize: 15,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            child: Text(
              "${employee_id} | ${position}",
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                letterSpacing: 0.5,
                fontSize: 10,
              ),
            ),
          ),


        ],
      ),
    );
  }

  Widget _buildphoto() {
    return Container(
      margin: EdgeInsets.all(20),
      child: Row(
        children: <Widget>[
          Container(
            child: profile_background == ""
                ? CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 40,
                    child: gender == "male" ? male_avatar : female_avatar)
                : CircleAvatar(
                    radius: 40,
                    child: Icon(
                      Icons.person_pin,
                    ),
                  ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    "$first_name $last_name",
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
                    "${departement_name}",
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
    );
  }

  //main Account
  Widget _builddetailAccount() {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 5, right: 5),
      child: Card(
        elevation: 1,
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              //Header
              _buildTextacount(),
              _buildphoto(),
              new Divider(
                color: Colors.black38,
              ),

              //Container button
              Visibility(
                visible: _lessData,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _detailData = true;
                      _lessData = false;
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    margin:
                        EdgeInsets.only(right: 2, left: 20, top: 5, bottom: 5),
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Show Detail",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black38),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.only(right: 10),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Icon(Icons.keyboard_arrow_left_sharp,
                                    color: Colors.black38)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: _detailData,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _detailData = false;
                      _lessData = true;
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    margin:
                        EdgeInsets.only(right: 2, left: 20, top: 5, bottom: 5),
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Show Less",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black38),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.only(right: 10),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Icon(Icons.keyboard_arrow_down_rounded,
                                    color: Colors.black38)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              //visibility data
              Visibility(
                  visible: _detailData,
                  child: Column(
                    children: <Widget>[
                      _buildemployeeid(),
                      _buildusername(),
                      _buildemail(),
                      _buildphone(),
                      _buildgender()
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              // Container(
              //   color: baseColor,
              //   width: Get.mediaQuery.size.width,
              //
              // ),
              Container(
                height: double.infinity,
                width: double.infinity,
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _buildSettings(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void getDatapref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      departement_name = sharedPreferences.getString("departement_id");
      username = sharedPreferences.getString("username");
      first_name = sharedPreferences.getString("first_name");
      last_name = sharedPreferences.getString("last_name");
      email = sharedPreferences.getString("email");
      contac = sharedPreferences.getString("contact");
      employee_id = sharedPreferences.getString("employee_id");
      profile_background = sharedPreferences.getString("profile_background");
      gender = sharedPreferences.getString("gender");
      value = sharedPreferences.getInt("value");
      user_id = sharedPreferences.getString("user_id");
      _employee(user_id.toString());
    });
  }

  Future<void> _showConfirmlogout(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            content: Container(
              margin: EdgeInsets.symmetric(vertical: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(" Logout",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: "SFReguler")),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Apak kamu yakin?",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "SFReguler",
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          height: 45,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            textColor: Colors.white,
                            color: btnColor1,
                            child: Text("Iya"),
                            onPressed: () async {
                              session.logout(context);
                              services.clearTokenemployee(user_id);
                            },
                          ),
                        ),
                        Container(
                          height: 45,
                          child: OutlineButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            focusColor: btnColor1,
                            textColor: btnColor1,
                            borderSide: BorderSide(color: btnColor1),
                            child: Text("Tidak"),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  ///function companies
  Future _employee(id) async {
    final response = await http.get(Uri.parse("$base_url/api/employees/${id}"));
    final data = jsonDecode(response.body);

    if (data['code'] == 200) {

      //build personal information
      setState(() {
        first_name = data['data']['first_name'];
        last_name = data['data']['last_name'];
        photo = data['data']['photo'];
        employee_id = data['data']['employee_id'];
        employee_type = data['data']['employee_type']??"";
        position=data['data']['career']!=null?data['data']['career']['position_setting']['position']:"";
      });
    } else {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDatapref();
  }
}
