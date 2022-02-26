import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:magentahrdios/utalities/color.dart';

class DetailAnnouncement extends StatefulWidget {
  @override
  _DetailAnnouncementState createState() => _DetailAnnouncementState();
}

class _DetailAnnouncementState extends State<DetailAnnouncement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black87, //modify arrow color from here..
        ),
        backgroundColor: Colors.white,
        title: new Text(
          "Detail Announcement",
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: Get.mediaQuery.size.width,
                alignment: Alignment.centerRight,
                child: Text(
                  "22  november 2020",
                  style:
                  TextStyle(fontFamily: "SFReguler", color: Colors.black38),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Penerima :Semua Karyawan",
                        style: TextStyle(fontFamily: "SFReguler", fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Text(
                        "Judul : JUDUL PENGUMUMAN",
                        style: TextStyle(
                            fontFamily: "SFReguler",
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Text(
                        "Dear Team,",
                        style: TextStyle(fontFamily: "SFReguler", fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: Text(
                        "Content pengumuman",
                        style: TextStyle(fontFamily: "SFReguler", fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      child: Text(
                        "Nama Pemberi pengumuman",
                        style: TextStyle(fontFamily: "SFReguler", fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      color: baseColor,
                      alignment: Alignment.center,
                      width: Get.mediaQuery.size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Transform.rotate(
                              angle: 10,
                              child: Icon(
                                Icons.attach_file,
                                color: Colors.white,
                              )),
                          Container(
                            margin:
                            EdgeInsets.only(left: 10, top: 10, bottom: 10),
                            child: Text(
                              "Attachment",
                              style:
                              TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
