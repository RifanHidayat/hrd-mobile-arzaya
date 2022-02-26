import 'package:flutter/material.dart';

import 'package:magentahrdios/pages/admin/task/ListTask.dart';

class Tabstask extends StatelessWidget {

  List<Widget> containers = [
    ListTask( category: "Pending",),
    ListTask(category: "Reject",),
    ListTask(category: "Approve",),

  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent[100],
          title: Text('Task'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: 'PENDING',
              ),
              Tab(
                text: 'REJECT',
              ),

              Tab(
                text: 'APPROVE',
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