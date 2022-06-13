import 'package:flutter/material.dart';
import 'package:format_indonesia/format_indonesia.dart';
import 'package:get/get.dart';
import 'package:magentahrdios/pages/announcement/attachment.dart';
import 'package:magentahrdios/utalities/color.dart';
import 'package:page_transition/page_transition.dart';

class AnnouncementDetail extends StatefulWidget {
  var createdAt, title, description, attachment;

  AnnouncementDetail(
      {this.createdAt, this.title, this.description, this.attachment});

  @override
  _AnnouncementDetailState createState() => _AnnouncementDetailState();
}

class _AnnouncementDetailState extends State<AnnouncementDetail> {
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
          "Detail Pengumuman",
          style: TextStyle(
              color: Colors.white,
              fontFamily: "Roboto-medium",
              fontSize: 18,
              letterSpacing: 0.5),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: Get.mediaQuery.size.width,
          height: Get.mediaQuery.size.height,
          child: Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    "${widget.title}",
                    style: TextStyle(
                        color: baseColor,
                        letterSpacing: 0.5,
                        fontSize: 16,
                        fontFamily: "Roboto-medium"),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "DiPosting pada ${Waktu(DateTime.parse(widget.createdAt)).yMMMMEEEEd()}",
                  style: TextStyle(
                      letterSpacing: 0.4,
                      color: Colors.black.withOpacity(0.3),
                      fontSize: 12),
                ),
                widget.attachment!=null?ElevatedButton(
                    onPressed: () {

                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: DetailAttachentPage(attachment: widget.attachment,)));
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(redBaseColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )),
                    ),
                    child: const Text(
                      "LAMPIRAN",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontFamily: "Roboto-regular"),
                    )):Container(),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "${widget.description}",
                  style: TextStyle(
                      letterSpacing: 0.5, color: Colors.black, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
