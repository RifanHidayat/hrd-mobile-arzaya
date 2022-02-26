import 'package:flutter/material.dart';
import 'package:magentahrdios/utalities/constants.dart';


class DetailEmployee extends StatefulWidget {
  DetailEmployee(
      {this.first_name,
      this.last_name,
      this.photo,
      this.address,
      this.gender,
      this.email,
      this.contact_number,
      this.date_of_birth,
      this.work_palcement});

  var first_name,
      last_name,
      photo,
      work_palcement,
      contact_number,
      address,
      email,
      date_of_birth,
      gender;

  @override
  _DetailEmployeeState createState() => _DetailEmployeeState();
}

class _DetailEmployeeState extends State<DetailEmployee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black87, //modify arrow color from here..
        ),
        backgroundColor: Colors.white,
        title: new Text(
          "Detail Karyawan",
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              _buildProfile(),
              _buildadress(),
              _buildemail(),
              _buildcontaocnumber(),
              _buildgeneder(),
              _builddateofbirth()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfile() {
    return Container(
      margin: EdgeInsets.all(20),
      child: Row(
        children: <Widget>[
          Container(
              child: CircleAvatar(
            child: employee_profile,
            backgroundColor: Colors.transparent,
            radius: 40,
          )),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    "${widget.first_name} ${widget.last_name}",
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
                    "${widget.work_palcement}",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black38,
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
                          child: widget.address == null
                              ? Text("-")
                              : Text(
                                  widget.address,
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
                          child: widget.email == null
                              ? Text("-")
                              : Text(
                                  widget.email,
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
                          "Number telp",
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
                          child: widget.contact_number == null
                              ? Text("-")
                              : Text(
                                  widget.contact_number,
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
                Container(
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 30,
                    child: Icon(
                      Icons.gesture_outlined,
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
                          "jenis Kelamin",
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
                          child: widget.gender == null
                              ? Text("-")
                              : Text(
                                  widget.gender,
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
                Container(
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 30,
                    child: Icon(
                      Icons.date_range,
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
                          "tanggal lahir",
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
                          child: widget.date_of_birth == null
                              ? Text("-")
                              : Text(
                                  widget.date_of_birth,
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
}
