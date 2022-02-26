import 'package:flutter/material.dart';
import 'package:magentahrdios/pages/admin/leave/offwork_status.dart';
import 'package:magentahrdios/utalities/color.dart';

class TabsMenuOffworkAdmin extends StatelessWidget {
  List<Widget> containers = [
    LeaveListStatusAdmin(
      status: "pending",
    ),
    LeaveListStatusAdmin(
      status: "rejected",
    ),
    LeaveListStatusAdmin(
      status: "approved",
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
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.of(context).pop('update'),
            ),
            backgroundColor: baseColor,
            title: Text(
              'Pengajuan Cuti',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Roboto-medium",
                  fontSize: 18,
                  letterSpacing: 0.5),
            ),
            bottom: TabBar(
              labelColor: Colors.white,
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
