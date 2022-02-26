import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magentahrdios/pages/admin/project/shimmer_project.dart';
import 'package:magentahrdios/pages/employee/leave/TabMenuLeave.dart';
import 'package:magentahrdios/utalities/color.dart';
import 'package:magentahrdios/utalities/constants.dart';


import 'package:shared_preferences/shared_preferences.dart';

class AnnouncementListEmployee extends StatefulWidget {
  AnnouncementListEmployee({this.status});

  var status;

  @override
  _AnnouncementListEmployeeState createState() =>
      _AnnouncementListEmployeeState();
}

class _AnnouncementListEmployeeState extends State<AnnouncementListEmployee> {
  //variable
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  var user_id;

  Map? _projects;
  bool _loading = false;

  Widget _buildnodata() {
    return Container(
      height: MediaQuery.of(context).size.height - 150,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: no_data_announcement,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                child: Text(
                  "Belum ada pengumuman ",
                  style: TextStyle(color: Colors.black38, fontSize: 18),
                )),
          ],
        ),
      ),
    );
  }

//main contex---------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black87, //modify arrow color from here..
        ),
        backgroundColor: Colors.white,
        title: new Text(
          "Pengumuman",
          style: TextStyle(color: Colors.black87),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => AddAnnouncement()));
        },
        child: Icon(Icons.add),
        backgroundColor: btnColor1,
      ),
      body: RefreshIndicator(
        child: Container(
          child: Container(
            color: Colors.white38,
            child: Container(
              child: _loading
                  ? Center(
                child: ShimmerProject(),
              )
                  : ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, indext) {
                    return _buildnodata();
                  }),
            ),
          ),
        ),
        onRefresh: getDatapref,
      ),
    );
  }

  Future getDatapref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      user_id = sharedPreferences.getString("user_id");
    });
  }

  @override
  void initState() {
    super.initState();
    //show modal detail project
    getDatapref();
  }

  void choiceAction(String choice) {
    if (choice == Constants.Leave) {
      Get.testMode = true;

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TabsMenuLeavestatus()),
      );

      //print(choice);

    }
  }
}
