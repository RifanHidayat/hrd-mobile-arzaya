import 'package:flutter/material.dart';
import 'package:format_indonesia/format_indonesia.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:magentahrdios/utalities/color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'dart:async';

class AddOfficialTravelPage extends StatefulWidget {
  @override
  _AddOfficialTravelPageState createState() => _AddOfficialTravelPageState();
}

class _AddOfficialTravelPageState extends State<AddOfficialTravelPage> {
  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';
  var permission_dates = [];
  var permission_date_submit = [];
  var _initialSelectedDates;
  var _visible = false;
  var disable = true;
  var user_id;
  var isLoading = true;
  var sickDatedCtr = new TextEditingController();
  var descriprionCtr = new TextEditingController();
  var employeeId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDatapref();
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
          "Perjalanan Dinas",
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
              child: InkWell(
                child: Container(
                    margin: EdgeInsets.all(20), child: _formSickSubmission()),
              ))),
    );
  }

  ///function
  Future multipleDate() {
    return showDialog(
        context: context!,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              width: Get.mediaQuery.size.width - 40,
              height: Get.mediaQuery.size.height / 2 + 20,
              child: Expanded(
                child: Column(
                  children: [
                    Container(
                      height: Get.mediaQuery.size.height / 2 + -20,
                      child: SfDateRangePicker(
                        onSelectionChanged: _onSelectionChanged,
                        selectionMode: DateRangePickerSelectionMode.multiple,
                        initialSelectedDates: _initialSelectedDates,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range =
            DateFormat('dd/MM/yyyy').format(args.value.startDate).toString() +
                ' - ' +
                DateFormat('dd/MM/yyyy')
                    .format(args.value.endDate ?? args.value.startDate)
                    .toString();
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
        print(_selectedDate);
      } else if (args.value is List<DateTime>) {
        ///initialselectdates date leaves
        _initialSelectedDates = args.value;
        permission_dates.clear();
        permission_date_submit.clear();
        //jumlahPengambilanController.text = args.value.length.toString();

        ///format date-leaves
        args.value.forEach(
          (DateTime date) {
            permission_dates.add(DateFormat('dd/MM/yyyy').format(date));
            permission_date_submit.add(DateFormat('yyyy-MM-dd').format(date));
          },
        );
        sickDatedCtr.text = permission_dates.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }

  Future getDatapref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      employeeId = sharedPreferences.getInt("id");
    });
  }

  ///widget

  Widget _formSickSubmission() {
    return Container(
      child: Form(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(
                  "${Waktu(DateTime.now()).yMMMMEEEEd()}",
                  style: TextStyle(
                      color: baseColor,
                      fontFamily: "inter-medium",
                      letterSpacing: 0.5,
                      fontSize: 13),
                ),
              ),
              SizedBox(
                height: 20,
              ),

              //sick dates
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Tanggal Perjalanan Dinas",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontFamily: "inter-light"),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        multipleDate();
                      },
                      child: Container(
                        child: TextFormField(
                          cursorColor: Theme.of(context!).cursorColor,
                          enabled: false,
                          maxLines: null,
                          style: TextStyle(
                              fontSize: 12, fontFamily: "inter-light"),
                          controller: sickDatedCtr,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 2, left: 10),
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
                                  color: Colors.black.withOpacity(0.3),
                                  width: 1.0),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            suffixIcon: Icon(
                              Icons.date_range,
                            ),
                          ),
                          // decoration: InputDecoration(
                          //   labelText: 'Tanggal Cuti',
                          //   labelStyle: TextStyle(),
                          //   helperText: 'Helper text',
                          //   suffixIcon: Icon(
                          //     Icons.date_range,
                          //   ),
                          // ),
                        ),
                      ),
                    ),
                    permission_dates.length > 0
                        ? Container(
                            margin: EdgeInsets.only(left: 5),
                            child: Text(
                              "Jumlah pengambilan ${permission_dates.length} hari",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontFamily: "inter-light",
                                  fontSize: 10,
                                  letterSpacing: 0.5),
                            ),
                          )
                        : Container()
                  ],
                ),
              ),

              //description
              SizedBox(
                height: 20,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Keterangan",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontFamily: "inter-light"),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                        onTap: () {
                          multipleDate();
                        },
                        child: Container(
                          child: TextFormField(
                            controller: descriprionCtr,
                            style: TextStyle(
                                fontSize: 12, fontFamily: "inter-light"),
                            maxLines: 5,
                            cursorColor: Theme.of(context!).cursorColor,
                            maxLength: null,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(top: 5, left: 10),
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
                                    color: Colors.black.withOpacity(0.5),
                                    width: 1.0),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              _buildbtsubmit()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildbtsubmit() {
    return Container(
      width: double.infinity,
      height: 45,
      margin: EdgeInsets.symmetric(vertical: 30),
      child: ElevatedButton(
          onPressed: () async {},
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(baseColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            )),
          ),
          child: const Text(
            "Submit",
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: "Roboto-regular"),
          )),
    );
  }
}
