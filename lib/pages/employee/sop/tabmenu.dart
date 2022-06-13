import 'package:flutter/material.dart';

import 'package:magentahrdios/pages/employee/career/career.dart';
import 'package:magentahrdios/pages/employee/career/review.dart';
import 'package:magentahrdios/pages/employee/sop/coe.dart';
import 'package:magentahrdios/pages/employee/sop/sop.dart';
import 'package:magentahrdios/utalities/color.dart';

class TabsmenuSOP extends StatelessWidget {
  List<Widget> containers = [

    SopPage(),
    CoePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black87, //modify arrow color from here..
          ),
          backgroundColor: baseColor,
          title: Text(
            'SOP & Tata Tertib',
            style: TextStyle(color: Colors.white),
          ),
          bottom: TabBar(
            labelColor: Colors.white,
            tabs: <Widget>[
              Tab(
                text: 'SOP',
              ),
              Tab(
                text: 'Tata Tertib',
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
