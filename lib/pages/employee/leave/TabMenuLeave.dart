import 'package:flutter/material.dart';
import 'package:magentahrdios/pages/employee/leave/LeaveStatus.dart';
import 'package:magentahrdios/utalities/color.dart';


class TabsMenuLeavestatus extends StatelessWidget {
  final navigatorKey = GlobalKey<NavigatorState>();
  List<Widget> containers = [
    LeaveListStatus(
      status: "pending",
    ),
    LeaveListStatus(status: "rejected",
    ),
    LeaveListStatus(
      status: "approved",
    )
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop('update'),
          ),
          backgroundColor: baseColor,
          title: Text(
            'Status Pengajuan  Cuti',
            style: TextStyle(color: Colors.white,letterSpacing: 0.5,fontSize: 16,fontFamily: "Roboto-medium"),
          ),
          bottom: TabBar(
            labelColor:Colors.white,
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
    );
  }
}
