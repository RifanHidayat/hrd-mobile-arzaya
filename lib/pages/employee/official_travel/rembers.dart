import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:format_indonesia/format_indonesia.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:magentahrdios/pages/employee/official_travel/photo_view.dart';
import 'package:magentahrdios/services/api_clien.dart';
import 'package:magentahrdios/services/official_travel.dart';
import 'package:magentahrdios/utalities/alert_dialog.dart';
import 'package:magentahrdios/utalities/color.dart';
import 'package:http/http.dart' as http;

class RembersPage extends StatefulWidget {
  var dateOfCreated,
      officialTravelDates,
      description,
      employeeId,
      bdd,
      officialTraveId;

  RembersPage(
      {this.dateOfCreated,
      this.officialTravelDates,
      this.description,
      this.employeeId,
      this.bdd,
      this.officialTraveId});

  @override
  _RembersPageState createState() => _RembersPageState();
}

class _RembersPageState extends State<RembersPage> {
  List images = [];
  var officialTravelDates = [];
  List rembers = [];
  var _loadingRembers = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchRembers();

    //       var d=data[index].sickDates!.split(",");
    for (var date in widget.officialTravelDates.split(',')) {
      // _addAndPrint(age);
      officialTravelDates.add(
        "${Waktu(DateTime.parse(date.toString().trim())).yMMMMd()}",
      );
    }
  }

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
          "Reimburse",
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
        child: _body(),
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Container(
        child: Container(
          margin: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(
                  "${Waktu(DateTime.parse(widget.dateOfCreated.toString())).yMMMMEEEEd()}",
                  style: TextStyle(
                      color: baseColor,
                      fontFamily: "inter-medium",
                      letterSpacing: 0.5,
                      fontSize: 13),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Text(
                  "Tanggal perjalanan dinas pada ${officialTravelDates}",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Roboto-regular",
                      letterSpacing: 0.5,
                      fontSize: 13),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Text(
                  "Keterangan ",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Roboto-bold",
                      letterSpacing: 0.5,
                      fontSize: 13),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                child: Text(
                  "${widget.description}",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontFamily: "Roboto-regular",
                      letterSpacing: 0.5,
                      fontSize: 13),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Text(
                  "BDD",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Roboto-bold",
                      letterSpacing: 0.5,
                      fontSize: 13),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                child: Text(
                  "${widget.bdd}",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontFamily: "Roboto-regular",
                      letterSpacing: 0.5,
                      fontSize: 13),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Container(
                    child: Text(
                      "Reimburse ",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Roboto-medium",
                          letterSpacing: 0.5,
                          fontSize: 13),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.maxFinite,
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              images.add(
                                {
                                  "image_file": "",
                                  "image_url": "",
                                  "image_base64": "",
                                  "amount": "",
                                  "description": "",
                                },
                              );
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(baseColor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            )),
                          ),
                          child: Icon(Icons.add)),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                height: 1,
                thickness: 1,
                color: blackColor.withOpacity(0.5),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: List.generate(images.length, (index) {
                    return Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              aksesCamera(index);
                            },
                            child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: Colors.black.withOpacity(0.3))),
                                child: images[index]['image_file'] != ""
                                    ? Container(
                                        width: 100,
                                        height: 100,
                                        child: Image.file(
                                          File(
                                            images[index]['image_file'],
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                      )
                                    : images[index]['image_url'] != ""
                                        ? Container(
                                            width: 100,
                                            height: 100,
                                            child: Image.network(
                                              "${image_ur}/${images[index]['image_url']}",
                                              fit: BoxFit.fill,
                                            ),
                                          )
                                        : Icon(
                                            Icons.camera_alt_outlined,
                                            size: 50,
                                            color:
                                                Colors.black.withOpacity(0.3),
                                          )),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 100,
                            child: TextFormField(
                              initialValue: images[index]['amount'].toString(),
                              cursorColor: Colors.black38,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Roboto-light',
                                  fontSize: 12),
                              decoration: InputDecoration(
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
                                  borderSide: BorderSide(
                                      color: blackColor.withOpacity(0.5),
                                      width: 1.0),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                contentPadding:
                                    EdgeInsets.only(top: 14.0, left: 5),
                                hintText: "Jumlah",
                              ),
                              onChanged: (value) {
                                print(value.toString());
                                images[index]['amount'] = "${value.toString()}";
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 100,
                            child: TextFormField(
                              initialValue:
                                  images[index]['description'].toString(),
                              cursorColor: Colors.black38,
                              keyboardType: TextInputType.name,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Roboto-light',
                                  fontSize: 12),
                              decoration: InputDecoration(
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
                                  borderSide: BorderSide(
                                      color: blackColor.withOpacity(0.5),
                                      width: 1.0),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                contentPadding:
                                    EdgeInsets.only(top: 14.0, left: 5),
                                hintText: "Ket",
                              ),
                              onChanged: (value) {
                                print(value.toString());
                                images[index]['description'] =
                                    "${value.toString()}";
                              },
                            ),
                          ),
                          Container(
                            width: 100,
                            child: ElevatedButton(
                                onPressed: () async {
                                  Get.to(PhotoViewPage(
                                    iamge_file: images[index]['image_file'],
                                    image_url: images[index]['image_url'],
                                  ));
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
                                child: Text(
                                  "View",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Roboto-regular",
                                      fontSize: 12,
                                      letterSpacing: 0.5),
                                )),
                          ),
                          Container(
                            width: 100,
                            child: ElevatedButton(
                                onPressed: () async {
                                  setState(() {
                                    images.removeAt(index);
                                  });
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(redBaseColor),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  )),
                                ),
                                child: Text(
                                  "Hapus",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Roboto-regular",
                                      fontSize: 12,
                                      letterSpacing: 0.5),
                                )),
                          ),
                        ],
                      ),
                    );
                  })
                      // children: [

                      //  ],
                      ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: Get.mediaQuery.size.width,
                child: ElevatedButton(
                    onPressed: () async {
                      // print(images);
                      OfficialTravel officialTravel = new OfficialTravel();
                      officialTravel.rembers(context, widget.employeeId,
                          widget.officialTraveId, images);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(baseColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )),
                    ),
                    child: Text(
                      "Simpan",
                      style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 0.5,
                          fontSize: 13),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  aksesCamera(index) async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      var f = await image.readAsBytes();
      setState(() {
        // _image = File(image.path);
        // base64 = base64Encode(f);
        images[index]['image_file'] = image.path;
        images[index]['image_url'] = "";
        images[index]['image_base64'] = base64Encode(f);
      });
    } else {
      toast_success("No file selected");
    }
  }

  Future _fetchRembers() async {
    print(widget.employeeId);
    try {
      setState(() {
        _loadingRembers = true;
      });
      http.Response response = await http.get(Uri.parse(
          "${base_url}/api/official-travel/${widget.officialTraveId}/rembers"));
      var data = jsonDecode(response.body);

      List rembers = data['rembers']
          .where((o) =>
              o['employee_id'] == int.parse(widget.employeeId.toString()))
          .toList();

      if (rembers.length > 0) {
        // print(response.body);
        for (var reimbers in rembers) {
          images.add(
            {
              "image_file": '',
              "image_url": reimbers['image'],
              "image_base64": "",
              "amount": reimbers['amount'],
              "description": reimbers['description'],
            },
          );
        }
      } else {
        images.add(
          {
            "image_file": '',
            "image_url": "",
            "image_base64": "",
            "amount": "",
            "description": "",
          },
        );
      }

      setState(() {
        _loadingRembers = false;
      });
    } catch (e) {
      print("${e}");
    }
  }
}
