
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magentahrdios/pages/Splash/splash.dart';
import 'package:magentahrdios/utalities/color.dart';

//baru


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
// init your dependency injection here
  runApp(MyApp());}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {


    return GetMaterialApp(
      title: 'Arzaya HRD ',
      color: baseColor,
      debugShowCheckedModeBanner: false,
      //iniliasasi route

      home:SplassScreen(),
    );
  }
}

