import 'package:flutter/material.dart';
class ALlFeaturesAdminPgae extends StatefulWidget {
  @override
  _ALlFeaturesAdminPgaeState createState() => _ALlFeaturesAdminPgaeState();
}

class _ALlFeaturesAdminPgaeState extends State<ALlFeaturesAdminPgae> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black87, //modify arrow color from here..
        ),
        backgroundColor: Colors.white,
        title: Text(
          "Semua Fitur",
          style: TextStyle(color: Colors.black87),
        ),
      ),
    );
  }
}
