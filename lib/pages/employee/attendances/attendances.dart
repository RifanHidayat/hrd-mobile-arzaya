import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:format_indonesia/format_indonesia.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:magentahrdios/pages/employee/attendances/detail.dart';
import 'package:magentahrdios/pages/employee/attendances/shimmer.dart';
import 'package:magentahrdios/services/api_clien.dart';
import 'package:magentahrdios/utalities/color.dart';
import 'package:magentahrdios/utalities/constants.dart';
import 'package:magentahrdios/utalities/fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class absence extends StatefulWidget {
  absence({this.type});

  var type;

  @override
  _absenceState createState() => _absenceState();
}

class _absenceState extends State<absence> {
  var user_id, employee_id;
  var work_placement, first_name;

  Map? _absence;
  bool _loading = true,
      _search = true;

  //Coin coin;
  var scrollController = ScrollController();
  bool updating = false;
  var _initialSelectedDates;
  var ControllerDateSearch = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    void choiceAction(String choice) {
      if (choice == Constants.Absence) {
        Navigator.of(context).pushNamed("tabmenu_absence_status_employee-page");
      }
    }

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
          "Kehadiran",
          style: TextStyle(
              color: Colors.white,
              fontFamily: "Roboto-medium",
              fontSize: 18,
              letterSpacing: 0.5),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 5, right: 5),
              // child: _builDateSearch()
            ),
            Expanded(
              child: _loading
                  ? Center(
                child: ShimmerAbsence(),
              )
                  : ListView.builder(
                controller: scrollController,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return _absence!['data'].length == 0
                      ? _buildnodata()
                      : _buildlistabsence(index);
                },
                itemCount: _absence!['data'].length == 0
                    ? 1
                    : _absence!['data'].length,
              ),
            ),
            if (updating) CircularProgressIndicator()
          ],
        ),
      ),
    );
  }

  // Widget _builDateSearch() {
  //   return Container(
  //     color: Colors.white,
  //     child: InkWell(
  //       onTap: () async {
  //         final List<DateTime> picked = await DateRangePicker.showDatePicker(
  //             context: context,
  //             initialFirstDate: new DateTime.now(),
  //             initialLastDate: (new DateTime.now()).add(new Duration(days: 7)),
  //             firstDate: new DateTime(2015),
  //             lastDate: new DateTime(DateTime
  //                 .now()
  //                 .year + 2));
  //         if (picked != null && picked.length == 2) {
  //           print(picked);
  //           ControllerDateSearch.text = picked[0].toString();
  //           var first_date =
  //           DateFormat("dd/MM/yyyy").format(DateTime.parse("${picked[0]}"));
  //           var last_date =
  //           DateFormat("dd/MM/yyyy").format(DateTime.parse("${picked[1]}"));
  //
  //           ControllerDateSearch.text = '${first_date}-${last_date}';
  //           setState(() {
  //             _search = true;
  //           });
  //         }
  //       },
  //       child: TextFormField(
  //         cursorColor: Theme
  //             .of(context)
  //             .cursorColor,
  //         enabled: false,
  //         controller: ControllerDateSearch,
  //         maxLines: null,
  //         decoration: InputDecoration(
  //           labelText: 'Search..',
  //           labelStyle: TextStyle(),
  //           helperText: 'Helper text',
  //           suffixIcon: Container(
  //             child: InkWell(
  //               onTap: () {
  //                 print("e");
  //                 setState(() {
  //                   _search = true;
  //                   ControllerDateSearch.text = "";
  //                 });
  //               },
  //               child: Icon(
  //                 _search == true ? Icons.search_outlined : Icons.close,
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Future multipleDate() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              child: Column(
                children: [
                  SfDateRangePicker(
                    onSelectionChanged: _onSelectionChanged,
                    selectionMode: DateRangePickerSelectionMode.range,
                    initialSelectedDates: _initialSelectedDates,
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {});
  }

  Widget _buildlistabsence(index) {
    var date = _absence!['data'][index]['date'];

    var check_in = "${_absence!['data'][index]['clock_in'] != null
        ? _absence!['data'][index]['clock_in']
        : "-"}";

    var check_out = _absence!['data'][index]['clock_out'] != null
        ? _absence!['data'][index]['clock_out']
        : "-";


    //
    return _absence!['data'][index]['checkin_category'] == 'present'
        ? Container(
      width: Get.mediaQuery.size.width,
      child: Card(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //header
              Container(
                margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                child: Row(
                  children: [
                    Text(

                      "${Waktu(DateTime.parse(date.toString())).yMMMMEEEEd()}",
                      style: TextStyle(
                          color: baseColor,
                          fontFamily: "Roboto-medium",
                          letterSpacing: 0.5,fontSize: 12),
                    ),

                    Expanded(
                      child: Container(
                          alignment: Alignment.centerRight,
                          width: double.maxFinite,
                          child: Container(
                            width: 70,
                            child: Container(
                              child: Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(top: 3, bottom: 3),
                                  child: Text(
                                    "${_absence!['data'][index]['checkin_category'] ==
                                        "present" ? "Hadir" : ""}",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10),
                                  )),
                              decoration: BoxDecoration(
                                color: _absence!['data'][index]['checkin_category'] ==
                                    "present"
                                    ? Colors.green
                                    : Colors.transparent,
                                borderRadius: new BorderRadius.only(
                                  topLeft: const Radius.circular(10.0),
                                  topRight: const Radius.circular(10.0),
                                  bottomLeft: const Radius.circular(10.0),
                                  bottomRight: const Radius.circular(10.0),
                                ),
                              ),
                            ),
                          )
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: Get.mediaQuery.size.width,
                height: 1,
                color: Colors.black38,
              ),

              Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Text(

                                    "Jam masuk",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Roboto-medium",
                                        letterSpacing: 0.5,fontSize: 13),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  child: Text(
                                    "${check_in}",
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.5),
                                        fontFamily: "Roboto-regular",
                                        letterSpacing: 0.5,fontSize: 12),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                _absence!['data'][index]
                                ['checkin_latitude'] != null ? Container(
                                    child: OutlinedButton(
                                      child: Text(
                                        'Detail',
                                        style: TextStyle(
                                            fontFamily: "SFReguler",
                                            color: Colors.green),
                                      ),
                                      onPressed: () {
                                        //detail jam masuk
                                        print(_absence!['data'][index]);
                                        Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: AttendancesDetailPage(
                                            status: widget.type,
                                            date: _absence!['data'][index]['date'],
                                            time: _absence!['data'][index]['clock_in'],
                                            image: _absence!['data'][index]['checkin_image'],
                                            latitude: _absence!['data'][index]
                                            ['checkin_latitude'],
                                            longitude: _absence!['data'][index]
                                            ['checkin_longitude'],
                                            type: _absence!['data'][index]['category'],
                                            rejected_by: _absence!['data'][index]
                                            ['checkin_rejected_by'] ==
                                                null
                                                ? "null"
                                                : "${_absence!['data'][index]['checkin_rejected_by']['first_name']} ${_absence!['data'][index]['checkin_rejected_by']['last_name']}",
                                            approved_by: _absence!['data'][index]
                                            ['checkin_approved_by'] ==
                                                null
                                                ? "null"
                                                : "${_absence!['data'][index]['checkin_approved_by']['first_name']} ${_absence!['data'][index]['checkin_approved_by']['last_name']}",
                                            rejected_on: _absence!['data'][index]['checkin_rejected_at'],
                                            rejection_note: _absence!['data'][index]
                                            ['checkin_rejection_note'],
                                            approval_note: _absence!['data'][index]
                                            ['checkin_approval_note'],
                                            approved_on: _absence!['data'][index]['checkin_approved_at'],
                                            note: _absence!['data'][index]['clockin_note']??null,
                                            category: _absence!['data'][index]['checkin_category'],
                                            work_placement: work_placement
                                            ,
                                            firts_name_employee: first_name,
                                            last_name_employee: "",
                                            office_latitude: _absence!['data'][index]
                                            ['checkin_office_latitude'],
                                            office_longitude: _absence!['data'][index]
                                            ['checkin_office_longitude'],
                                            employee_id: employee_id,
                                            photo: null,

                                        )));
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             AttendancesDetailPage(
                                        //                 status: widget.type,
                                        //                 date: _absence!['data'][index]['date'],
                                        //                 time: _absence!['data'][index]['clock_in'],
                                        //                 image: _absence!['data'][index]['checkin_image'],
                                        //                 latitude: _absence!['data'][index]
                                        //                 ['checkin_latitude'],
                                        //                 longitude: _absence!['data'][index]
                                        //                 ['checkin_longitude'],
                                        //                 type: _absence!['data'][index]['category'],
                                        //                 rejected_by: _absence!['data'][index]
                                        //                 ['checkin_rejected_by'] ==
                                        //                     null
                                        //                     ? "null"
                                        //                     : "${_absence!['data'][index]['checkin_rejected_by']['first_name']} ${_absence!['data'][index]['checkin_rejected_by']['last_name']}",
                                        //                 approved_by: _absence!['data'][index]
                                        //                 ['checkin_approved_by'] ==
                                        //                     null
                                        //                     ? "null"
                                        //                     : "${_absence!['data'][index]['checkin_approved_by']['first_name']} ${_absence!['data'][index]['checkin_approved_by']['last_name']}",
                                        //                 rejected_on: _absence!['data'][index]['checkin_rejected_at'],
                                        //                 rejection_note: _absence!['data'][index]
                                        //                 ['checkin_rejection_note'],
                                        //                 approval_note: _absence!['data'][index]
                                        //                 ['checkin_approval_note'],
                                        //                 approved_on: _absence!['data'][index]['checkin_approved_at'],
                                        //                 note: null,
                                        //                 category: _absence!['data'][index]['checkin_category'],
                                        //                 work_placement: work_placement
                                        //                 ,
                                        //                 firts_name_employee: first_name,
                                        //                 last_name_employee: "",
                                        //                 office_latitude: _absence!['data'][index]
                                        //                 ['checkin_office_latitude'],
                                        //                 office_longitude: _absence!['data'][index]
                                        //                 ['checkin_office_longitude'],
                                        //                 employee_id: employee_id,
                                        //                 photo: null
                                        //             )
                                        //     ));
                                      },
                                    )
                                ) : Container(
                                  margin: EdgeInsets.only(bottom: 30),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 100,
                            width: 1,
                            color: Colors.black,
                          ),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Text("Jam keluar",style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Roboto-medium",
                                    letterSpacing: 0.5,fontSize: 13
                                  ),),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  child: Text(
                                    "${check_out}",
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.5),
                                        fontFamily: "Roboto-regular",
                                        letterSpacing: 0.5,fontSize: 12),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),

                                _absence!['data'][index]
                                ['checkout_longitude'] != null ? Container(
                                    child: OutlinedButton(
                                      child: Text(
                                        'Detail',
                                        style: TextStyle(
                                            fontFamily: "SFReguler",
                                            color: Colors.red),
                                      ),
                                      onPressed: () {
                                        //detail jam keluar
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType.rightToLeft, child: AttendancesDetailPage(
                                                status: widget.type,
                                                date: _absence!['data'][index]['date'],
                                                time: _absence!['data'][index]['clock_out'],
                                                image: _absence!['data'][index]['checkout_image'],
                                                latitude: _absence!['data'][index]
                                                ['checkout_latitude'],
                                                longitude: _absence!['data'][index]
                                                ['checkout_longitude'],
                                                type: _absence!['data'][index]['category'],
                                                rejected_by: _absence!['data'][index]
                                                ['checkout_rejected_by'] ==
                                                    null
                                                    ? "null"
                                                    : "${_absence!['data'][index]['checkout_rejected_by']['first_name']} ${_absence!['data'][index]['checkout_rejected_by']['last_name']}",
                                                approved_by: _absence!['data'][index]
                                                ['checkout_approved_by'] ==
                                                    null
                                                    ? "null"
                                                    : "${_absence!['data'][index]['checkout_approved_by']['first_name']} ${_absence!['data'][index]['checkout_approved_by']['last_name']}",
                                                rejected_on: _absence!['data'][index]['checkout_rejected_at'],
                                                rejection_note: _absence!['data'][index]
                                                ['checkout_rejection_note'],
                                                approval_note: _absence!['data'][index]
                                                ['checkout_approval_note'],
                                                approved_on: _absence!['data'][index]['checkout_approved_at'],
                                                note: _absence!['data'][index]['clockin_note']??null,
                                                category: _absence!['data'][index]['checkout_category'],
                                                work_placement: work_placement
                                                ,
                                                firts_name_employee: first_name,
                                                last_name_employee: "",
                                                office_latitude: _absence!['data'][index]
                                                ['checkout_office_latitude'],
                                                office_longitude: _absence!['data'][index]
                                                ['checkout_office_longitude'],
                                                employee_id: employee_id,
                                                photo: null

                                            )));

                                                // Navigator.push(
                                                //     context,
                                                //     MaterialPageRoute(
                                                //         builder: (context) =>
                                                //             AttendancesDetailPage(
                                                //                 status: widget.type,
                                                //                 date: _absence!['data'][index]['date'],
                                                //                 time: _absence!['data'][index]['clock_out'],
                                                //                 image: _absence!['data'][index]['checkout_image'],
                                                //                 latitude: _absence!['data'][index]
                                                //                 ['checkout_latitude'],
                                                //                 longitude: _absence!['data'][index]
                                                //                 ['checkout_longitude'],
                                                //                 type: _absence!['data'][index]['category'],
                                                //                 rejected_by: _absence!['data'][index]
                                                //                 ['checkout_rejected_by'] ==
                                                //                     null
                                                //                     ? "null"
                                                //                     : "${_absence!['data'][index]['checkout_rejected_by']['first_name']} ${_absence!['data'][index]['checkout_rejected_by']['last_name']}",
                                                //                 approved_by: _absence!['data'][index]
                                                //                 ['checkout_approved_by'] ==
                                                //                     null
                                                //                     ? "null"
                                                //                     : "${_absence!['data'][index]['checkout_approved_by']['first_name']} ${_absence!['data'][index]['checkout_approved_by']['last_name']}",
                                                //                 rejected_on: _absence!['data'][index]['checkout_rejected_at'],
                                                //                 rejection_note: _absence!['data'][index]
                                                //                 ['checkout_rejection_note'],
                                                //                 approval_note: _absence!['data'][index]
                                                //                 ['checkout_approval_note'],
                                                //                 approved_on: _absence!['data'][index]['checkout_approved_at'],
                                                //                 note: null,
                                                //                 category: _absence!['data'][index]['checkout_category'],
                                                //                 work_placement: work_placement
                                                //                 ,
                                                //                 firts_name_employee: first_name,
                                                //                 last_name_employee: "",
                                                //                 office_latitude: _absence!['data'][index]
                                                //                 ['checkout_office_latitude'],
                                                //                 office_longitude: _absence!['data'][index]
                                                //                 ['checkout_office_longitude'],
                                                //                 employee_id: employee_id,
                                                //                 photo: null
                                                //             )));
                                              },
                                    )) : Container(
                                  margin: EdgeInsets.only(bottom: 30),
                                )
                              ],
                            ),
                          )
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
    )
        : _absence!['data'][index]['checkin_category'] == 'leave'
        ? _leave(index)
        : _absence!['data'][index]['checkin_category'] == 'sick'
        ? _sick(index)
        : _absence!['data'][index]['checkin_category'] == 'permission'
        ? _permission(index)
        : Container();
  }

  Widget _leave(index) {
    return Card(
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 20),
        width: Get.mediaQuery.size.width,
        child: Container(
          margin: EdgeInsets.only(top: 10, left: 5, right: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(
                  "Pengajuan Cuti",
                  style: TextStyle(color: Colors.black38),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Flex(direction: Axis.horizontal, children: [
                Expanded(
                    child: Container(
                      child: Text(
                        "[${_absence!['data'][index]['date'].toString()}]",
                        style: TextStyle(
                            color: Colors.black87, fontFamily: "SFReguler"),
                      ),
                    ))
              ]),
              SizedBox(
                height: 15,
              ),
              _absence!['data'][index]['checkin_status'] == "approved"
                  ? detailApproval(index)
                  : Container()
            ],
          ),
        ),
      ),
    );
  }

  Widget _sick(index) {
    return Card(
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 20),
        width: Get.mediaQuery.size.width,
        child: Container(
          margin: EdgeInsets.only(top: 10, left: 5, right: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(
                  "Pengajuan Sakit",
                  style: TextStyle(color: Colors.black38),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Flex(direction: Axis.horizontal, children: [
                Expanded(
                    child: Container(
                      child: Text(
                        "[${_absence!['data'][index]['date'].toString()}]",
                        style: TextStyle(
                            color: Colors.black87, fontFamily: "SFReguler"),
                      ),
                    ))
              ]),
              SizedBox(
                height: 15,
              ),
              _absence!['data'][index]['checkin_status'] == "approved"
                  ? detailApproval(index)
                  : detailRejection(index)
            ],
          ),
        ),
      ),
    );
  }

  Widget _permission(index) {
    return Card(
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 20),
        width: Get.mediaQuery.size.width,
        child: Container(
          margin: EdgeInsets.only(top: 10, left: 5, right: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(
                  "Pengajuan Izin",
                  style: TextStyle(color: Colors.black38),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Flex(direction: Axis.horizontal, children: [
                Expanded(
                    child: Container(
                      child: Text(
                        "[${_absence!['data'][index]['date'].toString()}]",
                        style: TextStyle(
                            color: Colors.black87, fontFamily: "SFReguler"),
                      ),
                    ))
              ]),
              SizedBox(
                height: 15,
              ),
              _absence!['data'][index]['checkin_status'] == "approved"
                  ? detailApproval(index)
                  : detailRejection(index)
            ],
          ),
        ),
      ),
    );
  }

  Widget detailApproval(index) {
    return Container(
      width: Get.mediaQuery.size.width,
      child: Column(
        children: [
          Container(
            width: Get.mediaQuery.size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(2),
                        bottomRight: Radius.circular(2),
                        topRight: Radius.circular(2),
                        bottomLeft: Radius.circular(2)),
                    color: Colors.green,
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(7),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Approved",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "SFReguler",
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget detailRejection(index) {
    return Container(
      width: Get.mediaQuery.size.width,
      child: Column(
        children: [
          Container(
            width: Get.mediaQuery.size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(2),
                        bottomRight: Radius.circular(2),
                        topRight: Radius.circular(2),
                        bottomLeft: Radius.circular(2)),
                    color: Colors.red,
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(7),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Rejected",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "SFReguler",
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildnodata() {
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height - 150,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: no_data_project,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                child: Text(
                  "Belum ada kehadiran",
                  style: subtitleMainMenu,
                )),
          ],
        ),
      ),
    );
  }

  //ge data from api--------------------------------
  Future _dataAbsence(var user_id) async {
    try {
      setState(() {
        _loading = true;
      });
      http.Response response = await http.get(
          Uri.parse(
              "$base_url/api/employees/${user_id}/attendances?status=approved"));
      _absence = jsonDecode(response.body);
      setState(() {
        _loading = false;
      });
    } catch (e) {}
  }

  void getDatapref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      user_id = sharedPreferences.getString("user_id");
      employee_id = sharedPreferences.getString("employee_id");
      work_placement = sharedPreferences.getString("work_placemetn");
      first_name = sharedPreferences.getString("first_name");
      _dataAbsence(user_id);
    });
  }

  getCoin() async {
    // coin = await apiHelper.getCoins();
    // setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCoin();
    getDatapref();
  }
}
