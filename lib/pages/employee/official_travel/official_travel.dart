import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:format_indonesia/format_indonesia.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:magentahrdios/pages/employee/official_travel/add_official_travel.dart';
import 'package:magentahrdios/pages/employee/official_travel/rembers.dart';
import 'package:magentahrdios/services/api_clien.dart';
import 'package:magentahrdios/utalities/color.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OfficialTravelPage extends StatefulWidget {
  @override
  _OfficialTravelPageState createState() => _OfficialTravelPageState();
}

class _OfficialTravelPageState extends State<OfficialTravelPage> {
  bool _loading = true;
  List? officialTravel;
  int officialTravellength = 0;
  var user_id;

  final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDatapref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton.extended(
      //   backgroundColor: baseColor,
      //   onPressed: () {
      //     // Navigator.of(context).push(MaterialPageRoute(
      //     //     builder: (BuildContext context) => RepositoryProvider(
      //     //       create: (context) => SickRepository(),
      //     //       child: SickSubmissionPage(),
      //     //     )));
      //
      //     Navigator.push(
      //         context,
      //         PageTransition(
      //             type: PageTransitionType.rightToLeft,
      //             child: AddOfficialTravelPage()));
      //   },
      //   icon: Icon(Icons.add),
      //   label: Text(
      //     "Perdin",
      //     style: TextStyle(
      //         color: Colors.white,
      //         letterSpacing: 0.5,
      //         fontSize: 15,
      //         fontFamily: "inter-light"),
      //   ),
      // ),
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
          "Perjalanan Dinas",
          style: TextStyle(
              color: Colors.white,
              fontFamily: "Roboto-medium",
              fontSize: 18,
              letterSpacing: 0.5),
        ),
      ),
      body: Container(
        child: _loading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : _fetchOfficialTravel(),
      ),
    );
  }

  Widget _fetchOfficialTravel() {
    return ListView.builder(
        itemCount: officialTravellength,
        itemBuilder: (context, index) {
          var d = [];
          var dd = [];
          DateTime date = DateTime.now();
          var dates =
              officialTravel![index]['official_travel_dates'].split(',');

          dates.sort((a, b) {
            //sorting in ascending order
            return DateTime.parse(a).compareTo(DateTime.parse(b));
          });
          for (var date in dates) {
            // _addAndPrint(age);
            dd.add(date);

            d.add(
              "${Waktu(DateTime.parse(date.toString().trim())).yMMMMd()}",
            );
          }
          date = DateTime.parse(dd[0].toString());
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: RembersPage(
                        dateOfCreated: officialTravel![index]
                            ['date_of_created'],
                        officialTravelDates: officialTravel![index]
                            ['official_travel_dates'],
                        description: officialTravel![index]['description'],
                        officialTraveId: officialTravel![index]['id'],
                        employeeId: user_id,
                        bdd: "${formatCurrency.format(officialTravel![index]
                        ['bdd'])}",
                      )));
            },
            child: Container(
                width: Get.mediaQuery.size.width,
                margin: EdgeInsets.only(left: 10, right: 10),
                height: 160,
                child: Container(
                  width: Get.mediaQuery.size.width,
                  height: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Stack(
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              height: 150,
                              child: Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Container(
                                  child: Container(
                                    margin: EdgeInsets.all(25),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "${Waktu(DateTime.parse(officialTravel![index]['date_of_created'].toString())).yMMMMEEEEd()}",
                                          style: TextStyle(
                                              color: baseColor,
                                              letterSpacing: 0.5,
                                              fontSize: 12),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        // Text(
                                        //   "Di Posting pada 3 january 2022",
                                        //   style: TextStyle(
                                        //       letterSpacing: letterSpacing,
                                        //       color: greyColor,
                                        //       fontSize: 12),
                                        // ),
                                        // SizedBox(
                                        //   height: 10,
                                        // ),
                                        Text(
                                          "Tanggal perjalanan dinas pada   ${d}",
                                          style: TextStyle(
                                              letterSpacing: 0.5,
                                              color: Colors.black,
                                              fontSize: 12),
                                        ),
                                        SizedBox(height: 10,),
                                        Text(
                                          "BDD:  ${formatCurrency.format(officialTravel![index]
                                          ['bdd'])}",
                                          style: TextStyle(
                                              letterSpacing: 0.5,
                                              color: Colors.black.withOpacity(0.3),
                                              fontSize: 10),
                                        ),
                                        // Container(
                                        //   alignment: Alignment.topRight,
                                        //   child: Image.asset(
                                        //     "assets/images/pdf-icon.png",
                                        //     width: 17,
                                        //     height: 22,
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            date.isAfter(DateTime.now())
                                ? Container(
                                    alignment: Alignment.center,
                                    width: 60,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: Text(
                                      "New",
                                      style: TextStyle(
                                          letterSpacing: 0.5,
                                          color: Colors.white,
                                          fontSize: 10),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          );
        });
  }

  Future _fetchOfficialTrave(var user_id) async {
    try {
      setState(() {
        _loading = true;
      });
      http.Response response = await http.get(
          Uri.parse("${base_url}/api/official-travel/employee/${user_id}"));
      officialTravel = jsonDecode(response.body);
      officialTravellength = officialTravel!.length;

      print(officialTravel!.length);

      // print(response.body);

      setState(() {
        _loading = false;
      });
    } catch (e) {
      print("${e}");
    }
  }

  Future getDatapref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      user_id = sharedPreferences.getString("user_id");
      _fetchOfficialTrave(user_id);
      // // _dataPermission(user_id);
      // _countPending(user_id);
    });
  }
}
