import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:magentahrdios/services/api_clien.dart';
import 'package:magentahrdios/utalities/color.dart';
import 'package:magentahrdios/vaidasi/validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class LeaveEdit extends StatefulWidget {
  LeaveEdit({this.date_of_filing, this.leave_dates, this.description, this.id});

  var date_of_filing, leave_dates, description, id;

  @override
  _LeaveEditState createState() => _LeaveEditState();
}

class _LeaveEditState extends State<LeaveEdit> {
  DateTime startdate = DateTime.now();
  DateTime enddate = DateTime.now();
  var Cstartdate = new TextEditingController();
  var Cenddate = new TextEditingController();
  var totalLeaveController = new TextEditingController();
  var takenLeaveController = new TextEditingController();
  var jumlahPengambilanController = new TextEditingController();
  var descriptionController = new TextEditingController();
  var now;
  var _isLoading;
  var _submisionLeaves;
  var total_leave, taken_leave;
  var date_leaves = [];
  var date_leaves_submit = [];
  var _initialSelectedDates;
  var _visible = false;
  var disabled = true;
  var user_id;
  List<DateTime> initial = [];

  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';

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
          "Edit Pengajuan Cuti",
          style: TextStyle(
              color: Colors.white,
              fontFamily: "Roboto-medium",
              fontSize: 18,
              letterSpacing: 0.5),
        ),
      ),
      // appBar: AppBar(
      //   iconTheme: IconThemeData(
      //     color: Colors.black87, //modify arrow color from here..
      //   ),
      //   backgroundColor: Colors.white,
      //   title: new Text(
      //     "Edit Pengajuan Cuti",
      //     style: TextStyle(color: Colors.black87),
      //   ),
      // ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: _isLoading
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ))
                : Column(
                    children: <Widget>[
                      _buildtglPengajuan(),
                      _buildJatacuti(),
                      _builJumlahambil(),
                      _builddateLeave(),
                      _buildJmlPengambilan(),
                      _buildketerangan(),
                      _buildbtsubmit(),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildtglPengajuan() {
    return Container(
      child: TextFormField(
        enabled: false,
        maxLines: 3,
        initialValue: '${now}',
        decoration: InputDecoration(
          labelText: 'tanggal Pengajuan',
        ),
      ),
    );
  }

  Widget _buildJatacuti() {
    return Container(
      child: TextFormField(
        controller: totalLeaveController,
        enabled: false,
        decoration: InputDecoration(
          labelText: 'Jata Cuti Tahunan',
        ),
      ),
    );
  }

  Widget _builJumlahambil() {
    return Container(
      child: TextFormField(
        enabled: false,
        controller: takenLeaveController,
        decoration: InputDecoration(
          labelText: 'Jumlah Telah Diambil',
        ),
      ),
    );
  }

  Widget _builddateLeave() {
    return InkWell(
      onTap: () {
        //_selectStartDate(context);
        multipleDate();
      },
      child: Container(
        child: TextFormField(
          cursorColor: Theme.of(context).cursorColor,
          enabled: false,
          controller: Cstartdate,
          maxLines: null,
          decoration: InputDecoration(
            labelText: 'Tanggal Cuti',
            labelStyle: TextStyle(),
            helperText: 'Helper text',
            suffixIcon: Icon(
              Icons.date_range,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildJmlPengambilan() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            enabled: false,
            controller: jumlahPengambilanController,
            decoration: InputDecoration(
              labelText: 'Jumlah Pengambilan',
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Visibility(
            visible: _visible,
            child: Container(
              child: Row(
                children: [
                  Container(
                      child: Icon(
                    Icons.warning_amber_outlined,
                    color: Colors.amber,
                    size: 20,
                  )),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      "Jumlah hari telah melewati batas maksimal",
                      style:
                          TextStyle(color: iconColor, fontFamily: "SFReguler"),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildketerangan() {
    return Container(
      child: TextFormField(
        controller: descriptionController,
        maxLines: 3,
        decoration: InputDecoration(
          labelText: 'Keterangan',
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
          onPressed: disabled == true
              ? () {
                  Validasi validasi = new Validasi();
                  var data =
                      date_leaves_submit.toString().replaceAll((']'), '');
                  var data1 = data.toString().replaceAll(('['), '');
                  var data2 = data1.toString().replaceAll((' '), '');
                  validasi.validation_leaves_submision(
                      context,
                      widget.id,
                      user_id,
                      now.toString(),
                      data2.toString(),
                      descriptionController.text,
                      'edit');
                  print(date_leaves_submit);
                  // Validasi validasi = new Validasi();
                  // var data = date_leaves_submit.toString().replaceAll((']'), '');
                  // var data1 = data.toString().replaceAll(('['), '');
                  // var data2 = data1.toString().replaceAll((' '), '');
                  // validasi.validation_leaves_submision(
                  //     context,
                  //     "0",
                  //     user_id,
                  //     now.toString(),
                  //     data2.toString(),
                  //     descriptionController.text,
                  //     'submit');

                  // validasi.validation_leaves_submision(context,"0",user_id, now.toString(), data2.toString(), descriptionController.text,'submit');
                }
              : null,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(baseColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            )),
          ),
          child: const Text(
            "Ubah",
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: "Roboto-regular"),
          )),
      // child: new OutlineButton(
      //   onPressed: disabled == true
      //       ? () {
      //           Validasi validasi = new Validasi();
      //           var data = date_leaves_submit.toString().replaceAll((']'), '');
      //           var data1 = data.toString().replaceAll(('['), '');
      //           var data2 = data1.toString().replaceAll((' '), '');
      //           validasi.validation_leaves_submision(
      //               context,
      //               widget.id,
      //               user_id,
      //               now.toString(),
      //               data2.toString(),
      //               descriptionController.text,
      //               'edit');
      //           print(date_leaves_submit);
      //         }
      //       : null,
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

  Future dataLeave(var id) async {
    try {
      setState(() {
        _isLoading = true;
      });
      http.Response response = await http
          .get(Uri.parse("${base_url}/api/employees/$id/remaining-leaves"));
      _submisionLeaves = jsonDecode(response.body);
      setState(() {
        totalLeaveController.text =
            _submisionLeaves['data']['total_leave'].toString();
        takenLeaveController.text =
            _submisionLeaves['data']['taken_leave'].toString();
        print(_submisionLeaves['data']['total_leave'].toString());
        _isLoading = false;
      });
    } catch (e) {}
  }

  _getDataPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      user_id = sharedPreferences.getString("user_id");
      dataLeave(user_id);
    });
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    /// The argument value will return the changed date as [DateTime] when the
    /// widget [SfDateRangeSelectionMode] set as single.
    ///
    /// The argument value will return the changed dates as [List<DateTime>]
    /// when the widget [SfDateRangeSelectionMode] set as multiple.
    ///
    /// The argument value will return the changed range as [PickerDateRange]
    /// when the widget [SfDateRangeSelectionMode] set as range.
    ///
    /// The argument value will return the changed ranges as
    /// [List<PickerDateRange] when the widget [SfDateRangeSelectionMode] set as
    /// multi range.
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
      } else if (args.value is List<DateTime>) {
        print(args.value);

        ///initialselectdates date leaves
        _initialSelectedDates = args.value;
        date_leaves.clear();
        date_leaves_submit.clear();
        jumlahPengambilanController.text = args.value.length.toString();

        ///format date-leaves
        args.value.forEach(
          (DateTime date) {
            date_leaves.add(DateFormat('dd/MM/yyyy').format(date));
            date_leaves_submit.add(DateFormat('yyyy-MM-dd').format(date));
          },
        );

        ///set date-leaves
        if (date_leaves.length <= 0) {
          Cstartdate.text = "";
        } else {
          Cstartdate.text = date_leaves.toString();
        }

        ///check total total leave
        if (int.parse(totalLeaveController.text.toString()) <
            int.parse(jumlahPengambilanController.text.toString())) {
          _visible = true;
          disabled = false;
        } else {
          _visible = false;
          disabled = true;
        }
      } else {
        _rangeCount = args.value.length.toString();
        jumlahPengambilanController.text = args.value.length.toString();

        print("berhasil");
      }
    });
  }

  Future multipleDate() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              width: Get.mediaQuery.size.width - 40,
              height: Get.mediaQuery.size.height / 2,
              child: Column(
                children: [
                  SfDateRangePicker(
                    onSelectionChanged: _onSelectionChanged,
                    selectionMode: DateRangePickerSelectionMode.multiple,
                    initialSelectedDates: _initialSelectedDates,
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    _isLoading = false;
    descriptionController.text = widget.description;
    //  _initialSelectedDates="[${widget.leave_dates}]";

    // TODO: implement initState

    super.initState();
    final DateTime n = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    now = widget.date_of_filing;
    print(widget.leave_dates);
    var leave_dates = widget.leave_dates.split(',');

    leave_dates.forEach(
      (String date) {
        DateTime dt = DateTime.parse(date);
        print(dt);
        initial.add(dt);
        // print(dt);
        date_leaves.add(
            DateFormat('dd/MM/yyyy').format(DateTime.parse(date.toString())));
        date_leaves_submit.add(
            DateFormat('yyyy-MM-dd').format(DateTime.parse(date.toString())));
      },
    );
    _initialSelectedDates = initial;
    Cstartdate.text = date_leaves.toString();
    jumlahPengambilanController.text = leave_dates.length.toString();

    _getDataPref();
  }
}
