import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:magentahrdios/pages/admin/home/navbar.dart';
import 'package:magentahrdios/pages/employee/attendances/shimmer.dart';
import 'package:magentahrdios/services/api_clien.dart';
import 'package:magentahrdios/utalities/color.dart';
import 'package:magentahrdios/utalities/constants.dart';

class ApprovedAbsenceAdminPage extends StatefulWidget {
  ApprovedAbsenceAdminPage ({this.type});

  var type;

  @override
  _ApprovedAbsenceAdminPageState createState() => _ApprovedAbsenceAdminPageState();
}

class _ApprovedAbsenceAdminPageState extends State<ApprovedAbsenceAdminPage> {
  late Map _absence;
  bool _loading = true;

Future<bool>? _onBackPressed() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => NavBarAdmin()),
        ModalRoute.withName('/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        child: Container(
          child: _loading
              ? Center(
            child: ShimmerAbsence(),
          )
              : ListView.builder(
            // itemCount: _budgeting['data']['cash_flow'].length,
              itemCount: _absence['data'].length == 0
                  ? 1
                  : _absence['data'].length,
              itemBuilder: (context, index) {
                return _absence['data'].length == 0
                    ? _buildnodata()
                    : _buildlistabsence(index);
              }),

          //
        ),
        onRefresh: _dataAbsence,
      ),
    );
  }

  Widget _buildlistabsence(index) {
    return _absence['data'][index]['category']=='present'?Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 130,
          child: Card(

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(

                        top: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Container(
                              width: double.infinity,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  //container text

                                  Flexible(
                                    child: Container(
                                      margin:
                                      EdgeInsets.only(top: 10, left: 10),
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: [
                                              Container(
                                                  child: _absence['data'][index]
                                                  ['status'] ==
                                                      "pending"
                                                      ? Text(
                                                      "${_absence['data'][index]['employee']['first_name']}'s ${_absence['data'][index]['type']} butuh persetujuan",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors
                                                              .black87))
                                                      : _absence['data'][index]
                                                  ['status'] ==
                                                      "rejected"
                                                      ? Text(
                                                      " ${_absence['data'][index]['type']} ${_absence['data'][index]['employee']['first_name']}  telah ditolak",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors
                                                              .black87))
                                                      : _absence['data']
                                                  [index]
                                                  ['status'] ==
                                                      "approved"
                                                      ? Container(
                                                      width:Get.mediaQuery.size.width-50,
                                                      child: _absence['data'][index]['approved_at'] != null ? Text("${_absence['data'][index]['type']}  ${_absence['data'][index]['employee']['first_name']}  telah di approved", style: TextStyle(fontSize: 15, color: Colors.black87)) : Text("${_absence['data'][index]['employee']['first_name']} (${_absence['data'][index]['employee']['employee_id']}) telah melakukan ${_absence['data'][index]['type']}", style: TextStyle(fontSize: 15, color: Colors.black87)))
                                                      : Text(""))
                                            ],
                                          ),
                                          Container(
                                            child: _absence['data'][index]
                                            ['type'] ==
                                                "check in"
                                                ? Container(
                                                child: _absence['data']
                                                [index]
                                                ['status'] ==
                                                    "pending"
                                                    ? Text(
                                                    "${_absence['data'][index]['clock_in']}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors
                                                            .black26))
                                                    : _absence['data'][index]['status'] ==
                                                    "rejected"
                                                    ? Text(
                                                    "${_absence['data'][index]['rejected_at']}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black26))
                                                    : _absence['data'][index]['status'] == "approved"
                                                    ? Container(child: _absence['data'][index]['approved_at'] != null ? Text("${ DateFormat("dd/MM/yyyy hh:mm:ss").format(DateTime.parse(_absence['data'][index]['approved_at']))}", style: TextStyle(fontSize: 15, color: Colors.black26)) : Text("${ DateFormat("dd/MM/yyyy hh:mm:ss").format(DateTime.parse(_absence['data'][index]['clock_in']))}", style: TextStyle(fontSize: 15, color: Colors.black26)))

                                                    : Text(""))
                                                : Container(
                                                child: _absence['data'][index]['status'] == "pending"
                                                    ? Text("${_absence['data'][index]['clock_out']}", style: TextStyle(fontSize: 15, color: Colors.black26))
                                                    : _absence['data'][index]['status'] == "rejected"
                                                    ? Text("${_absence['data'][index]['rejected_at']}", style: TextStyle(fontSize: 15, color: Colors.black26))
                                                    : _absence['data'][index]['status'] == "approved"
                                                    ? Container(child: _absence['data'][index]['approved_at'] != null ? Text("${DateFormat("dd/MM/yyyy hh:mm:ss").format(DateTime.parse(_absence['data'][index]['approved_at']))}", style: TextStyle(fontSize: 15, color: Colors.black26)) : Text("${DateFormat("dd/MM/yyyy hh:mm:ss").format(DateTime.parse(_absence['data'][index]['clock_out']))}", style: TextStyle(fontSize: 15, color: Colors.black26)))
                                                    : Text("")),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              if (_absence['data'][index]
                                              ['type'] ==
                                                  "check in") {
                                                // Navigator.push(
                                                //     context,
                                                //     MaterialPageRoute(
                                                //         builder: (context) =>
                                                //             detail_absence_admin(
                                                //               status:
                                                //               widget.type,
                                                //               date: _absence[
                                                //               'data']
                                                //               [index]
                                                //               ['date'],
                                                //               id_attandance:
                                                //               _absence['data']
                                                //               [
                                                //               index]
                                                //               ['id'],
                                                //               time: _absence[
                                                //               'data']
                                                //               [index]
                                                //               ['clock_in'],
                                                //               image: _absence[
                                                //               'data']
                                                //               [index]
                                                //               ['image'],
                                                //               latitude: _absence[
                                                //               'data']
                                                //               [index][
                                                //               'clock_in_latitude'],
                                                //               longitude: _absence[
                                                //               'data']
                                                //               [index][
                                                //               'clock_in_longitude'],
                                                //               type: _absence[
                                                //               'data']
                                                //               [index]
                                                //               ['type'],
                                                //               rejected_by: _absence['data']
                                                //               [
                                                //               index]
                                                //               [
                                                //               'rejected_by'] ==
                                                //                   null
                                                //                   ? null
                                                //                   : "${_absence['data'][index]['rejected_by']['first_name']} ${_absence['data'][index]['rejected_by']['last_name']}",
                                                //               approved_by: _absence['data']
                                                //               [
                                                //               index]
                                                //               [
                                                //               'approved_by'] ==
                                                //                   null
                                                //                   ? null
                                                //                   : "${_absence['data'][index]['approved_by']['first_name']} ${_absence['data'][index]['approved_by']['last_name']}",
                                                //               rejected_on: _absence[
                                                //               'data']
                                                //               [index][
                                                //               'rejected_at'],
                                                //               rejection_note:
                                                //               _absence['data']
                                                //               [
                                                //               index]
                                                //               [
                                                //               'rejection_note'],
                                                //               approval_note:
                                                //               _absence['data']
                                                //               [
                                                //               index]
                                                //               [
                                                //               'approval_note'],
                                                //               approved_on: _absence[
                                                //               'data']
                                                //               [index][
                                                //               'approved_at'],
                                                //               note: _absence[
                                                //               'data']
                                                //               [index]
                                                //               ['note'],
                                                //               category: _absence[
                                                //               'data']
                                                //               [index]
                                                //               ['category'],
                                                //               work_placement: _absence[
                                                //               'data']
                                                //               [
                                                //               index]
                                                //               [
                                                //               'employee']
                                                //               [
                                                //               'work_placement'],
                                                //               firts_name_employee:
                                                //               _absence['data']
                                                //               [
                                                //               index]
                                                //               [
                                                //               'employee']
                                                //               [
                                                //               'first_name'],
                                                //               last_name_employee:
                                                //               _absence['data']
                                                //               [
                                                //               index]
                                                //               [
                                                //               'employee']
                                                //               [
                                                //               'last_name'],
                                                //               office_latitude: _absence['data'][index]['office_latitude'],
                                                //               office_longitude: _absence['data'][index]['office_longitude'],
                                                //               photo: _absence['data'][index]['employee']['photo'],
                                                //               employee_id: _absence['data'][index]['employee']['employee_id'],
                                                //             )));
                                              } else {
                                                // Navigator.push(
                                                //     context,
                                                //     MaterialPageRoute(
                                                //         builder: (context) =>
                                                //             detail_absence_admin(
                                                //               id_attandance:
                                                //               _absence['data']
                                                //               [
                                                //               index]
                                                //               ['id'],
                                                //               status:
                                                //               widget.type,
                                                //               date: _absence[
                                                //               'data']
                                                //               [index]
                                                //               ['date'],
                                                //               time: _absence[
                                                //               'data']
                                                //               [index]
                                                //               ['clock_out'],
                                                //               image: _absence[
                                                //               'data']
                                                //               [index]
                                                //               ['image'],
                                                //               latitude: _absence[
                                                //               'data']
                                                //               [index][
                                                //               'clock_out_latitude'],
                                                //               longitude: _absence[
                                                //               'data']
                                                //               [index][
                                                //               'clock_out_longitude'],
                                                //               type: _absence[
                                                //               'data']
                                                //               [index]
                                                //               ['type'],
                                                //               rejected_by: _absence['data']
                                                //               [
                                                //               index]
                                                //               [
                                                //               'rejected_by'] ==
                                                //                   null
                                                //                   ? null
                                                //                   : "${_absence['data'][index]['rejected_by']['first_name']} ${_absence['data'][index]['rejected_by']['last_name']}",
                                                //               approved_by: _absence['data']
                                                //               [
                                                //               index]
                                                //               [
                                                //               'approved_by'] ==
                                                //                   null
                                                //                   ? null
                                                //                   : "${_absence['data'][index]['approved_by']['first_name']} ${_absence['data'][index]['approved_by']['last_name']}",
                                                //               rejected_on: _absence[
                                                //               'data']
                                                //               [index][
                                                //               'rejected_at'],
                                                //               rejection_note:
                                                //               _absence['data']
                                                //               [
                                                //               index]
                                                //               [
                                                //               'rejection_note'],
                                                //               approval_note:
                                                //               _absence['data']
                                                //               [
                                                //               index]
                                                //               [
                                                //               'approval_note'],
                                                //               approved_on: _absence[
                                                //               'data']
                                                //               [index][
                                                //               'approved_at'],
                                                //               note: _absence[
                                                //               'data']
                                                //               [index]
                                                //               ['note'],
                                                //               category: _absence[
                                                //               'data']
                                                //               [index]
                                                //               ['category'],
                                                //               work_placement: _absence[
                                                //               'data']
                                                //               [
                                                //               index]
                                                //               [
                                                //               'employee']
                                                //               [
                                                //               'work_placement'],
                                                //               firts_name_employee:
                                                //               _absence['data']
                                                //               [
                                                //               index]
                                                //               [
                                                //               'employee']
                                                //               [
                                                //               'first_name'],
                                                //               last_name_employee:
                                                //               _absence['data']
                                                //               [
                                                //               index]
                                                //               [
                                                //               'employee']
                                                //               [
                                                //               'last_name'],
                                                //               office_latitude: _absence['data'][index]['office_latitude'],
                                                //               office_longitude: _absence['data'][index]['office_longitude'],
                                                //               employee_id: _absence['data'][index]['employee']['employee_id'],
                                                //               photo: _absence['data'][index]['employee']['photo'],
                                                //
                                                //             )));
                                              }
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                right: 5,
                                                bottom: 5,
                                              ),
                                              width: double.infinity,
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                                children: <Widget>[
                                                  Container(
                                                    child: _absence['data'][index]['office_latitude']!=null?Text(
                                                      "LIHAT DETAIL ",
                                                      style: TextStyle(
                                                          color: textColor1),
                                                    ):Text(""),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ):_absence['data'][index]['category']=='leave'?_leave(index):_absence['data'][index]['category']=='sick'?_sick(index):_absence['data'][index]['category']=='permission'?_permission(index):Container();

  }


  Widget _leave(index){
    return Card(
      child: Container(
        margin: EdgeInsets.only(top: 10,bottom: 20),
        width: Get.mediaQuery.size.width,
        child: Container(
          margin: EdgeInsets.only(top: 10,left: 5,right: 5),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(child:Text("${_absence['data'][index]['employee']['first_name']} (${_absence['data'][index]['employee']['employee_id']})",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold),),),
              SizedBox(height: 10,),

              Container(child:Text("Cuti",style: TextStyle(color: Colors.black38),),),
              SizedBox(height: 5,),
              Flex(
                  direction: Axis.horizontal,
                  children: [Expanded(child: Container(child:Text("[${_absence['data'][index]['date'].toString()}]",style: TextStyle(color: Colors.black87,fontFamily: "SFReguler"),),))]),
              SizedBox(height: 15,),
              _absence['data'][index]['status']=="approved"?detailApproval(index):detailRejection(index)

            ],
          ),
        ),

      ),
    );
  }
  Widget _sick(index){
    return Card(
      child: Container(
        margin: EdgeInsets.only(top: 10,bottom: 20),
        width: Get.mediaQuery.size.width,
        child: Container(
          margin: EdgeInsets.only(top: 10,left: 5,right: 5),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(child:Text("${_absence['data'][index]['employee']['first_name']} (${_absence['data'][index]['employee']['employee_id']})",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold),),),
              SizedBox(height: 10,),

              Container(child:Text("Sakit",style: TextStyle(color: Colors.black38),),),
              SizedBox(height: 5,),
              Flex(
                  direction: Axis.horizontal,
                  children: [Expanded(child: Container(child:Text("[${_absence['data'][index]['date'].toString()}]",style: TextStyle(color: Colors.black87,fontFamily: "SFReguler"),),))]),
              SizedBox(height: 15,),
              _absence['data'][index]['status']=="approved"?detailApproval(index):detailRejection(index)

            ],
          ),
        ),

      ),
    );
  }
  Widget _permission(index){
    return Card(
      child: Container(
        margin: EdgeInsets.only(top: 10,bottom: 20),
        width: Get.mediaQuery.size.width,
        child: Container(
          margin: EdgeInsets.only(top: 10,left: 5,right: 5),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(child:Text("${_absence['data'][index]['employee']['first_name']} (${_absence['data'][index]['employee']['employee_id']})",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold),),),
              SizedBox(height: 10,),

              Container(child:Text("Izin",style: TextStyle(color: Colors.black38),),),
              SizedBox(height: 5,),
              Flex(
                  direction: Axis.horizontal,
                  children: [Expanded(child: Container(child:Text("[${_absence['data'][index]['date'].toString()}]",style: TextStyle(color: Colors.black87,fontFamily: "SFReguler"),),))]),
              SizedBox(height: 15,),
              _absence['data'][index]['status']=="approved"?detailApproval(index):detailRejection(index)

            ],
          ),
        ),

      ),
    );
  }

  Widget detailApproval(index){
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
                            Text("Approved",style: TextStyle(color: Colors.white,fontFamily: "SFReguler",fontSize: 12),),
                          ],
                        ),)

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
  Widget detailRejection(index){
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
                            Text("Rejected",style: TextStyle(color: Colors.white,fontFamily: "SFReguler",fontSize: 12),),
                          ],
                        ),)

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
      height: MediaQuery.of(context).size.height - 150,
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
            Center(
              child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 20,right: 20),
                  child: Text(
                    "Belum ada absen dengan status ${widget.type}",
                    style: TextStyle(color: Colors.black38, fontSize: 18,fontFamily: "SFReguler"),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  //ge data from api--------------------------------
  Future _dataAbsence() async {
    try {
      setState(() {
        _loading = true;
      });
      http.Response response =
      await http.get(Uri.parse("$base_url/api/attendances?status=${widget.type}"));
      var _absence_data = jsonDecode(response.body);
      _absence=json.decode(response.body);
      print(_absence);


      setState(() {
        _loading = false;
      });
    } catch (e) {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dataAbsence();
  }
}
