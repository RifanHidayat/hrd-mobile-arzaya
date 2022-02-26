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

class RejectedAbsenceAdminPage extends StatefulWidget {
  RejectedAbsenceAdminPage ({this.type});

  var type;

  @override
  _RejectedAbsenceAdminPageState createState() => _RejectedAbsenceAdminPageState();
}

class _RejectedAbsenceAdminPageState extends State<RejectedAbsenceAdminPage > {
  late Map _absence;
  bool _loading = true;

  Future<bool> _onBackPressed() async {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => NavBarAdmin()),
        ModalRoute.withName('/'));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: _onBackPressed,
        child: RefreshIndicator(
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
      ),
    );
  }

  Widget _buildlistabsence(index) {
    return _absence['data'][index]['category']=='present'?Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 100,
          child: Card(
            elevation: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 5,
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
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(),
                                  ),
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
                                                      ? Container(child: _absence['data'][index]['approved_at'] != null ? Text("${_absence['data'][index]['type']}  ${_absence['data'][index]['employee']['first_name']}  telah di approved", style: TextStyle(fontSize: 15, color: Colors.black87)) : Text("${_absence['data'][index]['employee']['first_name']} telah melakukan  ${_absence['data'][index]['type']}", style: TextStyle(fontSize: 15, color: Colors.black87)))
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
                                                    "${ DateFormat("dd/MM/yyyy hh:mm:ss").format(DateTime.parse(_absence['data'][index]['rejected_at']))}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black26))
                                                    : _absence['data'][index]['status'] == "approved"
                                                    ? Container(child: _absence['data'][index]['approved_at'] != null ? Text("${_absence['data'][index]['approved_at']}", style: TextStyle(fontSize: 15, color: Colors.black26)) : Text("${_absence['data'][index]['clock_in']}", style: TextStyle(fontSize: 15, color: Colors.black26)))
                                                    : Text(""))
                                                : Container(
                                                child: _absence['data'][index]['status'] == "pending"
                                                    ? Text("${_absence['data'][index]['clock_out']}", style: TextStyle(fontSize: 15, color: Colors.black26))
                                                    : _absence['data'][index]['status'] == "rejected"
                                                    ? Text("${ DateFormat("dd/MM/yyyy hh:mm:ss").format(DateTime.parse(_absence['data'][index]['rejected_at']))}", style: TextStyle(fontSize: 15, color: Colors.black26))
                                                    : _absence['data'][index]['status'] == "approved"
                                                    ? Container(child: _absence['data'][index]['approved_at'] != null ? Text("${_absence['data'][index]['approved_at']}", style: TextStyle(fontSize: 15, color: Colors.black26)) : Text("${_absence['data'][index]['clock_out']}", style: TextStyle(fontSize: 15, color: Colors.black26)))
                                                    : Text("")),
                                          ),
                                          InkWell(
                                            onTap: () {
                                               if (_absence['data'][index]
                                              ['type'] ==
                                                  "check in") {
                                              //   Navigator.push(
                                              //       context,
                                              //       MaterialPageRoute(
                                              //           builder: (context) =>
                                              //               detail_absence_admin(
                                              //                 status:
                                              //                 widget.type,
                                              //                 date: _absence[
                                              //                 'data']
                                              //                 [index]
                                              //                 ['date'],
                                              //                 id_attandance:
                                              //                 _absence['data']
                                              //                 [
                                              //                 index]
                                              //                 ['id'],
                                              //                 time: _absence[
                                              //                 'data']
                                              //                 [index]
                                              //                 ['clock_in'],
                                              //                 image: _absence[
                                              //                 'data']
                                              //                 [index]
                                              //                 ['image'],
                                              //                 latitude: _absence[
                                              //                 'data']
                                              //                 [index][
                                              //                 'clock_in_latitude'],
                                              //                 longitude: _absence[
                                              //                 'data']
                                              //                 [index][
                                              //                 'clock_in_longitude'],
                                              //                 type: _absence[
                                              //                 'data']
                                              //                 [index]
                                              //                 ['type'],
                                              //                 rejected_by: _absence['data']
                                              //                 [
                                              //                 index]
                                              //                 [
                                              //                 'rejected_by'] ==
                                              //                     null
                                              //                     ? null
                                              //                     : "${_absence['data'][index]['rejected_by']['first_name']} ${_absence['data'][index]['rejected_by']['last_name']}",
                                              //                 approved_by: _absence['data']
                                              //                 [
                                              //                 index]
                                              //                 [
                                              //                 'approved_by'] ==
                                              //                     null
                                              //                     ? null
                                              //                     : "${_absence['data'][index]['approved_by']['first_name']} ${_absence['data'][index]['approved_by']['last_name']}",
                                              //                 rejected_on: _absence[
                                              //                 'data']
                                              //                 [index][
                                              //                 'rejected_at'],
                                              //                 rejection_note:
                                              //                 _absence['data']
                                              //                 [
                                              //                 index]
                                              //                 [
                                              //                 'rejection_note'],
                                              //                 approval_note:
                                              //                 _absence['data']
                                              //                 [
                                              //                 index]
                                              //                 [
                                              //                 'approval_note'],
                                              //                 approved_on: _absence[
                                              //                 'data']
                                              //                 [index][
                                              //                 'approved_at'],
                                              //                 note: _absence[
                                              //                 'data']
                                              //                 [index]
                                              //                 ['note'],
                                              //                 category: _absence[
                                              //                 'data']
                                              //                 [index]
                                              //                 ['category'],
                                              //                 work_placement: _absence[
                                              //                 'data']
                                              //                 [
                                              //                 index]
                                              //                 [
                                              //                 'employee']
                                              //                 [
                                              //                 'work_placement'],
                                              //                 firts_name_employee:
                                              //                 _absence['data']
                                              //                 [
                                              //                 index]
                                              //                 [
                                              //                 'employee']
                                              //                 [
                                              //                 'first_name'],
                                              //                 last_name_employee:
                                              //                 _absence['data']
                                              //                 [
                                              //                 index]
                                              //                 [
                                              //                 'employee']
                                              //                 [
                                              //                 'last_name'],
                                              //                 office_latitude: _absence['data'][index]['office_latitude'],
                                              //                 office_longitude: _absence['data'][index]['office_longitude'],
                                              //               )));
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
                                                    child: _absence['data'][index]['office_latitude']!=null? Text(
                                                      "LIHAT DETAIL",
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
    ):Container();
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
      var  absence =_absence_data['data'].where((prod) => prod["present"] =="permission").toList();
      print(absence.length);

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
