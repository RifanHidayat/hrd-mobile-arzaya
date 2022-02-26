
import 'package:flutter/material.dart';

import 'package:magentahrdios/pages/admin/absence/approved.dart';
import 'package:magentahrdios/pages/admin/absence/pending.dart';
import 'package:magentahrdios/pages/admin/absence/rejected.dart';





class TabsAbsenceAdmin extends StatelessWidget {


  List<Widget> containers = [
    PendingAbsenceAdminPage(
      type: "pending",
    ),
    RejectedAbsenceAdminPage(
      type: "rejected",
    ),
    ApprovedAbsenceAdminPage(
      type: "approved",
    ),
  ];



  @override
  Widget build(BuildContext context) {
    Future<bool> _willPopCallback() async {
      Navigator.of(context).pop('update');
      return true;
    }

    return WillPopScope(
      onWillPop: _willPopCallback,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop("update"),
            ),

            backgroundColor: Colors.white,
            title: Text('Kehadiran',
              style: TextStyle(color: Colors.black87),

            ),
            bottom: TabBar(
              labelColor: Colors.black87,
              tabs: <Widget>[

                Tab(
                  text: 'PENDING',
                ),
                Tab(
                  text: 'REJECTED',
                ),
                Tab(
                  text: 'APPROVED',
                ),

              ],
            ),
          ),
          body: TabBarView(
            children: containers,
          ),
        ),
      ),
    );
  }
}