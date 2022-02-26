import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magentahrdios/pages/admin/login/admin.dart';

import 'package:magentahrdios/pages/employee/login/login.dart';
import 'package:magentahrdios/pages/employee/nav.dart';
import 'package:magentahrdios/utalities/color.dart';
import 'package:magentahrdios/utalities/constants.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Wellcome extends StatefulWidget{

  @override
  _WellcomeState createState() => _WellcomeState();
}

enum statusLogin { signInemployee, notSignIn,signInadmin }
class _WellcomeState extends State<Wellcome> {
  statusLogin _loginStatus = statusLogin.notSignIn;


  Widget _buildImage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        wellcome

      ],
    );
  }

  Widget _buildText() {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10,),
          Text("Selamat Datang",
            textAlign: TextAlign.left,
            style: TextStyle(

                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'SFReguler',
                fontSize: 25
            ),

          ),
          SizedBox(height: 5,),
          Text("di Magenta HRD Apps",
            textAlign: TextAlign.left,
            style: TextStyle(

                color: baseColor,
                fontWeight: FontWeight.bold,
                fontFamily: 'SFReguler',
                fontSize: 15
            ),

          )

        ],
      ),
    );
  }


  Widget _buoldbtnadmin() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: .0),
      width: double.infinity,
      // child: RaisedButton(
      //   onPressed: () {},
      //   child: Text('Enabled Button', style: TextStyle(fontSize: 20)),
      // ),

      child: RaisedButton(

        onPressed: () {
          // Navigator.push(context, MaterialPageRoute(
          //     builder: (context) => LoginAdmin()
          // ));
          Get.to(LoginAdmin());
        },
        padding: EdgeInsets.all(12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2.0),
        ),
        color: btnColor1,

        child: Text(
          'Login sebagai Admin',
          textAlign: TextAlign.left,
          style: TextStyle(

              color: Colors.white,

              fontSize: 14.0,
              fontWeight: FontWeight.bold,

              fontFamily: "SFReguler"
          ),
        ),
      ),
    );
  }

  Widget _buoldbtemployee() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 25.0),
        width: double.infinity,
        child:OutlineButton(
          padding: EdgeInsets.all(12.0),
          onPressed: () {
            // Navigator.push(context, MaterialPageRoute(
            //     builder: (context) => LoginEmployee()
            // ));
           Get.to(LoginEmployee());
          },
          child: Text(
            "Login sebagai Employee",
            style: TextStyle(color: btnColor1,
              fontFamily: 'SFReguler',
            ),
          ),
        )

    );
  }


  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case statusLogin.notSignIn:
        return Scaffold(
          body: Container(
            color: Colors.white,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Stack(

                children: <Widget>[
                  _buildText(),
                  Container(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildImage(),
                    ],
                  )),
                  Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _buoldbtnadmin(),
                          _buoldbtemployee(),
                        ],
                      )),
                  Container(
                      margin: EdgeInsets.only(bottom: 35),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                         // _buoldbtemployee(),
                        ],
                      )),


                ],
              ),
            ),
          ),

        );
        break;
      case statusLogin.signInemployee:
        return NavBarEmployee();
        break;
      case statusLogin.signInadmin:
        return NavBarEmployee();
        break;
    }
  }
  getDataPref() async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      int? nvalue = sharedPreferences.getInt("value");
      _loginStatus = nvalue == 1 ? statusLogin.signInemployee : nvalue==2? statusLogin.signInadmin:statusLogin.notSignIn;
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataPref();
  }


}