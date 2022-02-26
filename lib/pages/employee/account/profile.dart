import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:magentahrdios/services/api_clien.dart';
import 'package:magentahrdios/utalities/color.dart';

class DetailProfile extends StatefulWidget {
  var id;

  DetailProfile({this.id});

  @override
  _DetailProfileState createState() => _DetailProfileState();
}

class _DetailProfileState extends State<DetailProfile> {
  var first_name,
      bank_account_name,
      bank_account_owner,
      bank_account_number,
      bank_account_branch,
      emergency_contact_name,
      emergency_contact_number,
      last_name,
      photo,
      work_palcement,
      contact_number,
      address,
      email,
      date_of_birth,
      gender,
      citizenship,
      religion,
      citizenship_country,
      employee_status,
      start_work_date,
      designation,
      departement,
      identity_type,
      identity_number,
      identity_expired,
      place_of_birth,
      last_education,
      blood_type,
      study_program,
      identity_expired_date,
      last_education_name,
      username,
      marita_status,
      npwp_number,
      npwp_start,
      npwp_pemotong,
      wajib_pajak,
      no_kpj,
      date_bpjs,
      employee_id,
      number_card_bpjs,
      employee_type,
      efective_date_bpjs;
  bool _isLoading = false;

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
            "Profile",
            style: TextStyle(
                color: Colors.white,
                fontFamily: "Roboto-medium",
                fontSize: 18,
                letterSpacing: 0.5),
          ),
        ),
        body: Container(
          width: Get.mediaQuery.size.width,
          height: Get.mediaQuery.size.height,
          child: SingleChildScrollView(
            child: _isLoading == true
                ? Container(
                    width: Get.mediaQuery.size.height,
                    height: Get.mediaQuery.size.width,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ))
                : Container(
                    child: Column(
                      children: <Widget>[
                        _buildProfile(),
                        Container(child: personalInformation()),
                        contactInformation(),
                        bankAccount(),
                        NPWPInformation(),
                        BPJSInformation()
                      ],
                    ),
                  ),
          ),
        ));
  }

  Widget _buildProfile() {
    return Container(
      margin: EdgeInsets.all(20),
      child: Row(
        children: <Widget>[
          Container(
            child: photo != null
                ? CircleAvatar(
                    backgroundImage: NetworkImage("${image_ur}/$photo"),
                    backgroundColor: Colors.transparent,
                    radius: 40,
                  )
                : Container(
                    child: Image.asset(
                    "assets/profile-default.png",
                    width: 60,
                    height: 60,
                  )),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: Get.mediaQuery.size.width / 1.8,
                  child: Text(
                    "${first_name}",
                    style: TextStyle(
                        fontFamily: "SFReguler",
                        fontSize: 15,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  child: Text(
                    "${employee_id} | ${employee_type}",
                    style: TextStyle(
                      fontSize: 11,
                      fontFamily: "SFReguler",
                      color: blackColor,
                    ),
                  ),
                ),
              ],
            ),
          ) //Container
        ],
      ),
    );
  }

  //personal information
  Widget personalInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 5, top: 20, bottom: 10),
          child: Text(
            "Informasi Pribadi",
            style: TextStyle(
                color: Colors.black, fontFamily: "Roboto-bold", fontSize: 16),
          ),
        ),
        Card(
          elevation: 1,
          child: Column(
            children: <Widget>[
              _username(),
              _buildgeneder(),
              _citizenship(),
              _citizenship_country(),
              _identity_type(),
              _identity_number(),
              _identity_expired_date(),
              _place_of_birth(),
              _builddateofbirth(),
              _marita_status(),
              _employee_status(),
              _religion(),
              _blood_type(),
              _last_education(),
              _last_education_name(),
              _study_program()
            ],
          ),
        ),
      ],
    );
  }

  //Contaoct Information
  //personal information
  Widget contactInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 5, top: 20, bottom: 10),
          child: Text(
            "Informasi Kontak",
            style: TextStyle(
                color: Colors.black,
                fontFamily: "Roboto-bold",
                letterSpacing: 0.5,
                fontSize: 16),
          ),
        ),
        Card(
          elevation: 1,
          child: Column(
            children: <Widget>[
              _buildemail(),
              _contact_number(),
              _buildadress(),
              _emergency_contact_name(),
              _emergency_contact_number(),
            ],
          ),
        ),
      ],
    );
  }

  Widget bankAccount() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 5, top: 20, bottom: 10),
          child: Text(
            "Rekening Bank",
            style: TextStyle(
                color: Colors.black,
                fontFamily: "Roboto-bold",
                letterSpacing: 0.5,
                fontSize: 16),
          ),
        ),
        Card(
          elevation: 1,
          child: Column(
            children: <Widget>[
              _bank_account_name(),
              _bank_account_owner(),
              _bank_account_number(),
              _bank_account_branch(),
            ],
          ),
        ),
      ],
    );
  }

  Widget NPWPInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 5, top: 20, bottom: 10),
          child: Text(
            "Informasi NPWP",
            style: TextStyle(
                color: Colors.black,
                fontFamily: "Roboto-bold",
                letterSpacing: 0.5,
                fontSize: 16),
          ),
        ),
        Card(
          elevation: 1,
          child: Column(
            children: <Widget>[
              _npwp_number(),
              _npwp_start(),
              _npwp_pemotang(),
              _wajib_pajak()
            ],
          ),
        ),
      ],
    );
  }

  Widget BPJSInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 5, top: 20, bottom: 10),
          child: Text(
            "Informasi BPJS",
            style: TextStyle(
                color: Colors.black,
                fontFamily: "Roboto-bold",
                letterSpacing: 0.5,
                fontSize: 16),
          ),
        ),
        Card(
          elevation: 1,
          child: Column(
            children: <Widget>[
              _no_kpj(),
              _date_bpjs(),
              _number_card_bpjs(),
              _effective_date_bpjs()
            ],
          ),
        ),
      ],
    );
  }

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
                              fontFamily: "Roboto-medium",
                              fontSize: 14,
                              color: Colors.black,
                              letterSpacing: 0.5),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Column(
                          children: [
                            Container(
                              width: Get.mediaQuery.size.width - 40,
                              child: address == null
                                  ? Text("-")
                                  : Text(
                                      address,
                                      style: TextStyle(
                                        fontFamily: "SFReguler",
                                        fontSize: 14,
                                        color: Colors.black38,
                                      ),
                                    ),
                            ),
                          ],
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
                          child: email == null
                              ? Text("-")
                              : Text(
                                  email,
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

  Widget _buildcontaocnumber() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          //row company profile
          Container(
            child: Row(
              children: <Widget>[
                //container icon
                //container text componey profile
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Nomor telp",
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
                          child: contact_number == null
                              ? Text("-")
                              : Text(
                                  contact_number,
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
          new Divider(
            color: Colors.black12,
          ),
        ],
      ),
    );
  }

  Widget _buildgeneder() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          //row company profile
          Container(
            child: Row(
              children: <Widget>[
                //container icon
                //container text componey profile
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Jenis Kelamin",
                          style: TextStyle(
                              fontFamily: "Roboto-medium",
                              fontSize: 14,
                              color: Colors.black,
                              letterSpacing: 0.5),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                            child: gender == null
                                ? Text("-")
                                : Container(
                                    child: gender == 'male'
                                        ? Text(
                                            "Pria",
                                            style: TextStyle(
                                                fontFamily: "Roboto-regular",
                                                fontSize: 12,
                                                color: Colors.black,
                                                letterSpacing: 0.5),
                                          )
                                        : gender == "female"
                                            ? Text(
                                                "Wanita",
                                                style: TextStyle(
                                                    fontFamily:
                                                        "Roboto-regular",
                                                    fontSize: 12,
                                                    color: Colors.black,
                                                    letterSpacing: 0.5),
                                              )
                                            : Text(
                                                "-",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: "SFReguler",
                                                  color: Colors.black38,
                                                ),
                                              ),
                                  ))
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

  Widget _builddateofbirth() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          //row company profile
          Container(
            child: Row(
              children: <Widget>[
                //container icon
                //container text componey profile
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Tanggal lahir",
                          style: TextStyle(
                              fontFamily: "Roboto-medium",
                              fontSize: 14,
                              color: Colors.black,
                              letterSpacing: 0.5),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: date_of_birth == null
                              ? Text("-")
                              : Text(
                                  date_of_birth,
                                  style: TextStyle(
                                      fontFamily: "Roboto-regular",
                                      fontSize: 12,
                                      color: Colors.black,
                                      letterSpacing: 0.5),
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

  Widget _username() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          //row company profile
          Container(
            child: Row(
              children: <Widget>[
                //container icon
                //container text componey profile
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Username",
                          style: TextStyle(
                              fontFamily: "Roboto-medium",
                              fontSize: 14,
                              color: Colors.black,
                              letterSpacing: 0.5),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: username == null
                              ? Text("-")
                              : Text(
                                  "${username}",
                                  style: TextStyle(
                                      fontFamily: "Roboto-regular",
                                      fontSize: 12,
                                      color: Colors.black,
                                      letterSpacing: 0.5),
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

  Widget _citizenship() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          //row company profile
          Container(
            child: Row(
              children: <Widget>[
                //container icon
                //container text componey profile
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Kewarganegaraan",
                          style: TextStyle(
                              fontFamily: "Roboto-medium",
                              fontSize: 14,
                              color: Colors.black,
                              letterSpacing: 0.5),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: citizenship == null
                              ? Text("-")
                              : Text(
                                  citizenship.toString().toUpperCase(),
                                  style: TextStyle(
                                      fontFamily: "Roboto-medium",
                                      fontSize: 12,
                                      color: Colors.black,
                                      letterSpacing: 0.5),
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

  Widget _citizenship_country() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          //row company profile
          Container(
            child: Row(
              children: <Widget>[
                //container icon
                //container text componey profile
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Negara",
                          style: TextStyle(
                              fontFamily: "Roboto-medium",
                              fontSize: 14,
                              color: Colors.black,
                              letterSpacing: 0.5),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: citizenship == null
                              ? Text("-")
                              : Text(
                                  citizenship.toString().toUpperCase(),
                                  style: TextStyle(
                                      fontFamily: "Roboto-medium",
                                      fontSize: 12,
                                      color: Colors.black,
                                      letterSpacing: 0.5),
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

  Widget _employee_status() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          //row company profile
          Container(
            child: Row(
              children: <Widget>[
                //container icon
                //container text componey profile
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Status Karyawan",
                          style: TextStyle(
                              fontFamily: "Roboto-medium",
                              fontSize: 14,
                              color: Colors.black,
                              letterSpacing: 0.5),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: employee_status == null
                              ? Text("-")
                              : Text(
                                  employee_status,
                                  style: TextStyle(
                                      fontFamily: "Roboto-regulat",
                                      fontSize: 12,
                                      color: Colors.black,
                                      letterSpacing: 0.5),
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

  Widget _start_work_date() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          //row company profile
          Container(
            child: Row(
              children: <Widget>[
                //container icon
                //container text componey profile
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Tanggal Mulai Kerja",
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
                          child: start_work_date == null
                              ? Text("-")
                              : Text(
                                  start_work_date,
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

  Widget _designation() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          //row company profile
          Container(
            child: Row(
              children: <Widget>[
                //container icon
                //container text componey profile
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "designation",
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
                          child: designation == null
                              ? Text("-")
                              : Text(
                                  designation,
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

  Widget _departement() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          //row company profile
          Container(
            child: Row(
              children: <Widget>[
                //container icon
                //container text componey profile
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Departement",
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
                          child: departement == null
                              ? Text("-")
                              : Text(
                                  departement,
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

  Widget _identity_type() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          //row company profile
          Container(
            child: Row(
              children: <Widget>[
                //container icon
                //container text componey profile
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Indentitas Diri",
                          style: TextStyle(
                              fontFamily: "Roboto-medium",
                              fontSize: 14,
                              color: Colors.black,
                              letterSpacing: 0.5),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: identity_type == null
                              ? Text("-")
                              : Text(
                                  identity_type,
                                  style: TextStyle(
                                      fontFamily: "Roboto-regulat",
                                      fontSize: 12,
                                      color: Colors.black,
                                      letterSpacing: 0.5),
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

  Widget _identity_number() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          //row company profile
          Container(
            child: Row(
              children: <Widget>[
                //container icon
                //container text componey profile
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "No. Identitas",
                          style: TextStyle(
                              fontFamily: "Roboto-medium",
                              fontSize: 14,
                              color: Colors.black,
                              letterSpacing: 0.5),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: identity_number == null
                              ? Text("-")
                              : Text(
                                  identity_number.toString().toUpperCase(),
                                  style: TextStyle(
                                      fontFamily: "Roboto-regular",
                                      fontSize: 14,
                                      color: Colors.black,
                                      letterSpacing: 0.5),
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

  Widget _identity_expired_date() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          //row company profile
          Container(
            child: Row(
              children: <Widget>[
                //container icon
                //container text componey profile
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Tanggal Akhir berlaku Identitas",
                          style: TextStyle(
                              fontFamily: "Roboto-medium",
                              fontSize: 14,
                              color: Colors.black,
                              letterSpacing: 0.5),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: identity_expired_date == null
                              ? Text("-")
                              : Text(
                                  identity_expired_date,
                                  style: TextStyle(
                                      fontFamily: "Roboto-regular",
                                      fontSize: 12,
                                      color: Colors.black,
                                      letterSpacing: 0.5),
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

  Widget _place_of_birth() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          //row company profile
          Container(
            child: Row(
              children: <Widget>[
                //container icon
                //container text componey profile
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Tempat Lahir",
                          style: TextStyle(
                              fontFamily: "Roboto-medium",
                              fontSize: 14,
                              color: Colors.black,
                              letterSpacing: 0.5),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: place_of_birth == null
                              ? Text("-")
                              : Text(
                                  place_of_birth,
                                  style: TextStyle(
                                      fontFamily: "Roboto-regular",
                                      fontSize: 12,
                                      color: Colors.black,
                                      letterSpacing: 0.5),
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

  Widget _marita_status() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          //row company profile
          Container(
            child: Row(
              children: <Widget>[
                //container icon
                //container text componey profile
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Status Perkawinan",
                          style: TextStyle(
                              fontFamily: "Roboto-medium",
                              fontSize: 14,
                              color: Colors.black,
                              letterSpacing: 0.5),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: marita_status == null
                              ? Text("-")
                              : Text(
                                  marita_status,
                                  style: TextStyle(
                                      fontFamily: "Roboto-regular",
                                      fontSize: 12,
                                      color: Colors.black,
                                      letterSpacing: 0.5),
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

  Widget _last_education() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          //row company profile
          Container(
            child: Row(
              children: <Widget>[
                //container icon
                //container text componey profile
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Pendidikan Terakhir",
                          style: TextStyle(
                              fontFamily: "Roboto-medium",
                              fontSize: 14,
                              color: Colors.black,
                              letterSpacing: 0.5),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: last_education == null
                              ? Text("-")
                              : Text(
                                  last_education,
                                  style: TextStyle(
                                      fontFamily: "Roboto-regular",
                                      fontSize: 12,
                                      color: Colors.black,
                                      letterSpacing: 0.5),
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

  Widget _religion() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          //row company profile
          Container(
            child: Row(
              children: <Widget>[
                //container icon
                //container text componey profile
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Agama",
                          style: TextStyle(
                              fontFamily: "Roboto-medium",
                              fontSize: 14,
                              color: Colors.black,
                              letterSpacing: 0.5),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: religion == null
                              ? Text("-")
                              : Text(
                                  religion,
                                  style: TextStyle(
                                      fontFamily: "Roboto-regular",
                                      fontSize: 12,
                                      color: Colors.black,
                                      letterSpacing: 0.5),
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

  Widget _blood_type() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          //row company profile
          Container(
            child: Row(
              children: <Widget>[
                //container icon
                //container text componey profile
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Gologangan Darah",
                          style: TextStyle(
                              fontFamily: "Roboto-medium",
                              fontSize: 14,
                              color: Colors.black,
                              letterSpacing: 0.5),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: blood_type == null
                              ? Text("-")
                              : Text(
                                  blood_type,
                                  style: TextStyle(
                                      fontFamily: "Roboto-regular",
                                      fontSize: 12,
                                      color: Colors.black,
                                      letterSpacing: 0.5),
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

  Widget _study_program() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          //row company profile
          Container(
            child: Row(
              children: <Widget>[
                //container icon
                //container text componey profile
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Program Study",
                          style: TextStyle(
                              fontFamily: "Roboto-medium",
                              fontSize: 14,
                              color: Colors.black,
                              letterSpacing: 0.5),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: study_program == null
                              ? Text("-")
                              : Text(
                                  study_program,
                                  style: TextStyle(
                                      fontFamily: "Roboto-regular",
                                      fontSize: 12,
                                      color: Colors.black,
                                      letterSpacing: 0.5),
                                ),
                        )
                      ],
                    )),
              ],
            ),
          ),
          // new Divider(
          //   color: Colors.black12,
          // ),
        ],
      ),
    );
  }

  Widget _last_education_name() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          //row company profile
          Container(
            child: Row(
              children: <Widget>[
                //container icon
                //container text componey profile
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Nama Institusi Pendidikan",
                          style: TextStyle(
                              fontFamily: "Roboto-medium",
                              fontSize: 14,
                              color: Colors.black,
                              letterSpacing: 0.5),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: last_education_name == null
                              ? Text("-")
                              : Text(
                                  last_education_name,
                                  style: TextStyle(
                                      fontFamily: "Roboto-regular",
                                      fontSize: 14,
                                      color: Colors.black,
                                      letterSpacing: 0.5),
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

  Widget _contact_number() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          //row company profile
          Container(
            child: Row(
              children: <Widget>[
                //container icon
                //container text componey profile
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "No. HP",
                          style: TextStyle(
                              fontFamily: "Roboto-medium",
                              fontSize: 14,
                              color: Colors.black,
                              letterSpacing: 0.5),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: contact_number == null
                              ? Text("-")
                              : Text(
                                  contact_number,
                                  style: TextStyle(
                                    fontFamily: "Roboto-regular",
                                    fontSize: 14,
                                    color: Colors.black,
                                    letterSpacing: 0.58,
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

  Widget _emergency_contact_number() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          //row company profile
          Container(
            child: Row(
              children: <Widget>[
                //container icon
                //container text componey profile
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "No. Kontak Darurat",
                          style: TextStyle(
                              fontFamily: "Roboto-medium",
                              fontSize: 14,
                              color: Colors.black,
                              letterSpacing: 0.5),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: emergency_contact_number == null
                              ? Text("-")
                              : Text(
                                  emergency_contact_number,
                                  style: TextStyle(
                                      fontFamily: "Roboto-regular",
                                      fontSize: 14,
                                      color: Colors.black,
                                      letterSpacing: 0.5),
                                ),
                        )
                      ],
                    )),
              ],
            ),
          ),
          // new Divider(
          //   color: Colors.black12,
          // ),
        ],
      ),
    );
  }

  Widget _emergency_contact_name() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          //row company profile
          Container(
            child: Row(
              children: <Widget>[
                //container icon
                //container text componey profile
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Nama Kontak Darurat",
                          style: TextStyle(
                              fontFamily: "Roboto-regular",
                              fontSize: 14,
                              color: Colors.black,
                              letterSpacing: 0.5),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: emergency_contact_name == null
                              ? Text("-")
                              : Text(
                                  emergency_contact_name,
                                  style: TextStyle(
                                      fontFamily: "Roboto-medium",
                                      fontSize: 14,
                                      color: Colors.black,
                                      letterSpacing: 0.5),
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

  Widget _bank_account_name() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          //row company profile
          Container(
            child: Row(
              children: <Widget>[
                //container icon
                //container text componey profile
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Nama Bank",
                          style: TextStyle(
                              fontFamily: "Roboto-medium",
                              fontSize: 14,
                              color: Colors.black,
                              letterSpacing: 0.5),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: bank_account_name == null
                              ? Text("-")
                              : Text(
                                  bank_account_name,
                                  style: TextStyle(
                                      fontFamily: "Roboto-regular",
                                      fontSize: 12,
                                      color: Colors.black,
                                      letterSpacing: 0.5),
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

  Widget _bank_account_owner() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          //row company profile
          Container(
            child: Row(
              children: <Widget>[
                //container icon
                //container text componey profile
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Nama Pemegang Rekening",
                          style: TextStyle(
                              fontFamily: "Roboto-medium",
                              fontSize: 14,
                              color: Colors.black,
                              letterSpacing: 0.5),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: bank_account_owner == null
                              ? Text("-")
                              : Text(
                                  bank_account_owner,
                                  style: TextStyle(
                                      fontFamily: "Roboto-medium",
                                      fontSize: 12,
                                      color: Colors.black,
                                      letterSpacing: 0.5),
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

  Widget _bank_account_number() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          //row company profile
          Container(
            child: Row(
              children: <Widget>[
                //container icon
                //container text componey profile
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "No. Rekening",
                          style: TextStyle(
                              fontFamily: "Roboto-medium",
                              fontSize: 14,
                              color: Colors.black,
                              letterSpacing: 0.5),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: bank_account_number == null
                              ? Text("-")
                              : Text(
                                  bank_account_number,
                                  style: TextStyle(
                                    fontFamily: "Roboto-medium",
                                    fontSize: 12,
                                    color: Colors.black,
                                    letterSpacing: 0.5,
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

  Widget _bank_account_branch() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          //row company profile
          Container(
            child: Row(
              children: <Widget>[
                //container icon
                //container text componey profile
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Kantor Cabang Bank",
                          style: TextStyle(
                              fontFamily: "Roboto-medium",
                              fontSize: 12,
                              color: Colors.black,
                              letterSpacing: 0.5),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: bank_account_branch == null
                              ? Text("-")
                              : Text(
                                  bank_account_branch,
                                  style: TextStyle(
                                      fontFamily: "Roboto-medium",
                                      fontSize: 12,
                                      color: Colors.black,
                                      letterSpacing: 0.5),
                                ),
                        )
                      ],
                    )),
              ],
            ),
          ),
          // new Divider(
          //   color: Colors.black12,
          // ),
        ],
      ),
    );
  }

  Widget _npwp_number() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          //row company profile
          Container(
            child: Row(
              children: <Widget>[
                //container icon
                //container text componey profile
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "NPWP",
                          style: TextStyle(
                              fontFamily: "Roboto-medium",
                              fontSize: 14,
                              color: Colors.black,
                              letterSpacing: 0.5),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: npwp_number == null
                              ? Text("-")
                              : Text(
                                  npwp_number,
                                  style: TextStyle(
                                      fontFamily: "Roboto-regular",
                                      fontSize: 14,
                                      color: Colors.black,
                                      letterSpacing: 0.5),
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

  Widget _npwp_start() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          //row company profile
          Container(
            child: Row(
              children: <Widget>[
                //container icon
                //container text componey profile
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "NPWP Sejak",
                          style: TextStyle(
                              fontFamily: "Roboto-medium",
                              fontSize: 14,
                              color: Colors.black,
                              letterSpacing: 0.5),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: npwp_start == null
                              ? Text("-")
                              : Text(
                                  npwp_start,
                                  style: TextStyle(
                                      fontFamily: "Roboto-regular",
                                      fontSize: 14,
                                      color: Colors.black,
                                      letterSpacing: 0.5),
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

  Widget _npwp_pemotang() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          //row company profile
          Container(
            child: Row(
              children: <Widget>[
                //container icon
                //container text componey profile
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "NPWP Pemotong",
                          style: TextStyle(
                              fontFamily: "Roboto-medium",
                              fontSize: 14,
                              color: Colors.black,
                              letterSpacing: 0.5),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: npwp_pemotong == null
                              ? Text("-")
                              : Text(
                                  npwp_pemotong,
                                  style: TextStyle(
                                      fontFamily: "Roboto-regular",
                                      fontSize: 14,
                                      color: Colors.black,
                                      letterSpacing: 0.5),
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

  Widget _wajib_pajak() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          //row company profile
          Container(
            child: Row(
              children: <Widget>[
                //container icon
                //container text componey profile
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Wajib Pajak",
                          style: TextStyle(
                              fontFamily: "Roboto-medium",
                              fontSize: 14,
                              color: Colors.black,
                              letterSpacing: 0.5),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: wajib_pajak == null
                              ? Text("-")
                              : Text(
                                  wajib_pajak,
                                  style: TextStyle(
                                      fontFamily: "Roboto-regular",
                                      fontSize: 12,
                                      color: Colors.black,
                                      letterSpacing: 0.5),
                                ),
                        )
                      ],
                    )),
              ],
            ),
          ),
          // new Divider(
          //   color: Colors.black12,
          // ),
        ],
      ),
    );
  }

  Widget _no_kpj() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          //row company profile
          Container(
            child: Row(
              children: <Widget>[
                //container icon
                //container text componey profile
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "No. KPJ BPJS Ketenagakerjaan",
                          style: TextStyle(
                              fontFamily: "Roboto-medium",
                              fontSize: 14,
                              color: Colors.black,
                              letterSpacing: 0.5),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: no_kpj == null
                              ? Text("-")
                              : Text(
                                  no_kpj,
                                  style: TextStyle(
                                      fontFamily: "Roboto-regular",
                                      fontSize: 12,
                                      color: Colors.black,
                                      letterSpacing: 0.5),
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

  Widget _date_bpjs() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          //row company profile
          Container(
            child: Row(
              children: <Widget>[
                //container icon
                //container text componey profile
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Tanggal Efekti BPJS Ketenagakerjaan",
                          style: TextStyle(
                              fontFamily: "Roboto-medium",
                              fontSize: 14,
                              color: Colors.black,
                              letterSpacing: 0.5),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: date_bpjs == null
                              ? Text("-")
                              : Text(
                                  date_bpjs,
                                  style: TextStyle(
                                      fontFamily: "Roboto-regular",
                                      fontSize: 12,
                                      color: Colors.black,
                                      letterSpacing: 0.5),
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

  Widget _number_card_bpjs() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          //row company profile
          Container(
            child: Row(
              children: <Widget>[
                //container icon
                //container text componey profile
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "No. Kartu BPJS Kesehatan",
                          style: TextStyle(
                              fontFamily: "Roboto-medium",
                              fontSize: 14,
                              color: Colors.black,
                              letterSpacing: 0.5),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: number_card_bpjs == null
                              ? Text("-")
                              : Text(
                                  number_card_bpjs,
                                  style: TextStyle(
                                      fontFamily: "Roboto-medium",
                                      fontSize: 12,
                                      color: Colors.black,
                                      letterSpacing: 0.5),
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

  Widget _effective_date_bpjs() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          //row company profile
          Container(
            child: Row(
              children: <Widget>[
                //container icon
                //container text componey profile
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Tanggal Efektif BPJS Kesehatan",
                          style: TextStyle(
                              fontFamily: "Roboto-medium",
                              fontSize: 14,
                              color: Colors.black,
                              letterSpacing: 0.5),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: efective_date_bpjs == null
                              ? Text("-")
                              : Text(
                                  efective_date_bpjs,
                                  style: TextStyle(
                                      fontFamily: "Roboto-medium",
                                      fontSize: 12,
                                      color: Colors.black,
                                      letterSpacing: 0.5),
                                ),
                        )
                      ],
                    )),
              ],
            ),
          ),
          // new Divider(
          //   color: Colors.black12,
          // ),
        ],
      ),
    );
  }

  ///function companies
  Future _employee(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    final response =
        await http.get(Uri.parse("$base_url/api/employees/${widget.id}"));
    final data = jsonDecode(response.body);

    if (data['code'] == 200) {
      //final compaymodel = companiesFromJson(response.body);

      //build personal information
      first_name = data['data']['first_name'];
      employee_type = data['data']['employee_type'];
      last_name = data['data']['last_name'];
      photo = data['data']['photo'];
      work_palcement = data['data']['work_placement'];
      username = data['data']['username'];
      gender = data['data']['gender'];
      date_of_birth = data['data']['date_of_birth'];
      employee_id = data['data']['employee_id'];
      citizenship = data['data']['citizenship'];
      citizenship_country = data['data']['citizenship_country'];
      employee_status = data['data']['employee_status'];
      start_work_date = data['data']['start_work_date'];
      //designation=data['data']['active_career']['designation_name'];
      //departement=data['data']['active_career']['department']['name'];
      identity_type = data['data']['identity_type'];
      identity_number = data['data']['identity_number'];
      identity_expired_date = data['data']['identity_expired-date'];
      place_of_birth == data['data']['place_of_birth'];
      marita_status = data['data']['marital_status'];
      last_education = data['data']['last_education'];
      religion = data['data']['religion'];
      blood_type = data['data']['blood_type'];
      study_program = data['data']['study_program'];
      last_education_name = data['data']['last_education_name'];
      last_education = data['data']['last_education'];

      // contaoc  information
      email = data['data']['email'];
      contact_number = data['data']['contact_number'];
      address = data['data']['address'];
      emergency_contact_number = data['data']['emergency_contact_number'];
      emergency_contact_name = data['data']['emergency_contact_name'];

      //back account
      bank_account_name = data['data']['bank_account_name'];
      bank_account_owner = data['data']['bank_account_owner'];
      bank_account_number = data['data']['bank_account_number'];
      bank_account_branch = data['data']['bank_account_branch'];
      //npwp
      npwp_number = data['data']['npwp_number'];
      npwp_start = data['data']['npwp_start_date'];
      npwp_pemotong = data['data']['npwp_tax_collector'];
      efective_date_bpjs = data['data']['bpjs_kesehatan_effective_date'];
      wajib_pajak = data['data']['taxpayer_status'];
      //bpjs
      no_kpj = data['data']['bpjs_ketenagakerjaan_number'];
      date_bpjs = data['data']['bpjs_ketenagakerjaan_effective_date'];
      number_card_bpjs = data['data']['bpjs_kesehatan_number'];
      efective_date_bpjs = data['data']['bpjs_kesehatan_effective_date'];

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
    _employee(context);
  }
}
