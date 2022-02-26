import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:magentahrdios/pages/employee/home/home.dart';
import 'package:magentahrdios/utalities/color.dart';
import 'package:magentahrdios/vaidasi/validator.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LoginAdmin extends StatefulWidget {
  @override
  _LoginAdminState createState() => _LoginAdminState();
}

enum statusLogin { signIn, notSignIn }

class _LoginAdminState extends State<LoginAdmin> {
  Validasi validator = Validasi();
  statusLogin _loginStatus = statusLogin.notSignIn;

  // ignore: non_constant_identifier_names
  var Cusername = new TextEditingController();

  // ignore: non_constant_identifier_names
  var Cpassword = new TextEditingController();
  var email = '';
  var password = '';
  bool _obscureText = false;

  Widget _buildText() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Text(
            "LOG IN",
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'SFReguler',
                fontSize: 25),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Admin",
            textAlign: TextAlign.left,
            style: TextStyle(
                color: baseColor1,
                fontWeight: FontWeight.bold,
                fontFamily: 'SFReguler',
                fontSize: 15),
          )
        ],
      ),
    );
  }

  Widget _buildUsername() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Username',
          style: TextStyle(color: Colors.black38),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 9,
                offset: Offset(0, 3),
              )
            ],
          ),
          height: 60.0,
          child: TextFormField(
            controller: Cusername,
            cursorColor: Colors.black38,
            keyboardType: TextInputType.name,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person,
                color: iconColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: TextStyle(color: Colors.black38),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 9,
                offset: Offset(0, 3),
              )
            ],
          ),
          height: 60.0,
          child: TextFormField(
            cursorColor: Colors.black38,
            obscureText: !_obscureText,
            controller: Cpassword,
            keyboardType: TextInputType.name,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: iconColor,
                ),
                onPressed: () {
                  // Update the state i.e. toogle the state of passwordVisible variable
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: iconColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      width: double.infinity,
      child: RaisedButton(
        onPressed: () {
          validator.validation_login_admin(
              context, Cusername.text, Cpassword.text);

//          Navigator.pop(context);
//           Navigator.of(context).pushReplacement(new MaterialPageRoute(
//               builder: (BuildContext context) => new NavBarAdmin()));
        },
        padding: EdgeInsets.all(12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2.0),
        ),
        color: btnColor1,
        child: Text(
          'LOGIN  ',
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'SFReguler',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case statusLogin.notSignIn:
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height,
              child: Container(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      _buildText(),
                      Expanded(
                        child: Container(
                            height: MediaQuery.of(context).size.height - 30,
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildUsername(),
                                SizedBox(
                                  height: 10,
                                ),
                                _buildPassword(),
                                SizedBox(
                                  height: 10,
                                ),
                                _buildForgetPassword(),
                                SizedBox(
                                  height: 20,
                                ),
                                _buildLoginBtn(),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
        break;
      case statusLogin.signIn:
        return HomeEmployee();
        break;
    }
  }

  getDataPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      int? nvalue = sharedPreferences.getInt("value");
      _loginStatus = nvalue == 1 ? statusLogin.signIn : statusLogin.notSignIn;
    });
  }

  Widget _buildForgetPassword() {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            child: Text(
              "Lupa Password?",
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataPref();
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.lineTo(0, size.height * 0.75);
    path.lineTo(size.width, size.height * 0.75);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
