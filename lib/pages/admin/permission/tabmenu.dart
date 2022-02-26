import 'package:flutter/material.dart';

import 'package:magentahrdios/pages/admin/permission/list.dart';
import 'package:magentahrdios/utalities/color.dart';

class TabmenuPermissionPageAdmin extends StatelessWidget {
  List<Widget> containers = [
    ListPermissionPageAdmin(
      status: "pending",
    ),
    ListPermissionPageAdmin(
      status: "rejected",
    ),
    ListPermissionPageAdmin(
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
              'Pengajuan Izin',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Roboto-medium",
                  fontSize: 18,
                  letterSpacing: 0.5),
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
      ),
    );
  }
}
