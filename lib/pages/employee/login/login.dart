import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:magentahrdios/pages/admin/home/navbar.dart';
import 'package:magentahrdios/pages/employee/home/home.dart';
import 'package:magentahrdios/pages/employee/nav.dart';
import 'package:magentahrdios/utalities/color.dart';
import 'package:magentahrdios/vaidasi/validator.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LoginEmployee extends StatefulWidget {
  @override
  _LoginEmployeeState createState() => _LoginEmployeeState();
}

enum statusLogin { signInRegular, signInAdmin, notSignIn }

class _LoginEmployeeState extends State<LoginEmployee> {
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
            "Employee",
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
          style: TextStyle(color: Colors.black38, fontFamily: "SFReguler"),
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
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.black38,
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
          style: TextStyle(color: Colors.black38, fontFamily: "SFReguler"),
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
                color: Colors.black38,
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: Colors.black38,
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
                color: Colors.black38,
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
          validator.validation_login(context, Cusername.text, Cpassword.text);

          // Navigator.pop(context);
          //  Navigator.of(context).pushReplacement(new MaterialPageRoute(
          //      builder: (BuildContext context) => new NavBarEmployee()));
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

  Widget _buildForgetPassword() {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            child: Text(
              "Lupa Password?",
              style: TextStyle(
                color: Colors.blue,
                fontFamily: 'SFReguler',
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case statusLogin.notSignIn:
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Container(
              width: Get.mediaQuery.size.width,
              height: Get.mediaQuery.size.height,

              child: Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: Get.mediaQuery.size.width / 2 - 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Image.asset(
                          "assets/logo.jpg",
                          width: 400,
                        ),
                      ),
                      Container(
                        child: Text(
                          "Username",
                          style: TextStyle(
                              color: blackColor, fontFamily: "Roboto-regular"),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 50,
                        child: TextFormField(
                          controller: Cusername,
                          style: TextStyle(
                              fontFamily: "Roboto-regular", color: blackColor),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(top: 2, left: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    BorderSide(width: 0, color: Colors.red),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: baseColor, width: 2.0),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: blackColor3, width: 1.0),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              hintText: 'Username',
                              hintStyle: TextStyle(
                                  color: blackColor3,
                                  fontFamily: "Roboto-regular")),

                          // validator: (value) =>
                          // state.isValidPassword ? null : "password is too short",
                          // onChanged: (value) =>
                          //     context.read<AuthBloc>().add(AuthUsernameChange(value)),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Text(
                          "Password",
                          style: TextStyle(
                              color: blackColor, fontFamily: "Roboto-regular"),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 50,
                        child: TextFormField(
                          obscureText: !_obscureText,
                          controller: Cpassword,
                          style: TextStyle(
                              fontFamily: "roboto-regular", color: blackColor),
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                color: Colors.black38,
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.black38,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                              contentPadding: EdgeInsets.only(top: 2, left: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    BorderSide(width: 0, color: Colors.red),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: baseColor, width: 2.0),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: blackColor3, width: 1.0),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                  color: blackColor3,
                                  fontFamily: "roboto-regular")),

                          // validator: (value) =>
                          // state.isValidPassword ? null : "password is too short",
                          // onChanged: (value) =>
                          //     context.read<AuthBloc>().add(AuthUsernameChange(value)),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: Get.mediaQuery.size.width,
                        child: ElevatedButton(
                            onPressed: () {
                              validator.validation_login(
                                  context, Cusername.text, Cpassword.text);
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(baseColor),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              )),
                            ),
                            child: const Text(
                              "Sign In",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: "Roboto-regular"),
                            )),
                      ),
                    ],
                  )),

            ),
          ),
        );
        break;
      case statusLogin.signInRegular:
        return NavBarEmployee();
        break;
        break;
      case statusLogin.signInAdmin:
        return NavBarAdmin();
        break;
    }
  }

  getDataPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      int? nvalue = sharedPreferences.getInt("value");
      _loginStatus = nvalue == 1
          ? statusLogin.signInRegular
          : nvalue == 2
              ? statusLogin.signInRegular
              : statusLogin.notSignIn;
    });
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
