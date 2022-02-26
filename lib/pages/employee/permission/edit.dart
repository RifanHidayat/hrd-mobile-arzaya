import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:magentahrdios/services/api_clien.dart';
import 'package:magentahrdios/utalities/color.dart';
import 'package:magentahrdios/vaidasi/validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:http/http.dart' as http;

class EditPermissionPageEmployee extends StatefulWidget {
  EditPermissionPageEmployee(
      {this.id,
      this.date_of_filing,
      this.permission_cetegory_id,
      this.numbr_of_days,
      this.permission_dates,
      this.description,
      this.old_permission_date});

  var date_of_filing,
      permission_cetegory_id,
      numbr_of_days,
      permission_dates,
      description,
      id,
      old_permission_date;

  @override
  _EditPermissionPageEmployeeState createState() =>
      _EditPermissionPageEmployeeState();
}

class _EditPermissionPageEmployeeState
    extends State<EditPermissionPageEmployee> {
  DateTime startdate = DateTime.now();
  DateTime enddate = DateTime.now();
  var Cstartdate = new TextEditingController();
  var Cenddate = new TextEditingController();
  var jumlahPengambilanController = new TextEditingController();
  var descriptionController = new TextEditingController();
  var now;
  var sick_dates = [];
  var sick_date_submit = [];
  var _initialSelectedDates;
  var _visible = false;
  var disable = true;
  var user_id;
  var isLoading = false;
  List? typeList;
  String? _type;
  int? position=0;
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
          "Edit Pengajuan izin",
          style: TextStyle(
              color: Colors.white,
              fontFamily: "Roboto-medium",
              fontSize: 18,
              letterSpacing: 0.5),
        ),
      ),
      body: isLoading
          ? Container(
              child: Center(
              child: CircularProgressIndicator(),
            ))
          : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      _buildtglPengajuan(),
                      _buildCategorypermission(),
                      _builddateLeave(),
                      _buildJmlPengambilan(),
                      _buildketerangan(),
                      _buildbtsubmit()
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
            labelText: 'Tanggal Izin',
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
          onPressed: disable == true
              ? () {
                  Validasi validasi = new Validasi();
                  var data = sick_date_submit.toString().replaceAll((']'), '');
                  var data1 = data.toString().replaceAll(('['), '');
                  var data2 = data1.toString().replaceAll((' '), '');
                  print("tes ${widget.old_permission_date}");
                  validasi.validation_permission_submision(
                      context,
                      widget.id,
                      user_id,
                      now.toString(),
                      data2.toString(),
                      jumlahPengambilanController.text.toString(),
                      "${typeList![position!]['id']}",
                      descriptionController.text,
                      widget.old_permission_date,
                      "edit");

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
            "Edit",
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: "Roboto-regular"),
          )),
      // child: new OutlineButton(
      //   onPressed: disable == true
      //       ? () {
      //           Validasi validasi = new Validasi();
      //           var data = sick_date_submit.toString().replaceAll((']'), '');
      //           var data1 = data.toString().replaceAll(('['), '');
      //           var data2 = data1.toString().replaceAll((' '), '');
      //           validasi.validation_permission_submision(
      //               context,
      //               widget.id,
      //               user_id,
      //               now.toString(),
      //               data2.toString(),
      //               jumlahPengambilanController.text.toString(),
      //               "${typeList![position!]['id']}",
      //               descriptionController.text,
      //               widget.old_permission_date,
      //               "edit");
      //         }
      //       : null,
      //   child: Text(
      //     'Submit',
      //     style: TextStyle(
      //       color: Colors.black87,
      //       fontFamily: "SFReguler",
      //     ),
      //   ),
      // ),
    );
  }

  Widget _buildCategorypermission() {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<String>(
                  value: _type,
                  iconSize: 30,
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.black38,
                  ),
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                  hint: Text('Select Kategori'),
                  onChanged: (String? categories) {
                    setState(() {
                      _type = categories;
                      position = typeList?.indexWhere(
                          (prod) => prod["id"] == int.parse(categories!));

                      if (jumlahPengambilanController.text.toString().isEmpty) {
                        disable = true;
                        _visible = true;
                      } else {
                        ///check total total leave
                        if (int.parse(
                                jumlahPengambilanController.text.toString()) >
                            int.parse("${typeList![position!]['max_day']}")) {
                          _visible = true;
                          disable = false;
                        } else {
                          _visible = false;
                          disable = true;
                        }
                      }
                    });
                  },
                  items: typeList?.map((item) {
                        return new DropdownMenuItem(
                          child: new Text(item['name']),
                          value: item['id'].toString(),
                        );
                      })?.toList() ??
                      [],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            color: Colors.black38,
            height: 1,
          ),
          SizedBox(
            height: 5,
          ),
          Visibility(
            child: Container(
                child: position != null
                    ? Text("Maksimal:${typeList![position!]['max_day']} Hari",
                        style: TextStyle(
                            color: Colors.black87,
                            fontFamily: "SFReguler",
                            fontStyle: FontStyle.italic))
                    : Text("")),
          )
        ],
      ),
    );
  }

  _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,

      initialDate: startdate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != startdate)
      setState(() {
        startdate = picked;
        final DateFormat formatter = DateFormat('yyyy-MM-dd');
        var startdate1 = formatter.format(startdate);
        Cstartdate.text = "$startdate1";
      });
  }

  _selectEndtDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: enddate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != enddate)
      setState(() {
        enddate = picked;
        final DateFormat formatter = DateFormat('yyyy-MM-dd');
        var enddate1 = formatter.format(enddate);
        Cenddate.text = "$enddate1";
      });
  }

  _getDataPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      user_id = sharedPreferences.getString("user_id");
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
        var max_day;

        ///initialselectdates date leaves
        _initialSelectedDates = args.value;
        sick_dates.clear();
        sick_date_submit.clear();
        jumlahPengambilanController.text = args.value.length.toString();

        ///format date-leaves
        args.value.forEach(
          (DateTime date) {
            sick_dates.add(DateFormat('dd/MM/yyyy').format(date));
            sick_date_submit.add(DateFormat('yyyy-MM-dd').format(date));
          },
        );

        ///set date-leaves
        if (sick_dates.length <= 0) {
          Cstartdate.text = "";
        } else {
          Cstartdate.text = sick_dates.toString();
        }

        if (position == null) {
          max_day = -1;
          disable = false;
          _visible = false;
        } else {
          ///check total total leave
          if (args.value.length >
              int.parse("${typeList![position!]['max_day']}")) {
            _visible = true;
            disable = false;
          } else {
            _visible = false;
            disable = true;
          }
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

  Future categoryPermission() async {
    try {
      setState(() {
        isLoading = true;
      });

      http.Response response =
          await http.get(Uri.parse("$base_url/api/permission-categories"));
      var data = jsonDecode(response.body);
      setState(() {
        print(data['data']);
        typeList = data['data'];
        print(widget.permission_cetegory_id);
        _type = widget.permission_cetegory_id.toString();
        // position=int.parse(widget.permission_cetegory_id);
          // position = int.parse(widget.permission_cetegory_id) +1;
      });

      setState(() {
        isLoading = false;
      });
    } catch (e) {}
  }

  @override
  void initState() {
    // _isLoading=false;
    // TODO: implement initState

    super.initState();
    final DateTime n = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    now = widget.date_of_filing;
    descriptionController.text = widget.description;

    var leave_dates = widget.permission_dates.split(',');

    leave_dates.forEach(
      (String date) {
        DateTime dt = DateTime.parse(date);

        initial.add(dt);
        // print(dt);
        sick_dates.add(
            DateFormat('dd/MM/yyyy').format(DateTime.parse(date.toString())));
        sick_date_submit.add(
            DateFormat('yyyy-MM-dd').format(DateTime.parse(date.toString())));
      },
    );
    _initialSelectedDates = initial;
    Cstartdate.text = sick_dates.toString();
    jumlahPengambilanController.text =
        jumlahPengambilanController.text = leave_dates.length.toString();
    _getDataPref();

    print(" id ${widget.permission_cetegory_id}");
    categoryPermission();
  }
}
