import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magentahrdios/pages/announcement/attachment.dart';
import 'package:magentahrdios/services/api_clien.dart';

import 'package:magentahrdios/utalities/color.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Files extends StatefulWidget {
  @override
  _FilesState createState() => _FilesState();
}

class _FilesState extends State<Files> {
  var sop,coe,isLoading=true,isLoading1=true;
  List? files;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDatapref();
    _companyFiles();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black87, //modify arrow color from here..
        ),
        backgroundColor: baseColor,
        title: Text(
          'Files',
          style: TextStyle(color: Colors.white),
        ),

      ),
      body: isLoading1==false?Container(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[

          Column(
            children: List.generate(files!.length, (index) {
              return _files(index);
            }),
          ),

              sop!=null?InkWell(
                onTap: (){
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: DetailAttachentPage(attachment: sop)));
                },
                child: Card(
                  child: Container(

                    width: Get.mediaQuery.size.width,
                    height: 100,
                    child: Container(
                      margin: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text("SOP", style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontFamily: "Roboto-regular",
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5),),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            child: Text("Menampilkan SOP perusahaan berdasarkan Divisi masing pegawai,tiap divisi mempunya SOP yang berbeda", style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 10,
                                fontFamily: "Roboto-regular",
                                fontWeight: FontWeight.w300,
                                letterSpacing: 0.5),),
                          )
                        ],
                      ),
                    ),
                  ),

                ),
              ):Container()
            ],
          ),
        ),
      ):Container(child: Center(child: CircularProgressIndicator(),),),

    );
  }

  Future _employee(id) async {
    setState(() {
      isLoading1=true;
    });

    final response = await http.get(Uri.parse("$base_url/api/employees/${id}"));
    final data = jsonDecode(response.body);


    if (data['code'] == 200) {


      setState(() {
        coe=data['data']['location']!=null?"${data['data']['location']['coe_attachment']}":null;
        sop=data['data']['designation']!=null?data['data']['designation']['file']!="1"?"${data['data']['designation']['file']}":null:null;
        isLoading1=false;

      });
    } else {}
  }

  Future _companyFiles() async {
    setState(() {

      isLoading==true;
    });

    final response = await http.get(Uri.parse("$base_url/api/companies/files"));
    final data = jsonDecode(response.body);
    print(data);


   setState(() {
     files=data;
     isLoading=false;
   });




  }


  void getDatapref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {

      var user_id = sharedPreferences.getString("user_id");
      _employee(user_id);
    });
  }
  Widget _files(index){
    return InkWell(
      onTap: (){
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft,
                child: DetailAttachentPage(attachment: files![index]['attachment'],title: "Tatatertib",)));

      },
      child: Card(
        child: Container(

          width: Get.mediaQuery.size.width,
          height: 100,
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text("${files![index]['title']}", style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: "Roboto-regular",
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5),),
                ),
                SizedBox(height: 10,),
                Container(
                  child: Text("${files![index]['description']}", style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 10,
                      fontFamily: "Roboto-regular",
                      fontWeight: FontWeight.w300,
                      letterSpacing: 0.5),),
                )
              ],
            ),
          ),
        ),

      ),
    );
  }
}
