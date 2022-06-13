// import 'dart:io';
//
// import 'package:magentahrdios/services/api_clien.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:flutter/material.dart';
//
// class WebViewExample extends StatefulWidget {
//   var attachment;
//   WebViewExample({this.attachment});
//   @override
//   WebViewExampleState createState() => WebViewExampleState();
// }
//
// class WebViewExampleState extends State<WebViewExample> {
//   @override
//   void initState() {
//     super.initState();
//     // Enable virtual display.
//     if (Platform.isAndroid) WebView.platform = AndroidWebView();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WebView(
//       initialUrl: 'http://arzaya-hrd.s3.ap-southeast-1.amazonaws.com/announcement/a34CcDmngDC5WKpSXX00V5InkmWoL6wrQWsc0cwR.pdf',
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:magentahrdios/services/api_clien.dart';
import 'package:magentahrdios/utalities/color.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class CareerAttachmentPage extends StatefulWidget {
  var attachment,title;

  CareerAttachmentPage ({this.attachment,this.title});

  @override
  _CareerAttachmentPageState createState() => _CareerAttachmentPageState();
}

class _CareerAttachmentPageState extends State<CareerAttachmentPage > {
  String urlPDFPath = "";
  bool exists = true;
  int _totalPages = 0;
  int _currentPage = 0;
  bool pdfReady = false;
  PDFViewController? _pdfViewController;
  bool loaded = false;

  Future<File> getFileFromUrl(String url, {name}) async {
    var fileName = 'testonline';
    if (name != null) {
      fileName = name;
    }
    try {
      var data = await http.get(Uri.parse("${base_url}/api/${widget.attachment}"));
      var bytes = data.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/" + fileName + ".pdf");
      print(dir.path);
      File urlFile = await file.writeAsBytes(bytes);
      return urlFile;
    } catch (e) {
      throw Exception("Error opening url file");
    }
  }

  @override
  void initState() {
    print("url ${base_url}/api/${widget.attachment}");
    getFileFromUrl("http://www.africau.edu/images/default/sample.pdf").then(
          (value) => {
        setState(() {
          if (value != null) {
            urlPDFPath = value.path;
            loaded = true;
            exists = true;
          } else {
            exists = false;
          }
        })
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(urlPDFPath);
    if (loaded) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          // iconTheme: IconThemeData(
          //   color: Colors.white, //modify arrow color from here..
          // ),
          backgroundColor: baseColor,
          title: new Text(
            "${widget.title??"Lampiran"}",
            style: TextStyle(
                color: Colors.white,
                fontFamily: "Roboto-medium",
                fontSize: 18,
                letterSpacing: 0.5),
          ),
        ),
        body: PDFView(
          filePath: urlPDFPath,
          autoSpacing: true,
          enableSwipe: true,
          pageSnap: true,
          swipeHorizontal: true,
          nightMode: false,
          onError: (e) {
            //Show some error message or UI
          },
          onRender: (_pages) {
            setState(() {
              _totalPages = _pages!;
              pdfReady = true;
            });
          },
          onViewCreated: (PDFViewController vc) {
            setState(() {
              _pdfViewController = vc;
            });
          },
          // onPageChanged: (int page, int total) {
          //   setState(() {
          //     _currentPage = page;
          //   });
          // },
          onPageError: (page, e) {},
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.chevron_left),
              iconSize: 50,
              color: baseColor,
              onPressed: () {
                setState(() {
                  if (_currentPage > 0) {
                    _currentPage--;
                    _pdfViewController!.setPage(_currentPage);
                  }
                });
              },
            ),
            Text(
              "${_currentPage + 1}/$_totalPages",
              style: TextStyle(  color: baseColor, fontSize: 20),
            ),
            IconButton(
              icon: Icon(Icons.chevron_right),
              iconSize: 50,
              color: baseColor,
              onPressed: () {
                setState(() {
                  if (_currentPage < _totalPages - 1) {
                    _currentPage++;
                    _pdfViewController!.setPage(_currentPage);
                  }
                });
              },
            ),
          ],
        ),
      );
    } else {
      if (exists) {
        //Replace with your loading UI
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            // iconTheme: IconThemeData(
            //   color: Colors.white, //modify arrow color from here..
            // ),
            backgroundColor: baseColor,
            title: new Text(
              "Lampiran",
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Roboto-medium",
                  fontSize: 18,
                  letterSpacing: 0.5),
            ),
          ),
          body: Container(
            width: Get.mediaQuery.size.width,
            height: Get.mediaQuery.size.height,
            child: Center(
                child: CircularProgressIndicator(
                  color: baseColor,
                )),
          ),
        );
      } else {
        //Replace Error UI
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            // iconTheme: IconThemeData(
            //   color: Colors.white, //modify arrow color from here..
            // ),
            backgroundColor: baseColor,
            title: new Text(
              "Detail Pengumumman",
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Roboto-medium",
                  fontSize: 18,
                  letterSpacing: 0.5),
            ),
          ),
          body: Text(
            "PDF Not Available",
            style: TextStyle(fontSize: 20),
          ),
        );
      }
    }
  }
}
