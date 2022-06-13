import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:magentahrdios/pages/Splash/splash.dart';
import 'package:magentahrdios/pages/announcement/detail.dart';
import 'package:magentahrdios/utalities/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialize firebase
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

Future showNotification(info, message) async {
  //flutterTts.speak(info);
  // print("data notif ${message}");
  RemoteNotification notification = message.notification;
  AndroidNotification android = message.notification?.android;

  flutterLocalNotificationsPlugin.show(
      0,
      notification.title,
      info,
      NotificationDetails(
        android: AndroidNotificationDetails("0", "gempa",
            playSound: true,
            priority: Priority.high,
            importance: Importance.high,
            icon: '@mipmap/ic_launcher'

            // TODO add a proper drawable resource to android, for now using
            //      one that already exists in example app.
            ),
      ),
      payload: "${message}");
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  var info = message.data['body'];
  showNotification(info, message);

  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var employeeId, latitude, longitude, currentAddress;
  Position? _currentPosition;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.instance.getToken().then((value) {
      print("token ${value}");
    });
    setupInteractedMessage();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      color: baseColor,
      debugShowCheckedModeBanner: false,
      title: 'HRD Arzaya',
      home: SplassScreen(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }

  //function

  Future showNotification(info, message) async {
    //flutterTts.speak(info);
    // print("data notif ${message}");
    RemoteNotification notification = message.notification;
    AndroidNotification android = message.notification?.android;

    flutterLocalNotificationsPlugin.show(
        0,
        notification.title,
        info,
        NotificationDetails(
          android: AndroidNotificationDetails("0", "gempa",
              playSound: true,
              priority: Priority.high,
              importance: Importance.high,
              icon: '@mipmap/ic_launcher'

              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              ),
        ),
        payload: "${message}");
  }

    Future<void> setupInteractedMessage() async {
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = new IOSInitializationSettings();
    var initSetttings = new InitializationSettings(android: android, iOS: iOS);
    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onSelectNotification);
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("${message.data['body']}");
      var info = message.data['body'];


      showNotification(info, message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);

    // you can just pass the function like this
   // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await FirebaseMessaging.instance.subscribeToTopic('TopicToListen');

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void _handleMessage(RemoteMessage message) {

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AnnouncementDetail(
                description: message.data['description'],
                title: message.data['title'],
                attachment: message.data['attachment'],
                createdAt: message.data['created_at'],
              )),
    );
  }

  Future onSelectNotification(var payload) async {
    String jsonsDataString = payload.toString(); // toString of Response's body is assigned to jsonDataString

   //  final _dataa=jsonDecode(jsonsDataString);
   //  print(_dataa['data']);
   //
   // Get.to(AnnouncementDetail(
   //   title: "tes",
   //   description: "tes",
   //   attachment: "tes",
   //   createdAt: "2022-11-1",
   // ));
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    var info = message.data['body'];
    showNotification(info, message);


    await Firebase.initializeApp();

    print("Handling a background message: ${message.messageId}");
  }
}

//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:magentahrdios/pages/Splash/splash.dart';
// import 'package:magentahrdios/utalities/color.dart';
//
// //baru
//
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
// // init your dependency injection here
//   runApp(MyApp());}
// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     return GetMaterialApp(
//       title: 'Arzaya HRD ',
//       color: baseColor,
//       debugShowCheckedModeBanner: false,
//       //iniliasasi route
//
//       home:SplassScreen(),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
//
//
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key,required this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   String urlPDFPath = "";
//   bool exists = true;
//   int _totalPages = 0;
//   int _currentPage = 0;
//   bool pdfReady = false;
//   PDFViewController? _pdfViewController;
//   bool loaded = false;
//
//   Future<File> getFileFromUrl(String url, {name}) async {
//     var fileName = 'testonline';
//     if (name != null) {
//       fileName = name;
//     }
//     try {
//       var data = await http.get(Uri.parse("https://arzaya-hrd.s3.ap-southeast-1.amazonaws.com/announcement/a34CcDmngDC5WKpSXX00V5InkmWoL6wrQWsc0cwR.pdf"));
//       var bytes = data.bodyBytes;
//       var dir = await getApplicationDocumentsDirectory();
//       File file = File("${dir.path}/" + fileName + ".pdf");
//       print(dir.path);
//       File urlFile = await file.writeAsBytes(bytes);
//       return urlFile;
//     } catch (e) {
//       throw Exception("Error opening url file");
//     }
//   }
//
//
//
//   @override
//   void initState() {
//
//     getFileFromUrl("http://www.africau.edu/images/default/sample.pdf").then(
//           (value) => {
//         setState(() {
//           if (value != null) {
//             urlPDFPath = value.path;
//             loaded = true;
//             exists = true;
//           } else {
//             exists = false;
//           }
//         })
//       },
//     );
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     print(urlPDFPath);
//     if (loaded) {
//       return Scaffold(
//         body: PDFView(
//           filePath: urlPDFPath,
//           autoSpacing: true,
//           enableSwipe: true,
//           pageSnap: true,
//           swipeHorizontal: true,
//           nightMode: false,
//           onError: (e) {
//             //Show some error message or UI
//           },
//           onRender: (_pages) {
//             setState(() {
//               _totalPages = _pages!;
//               pdfReady = true;
//             });
//           },
//           onViewCreated: (PDFViewController vc) {
//             setState(() {
//               _pdfViewController = vc;
//             });
//           },
//           // onPageChanged: (int page, int total) {
//           //   setState(() {
//           //     _currentPage = page;
//           //   });
//           // },
//           onPageError: (page, e) {},
//         ),
//         floatingActionButton: Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: <Widget>[
//             IconButton(
//               icon: Icon(Icons.chevron_left),
//               iconSize: 50,
//               color: Colors.black,
//               onPressed: () {
//                 setState(() {
//                   if (_currentPage > 0) {
//                     _currentPage--;
//                     _pdfViewController!.setPage(_currentPage);
//                   }
//                 });
//               },
//             ),
//             Text(
//               "${_currentPage + 1}/$_totalPages",
//               style: TextStyle(color: Colors.black, fontSize: 20),
//             ),
//             IconButton(
//               icon: Icon(Icons.chevron_right),
//               iconSize: 50,
//               color: Colors.black,
//               onPressed: () {
//                 setState(() {
//                   if (_currentPage < _totalPages - 1) {
//                     _currentPage++;
//                     _pdfViewController!.setPage(_currentPage);
//                   }
//                 });
//               },
//             ),
//           ],
//         ),
//       );
//     } else {
//       if (exists) {
//         //Replace with your loading UI
//         return Scaffold(
//           appBar: AppBar(
//             title: Text("Demo"),
//           ),
//           body: Text(
//             "Loading..",
//             style: TextStyle(fontSize: 20),
//           ),
//         );
//       } else {
//         //Replace Error UI
//         return Scaffold(
//           appBar: AppBar(
//             title: Text("Demo"),
//           ),
//           body: Text(
//             "PDF Not Available",
//             style: TextStyle(fontSize: 20),
//           ),
//         );
//       }
//     }
//   }
// }
