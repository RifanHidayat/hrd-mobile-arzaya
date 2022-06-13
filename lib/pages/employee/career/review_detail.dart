import 'package:flutter/material.dart';
import 'package:format_indonesia/format_indonesia.dart';
import 'package:get/get.dart';
import 'package:magentahrdios/utalities/color.dart';
class ReviewDetail extends StatefulWidget {
  var nextReview,date,status,note,result,position;
  ReviewDetail({this.note,this.date,this.status,this.position,this.nextReview,this.result});
  @override
  _ReviewDetailState createState() => _ReviewDetailState();
}

class _ReviewDetailState extends State<ReviewDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),

        backgroundColor: baseColor,
        title: new Text(
          "Detail Review",
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
        child: Column(
          children: [
            Container(

              color: baseColor1.withOpacity(0.4),
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                    child: Icon(
                      Icons.info,
                      color: blackColor,
                    ),
                  ),
                  Container(
                      child: Text(
                        "Review selanjutnya pada tanggal  ${widget.nextReview}",
                        style: TextStyle(
                            color: blackColor,
                            fontSize: 11,
                            fontFamily: "Roboto-regular",
                            letterSpacing: 0.5),
                      ))
                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(
              width: Get.mediaQuery.size.width,
              height: Get.mediaQuery.size.height/2 +100,
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  margin: EdgeInsets.only(left: 20,right: 20,top: 5,bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Container(

                            child: Text("${Waktu(DateTime.parse(widget.date)).yMMMMEEEEd()}",style: TextStyle(
                              color: baseColor,
                              fontSize: 12,
                              letterSpacing: 0.5,

                            ),),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              width: double.maxFinite,
                              child: Container(
                                width:100,
                                height: 20,
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(top: 10,bottom: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:widget.status=="approved"? greenColorInfo:redColorInfo,
                                ),
                                child: Text("${widget.status=="approved"?"LOLOS":"TIDAK LOLOS"}",style: TextStyle(
                                  color:widget.status=="approved"? greenColor:redColor,
                                  fontSize: 10,
                                  letterSpacing: 0.5,

                                ),),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Divider(height: 1,color: Colors.black.withOpacity(0.1),),
                      SizedBox(height: 5,),
                      Container(
                        child: Text("${widget.status=="approved"?"Naik Jabatan ke ${widget.position}":"Tidak Naik jabatan"} ",style: TextStyle(
                            color: blackColor2,
                            fontSize: 15,
                            letterSpacing: 0.5,
                          fontFamily: "Roboto-medium"
                        ),),
                      ),

                      SizedBox(height: 20,),
                      Container(
                        child: Text("Hasil review :${widget.result??""}",style: TextStyle(
                            height: 1.4,
                            letterSpacing: 1,
                            fontSize: 12,
                            color: blackColor4,
                            fontFamily: "roboto-regular")),
                      ),
                      SizedBox(height: 5,),
                      Container(
                        child: Text("Catatan: ${widget.result??""}",style: TextStyle(
                            height: 1.4,
                            letterSpacing: 1,
                            fontSize: 12,
                            color: blackColor4,
                            fontFamily: "roboto-regular")),
                      )

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }
}
