import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magentahrdios/utalities/color.dart';
import 'package:magentahrdios/vaidasi/validator.dart';

class change_password extends StatefulWidget {
  change_password({this.email, this.username, this.id});

  var email, username, id;

  @override
  _change_passwordState createState() => _change_passwordState();
}

class _change_passwordState extends State<change_password> {
  var Cpassword = new TextEditingController();
  var Cconfirm_password = new TextEditingController();
  var _obscureText = false,_obscureConfirmText=false;

  Widget _buildpassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Text(
            'Password',
            style: TextStyle(color: Colors.black87),
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(),
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
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(width: 0, color: Colors.red),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: baseColor, width: 2.0),
                borderRadius: BorderRadius.circular(5.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: blackColor.withOpacity(0.5), width: 1.0),
                borderRadius: BorderRadius.circular(5.0),
              ),
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.black38,
              ),
            ),
          ),
          // child: TextFormField(
          //   controller: Cpassword,
          //   cursorColor: Colors.black38,
          //   obscureText: true,
          //   keyboardType: TextInputType.text,
          //   style: TextStyle(
          //     color: Colors.black,
          //     fontFamily: 'OpenSans',
          //   ),
          //   decoration: InputDecoration(
          //     contentPadding: EdgeInsets.only(top: 14.0),
          //     prefixIcon: Icon(
          //       Icons.lock,
          //       color: Colors.black,
          //     ),
          //   ),
          // ),
        ),
      ],
    );
  }

  Widget _buildconfirmpassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Text(
            'Konfirmasi Password',
            style: TextStyle(
              color: Colors.black87,
              fontFamily: "SFReguler",
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(),
          height: 60.0,
          child: TextFormField(
            cursorColor: Colors.black38,
            obscureText: !_obscureConfirmText,
            controller: Cconfirm_password,
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
                  _obscureConfirmText ? Icons.visibility : Icons.visibility_off,
                  color: Colors.black38,
                ),
                onPressed: () {
                  // Update the state i.e. toogle the state of passwordVisible variable
                  setState(() {
                    _obscureConfirmText = !_obscureConfirmText;
                  });
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(width: 0, color: Colors.red),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: baseColor, width: 2.0),
                borderRadius: BorderRadius.circular(5.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:
                BorderSide(color: blackColor.withOpacity(0.5), width: 1.0),
                borderRadius: BorderRadius.circular(5.0),
              ),
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.black38,
              ),
            ),
          ),
          // child: TextFormField(
          //   controller: Cconfirm_password,
          //   cursorColor: Colors.black38,
          //   obscureText: true,
          //   keyboardType: TextInputType.text,
          //   style: TextStyle(
          //     color: Colors.black,
          //     fontFamily: "SFReguler",
          //   ),
          //   decoration: InputDecoration(
          //     contentPadding: EdgeInsets.only(top: 14.0),
          //     prefixIcon: Icon(
          //       Icons.lock,
          //       color: Colors.black,
          //     ),
          //   ),
          // ),
        ),
      ],
    );
  }

  Widget _buildbtnsave() {
    return Container(
      width: double.infinity,
      height: 40,
      margin: EdgeInsets.symmetric(vertical: Get.mediaQuery.size.height * 0.5-50),
      child: ElevatedButton(
          onPressed: () {
            Validasi validasi = new Validasi();
            validasi.validation_change_password(
                context,
                Cpassword.text,
                widget.username,
                widget.email,
                widget.id,
                Cconfirm_password.text);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(baseColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            )),
          ),
          child: const Text(
            "Save",
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: "Roboto-regular"),
          )),
      // child: new OutlineButton(
      //   onPressed: () {
      //     Validasi validasi = new Validasi();
      //     validasi.validation_change_password(context, Cpassword.text,
      //         widget.username, widget.email, widget.id, Cconfirm_password.text);
      //
      //     },
      //   child: Text(
      //     'Simpan Perubahan',
      //     style: TextStyle(
      //       color: Colors.black87,
      //       fontFamily: "SFReguler",
      //     ),
      //   ),
      // ),
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
          "Password",
          style: TextStyle(
              color: Colors.white,
              fontFamily: "Roboto-medium",
              fontSize: 18,
              letterSpacing: 0.5),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          margin: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              _buildpassword(),
              SizedBox(
                height: 10,
              ),
              _buildconfirmpassword(),
              SizedBox(
                height: 20,
              ),
              _buildbtnsave(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.email.toString());
    print(widget.username.toString());
  }
}
