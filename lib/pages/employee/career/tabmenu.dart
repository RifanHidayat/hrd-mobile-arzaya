import 'package:flutter/material.dart';

import 'package:magentahrdios/pages/employee/career/career.dart';
import 'package:magentahrdios/pages/employee/career/review.dart';
import 'package:magentahrdios/utalities/color.dart';

class TabsmenuCareer extends StatelessWidget {
  List<Widget> containers = [

    ReviewPage(),
    CareerPage(),
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
            'Review & Karir',
            style: TextStyle(color: Colors.white),
          ),
          bottom: TabBar(
            labelColor: Colors.white,
            tabs: <Widget>[
              Tab(
                text: 'Review',
              ),
              Tab(
                text: 'karir',
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
