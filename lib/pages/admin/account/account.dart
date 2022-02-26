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
import 'package:shared_preferences/shared_preferences.dart';

class AccountAdmin extends StatefulWidget {
  @override
  _AccountAdminState createState() => _AccountAdminState();
}

class _AccountAdminState extends State<AccountAdmin> {
  bool _detailData = false;
  bool _lessData = true;
  String? username,
      contac,
      first_name,
      last_name,
      email,
      gender,
      employee_id,
      profile_background = "";
  var user_id, value;
  SharedPreference session = new SharedPreference();
  Services services=new Services();




  //wodget company
  Widget _buildCompany() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => company_pfrofile(id: user_id)));
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
                            "Profile Perusahaan",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: "SFReguler",
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Lihat profile perusahaan kamu",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: "SFReguler",
                              color: Colors.black38,
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
                            color: Colors.black38,
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
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => change_password(
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
                            "Ganti password",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: "SFReguler",
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Ganti Password Kamu",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: "SFReguler",
                              color: Colors.black38,
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
                            color: Colors.black38,
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
                            "Logout",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "logout sebagai $first_name ",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black38,
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
                            color: Colors.black38,
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

//-----end about----

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
                        Text(
                          "$gender",
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

//-----end gender----

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

  //wodget profile
  Widget _buildprofile() {
    return InkWell(
      onTap: () {
        Get.to(DetailProfile(
          id: user_id,
        ));
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
                            "Profile",
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
                          Text(
                            "Lihat detail profile kamu",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black38,
                                fontFamily: "SFReguler"),
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
                            color: Colors.black38,
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

//-----end phone number----

//main menu settings
  Widget _buildSettings() {
    return Container(
        margin: EdgeInsets.only(top: 10, left: 5, right: 5),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildprofile(),
            _buildCompany(),
            _buildChangepassword(),
            _buildlogout(),
            _buildabout()
          ],
        ));
  }

  //--------end settings---------

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
                    "Admin",
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
                          "About",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              fontFamily: "SFReguler",
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Versi aplikasi 1.0.0",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: "SFReguler",
                            color: Colors.black38,
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

//-----end ogout----

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Center(
          child: new Text(
            "Account",
            style: TextStyle(color: Colors.black87),
          ),
        ),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
              ),
              Container(
                color: Colors.white,
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    vertical: 5.0,
                  ),
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
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16,fontFamily: "SFReguler")),
                  SizedBox(height: 10,),
                  Text(
                    "Apakah kamu yakin?",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "SFReguler",

                    )
                    ,
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDatapref();
  }
}
