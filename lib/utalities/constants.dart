import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:intl/intl.dart';
import 'package:magentahrdios/utalities/color.dart';

const version = "1.0";

const photo_profile='https://arenzha.s3.ap-southeast-1.amazonaws.com/photos/default-photo.png';




//constan textstyle
final paragraphStyle = TextStyle(
    color: Colors.black38,
    fontWeight: FontWeight.bold,
    fontFamily: 'OpenSans',
    fontSize: 15);

final titleStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontFamily: 'OpenSans',
    fontSize: 20);
final paragraphStyle1 =
TextStyle(color: Colors.black38, fontFamily: 'OpenSans', fontSize: 17);

final titleStyle1 =
TextStyle(color: Colors.black, fontFamily: 'OpenSans', fontSize: 20);

final header =
TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87);
//end contant textstyle

//constan icon menu
final Widget checkin = SvgPicture.asset("assets/check-in.svg",
    color: baseColor, semanticsLabel: 'Acme Logo');
final Widget checkout = SvgPicture.asset("assets/checkout.svg",
    color: baseColor, semanticsLabel: 'Acme Logo');
final Widget project = SvgPicture.asset("assets/project.svg",
    color: baseColor, semanticsLabel: 'Acme Logo');
final Widget absent = SvgPicture.asset(
  "assets/absent.svg",
  semanticsLabel: 'Acme Logo',
  color: baseColor,
);

final Widget task = SvgPicture.asset(
  "assets/task.svg",
  semanticsLabel: 'Acme Logo',
  color: baseColor,
);

final Widget taskIcon = SvgPicture.asset(
  "assets/task.svg",
  semanticsLabel: 'Acme Logo',
  width: 25,
  height: 25,

);

final Widget pyslip = SvgPicture.asset(
  "assets/pyslip.svg",
  semanticsLabel: 'Acme Logo',
  color: baseColor,
);
final Widget employees = SvgPicture.asset(
  "assets/employees.svg",
  semanticsLabel: 'Acme Logo',
  color: baseColor,
);
final Widget offwork = SvgPicture.asset(
  "assets/offwork.svg",
  semanticsLabel: 'Acme Logo',
  color: baseColor,
);
final Widget loan = SvgPicture.asset(
  "assets/loan.svg",
  semanticsLabel: 'Acme Logo',
  color: baseColor,
);
final Widget sick = SvgPicture.asset(
  "assets/sick.svg",
  semanticsLabel: 'Acme Logo',
  color: baseColor,
);
final Widget permission = SvgPicture.asset(
  "assets/permission.svg",
  semanticsLabel: 'Acme Logo',
  color: baseColor,
);

final Widget wellcome = SvgPicture.asset(
  "assets/wellcome.svg",
  semanticsLabel: 'Acme Logo',
);

final Widget login = SvgPicture.asset(
  "assets/login.svg",
  width: 200,
  height: 200,
  fit: BoxFit.fill,
  semanticsLabel: 'Acme Logo',
);

final Widget splassscreen = SvgPicture.asset(
  "assets/splassscreen.svg",
  semanticsLabel: 'Acme Logo',
);

final Widget pyslip_letter = SvgPicture.asset(
  "assets/receipt.svg",
  semanticsLabel: 'Acme Logo',
  color: Colors.black38,
  width: 60,
  height: 80,
);

final Widget male_avatar = SvgPicture.asset(
  "assets/male_avatar.svg",
  semanticsLabel: 'Acme Logo',
);

final Widget female_avatar = SvgPicture.asset(
  "assets/female_avatar.svg",
  semanticsLabel: 'Acme Logo',
);

// final Widget employee_profile = SvgPicture.asset(
//   "assets/employee_profile.svg",
//   semanticsLabel: 'Acme Logo',
// );
final Widget employee_profile =Image.network(photo_profile);

final Widget no_data_project = SvgPicture.asset(
  "assets/no_data_project.svg",
  semanticsLabel: 'Acme Logo',
  width: 150,
  height: 150,

);

final Widget no_data_payslip = SvgPicture.asset(
  "assets/nopayslip.svg",
  semanticsLabel: 'Acme Logo',
  width: 150,
  height: 150,



);
final Widget no_data_notification = SvgPicture.asset(
  "assets/notification.svg",
  semanticsLabel: 'Acme Logo',
  width: 150,
  height: 150,
  color: Colors.black38,
);

final Widget no_data_transacation = SvgPicture.asset(
  "assets/nobudget.svg",
  semanticsLabel: 'Acme Logo',
  width: 150,
  height: 150,
  color: Colors.black38,

);

final Widget gallery = SvgPicture.asset(
  "assets/gallery.svg",
  semanticsLabel: 'Acme Logo',
  width: 20,
  height: 20,
  color: Colors.white,
);
final Widget camera = SvgPicture.asset(
  "assets/camera.svg",
  width: 20,
  height: 20,
  color: Colors.white,
  semanticsLabel: 'Acme Logo',
);
final Widget google_maps = SvgPicture.asset(
  "assets/google-maps.svg",
  fit: BoxFit.fill,
  semanticsLabel: 'Acme Logo',
);

final Widget no_data_absence = SvgPicture.asset(
  "assets/no_data_project.svg",
  semanticsLabel: 'Acme Logo',
  width: 150,
  height: 150,

);
final Widget no_data_leave = SvgPicture.asset(
  "assets/leave.svg",
  semanticsLabel: 'Acme Logo',
  width: 150,
  height: 150,
  color: Colors.black38,
);

final Widget employee = Icon(
  Icons.supervised_user_circle_outlined,
  color: Colors.redAccent[100],
  size: 60,
);
final Widget budget = SvgPicture.asset("assets/budget.svg",
    color: baseColor, semanticsLabel: 'Acme Logo');
final Widget announcement = SvgPicture.asset("assets/announcement.svg",
    color: baseColor, semanticsLabel: 'Acme Logo');

final Widget no_data_announcement = SvgPicture.asset(
  "assets/announcement.svg",
  color: blackColor3,
  semanticsLabel: 'Acme Logo',
  width: 150,
  height: 150,
);

class Constants {
  static const String Buget = "Budget History";
  static const String Absence = "Status Kehadiran";
  static const String Leave = "Status Cuti";
  static const String Sick = "Status Sakit";
  static const String Permission = "Status Izin";
  static const List<String> choicesM = <String>[Buget];
  static const List<String> AbsenceStatus = <String>[Absence];
  static const List<String> LeaveStatus = <String>[Leave];
  static const List<String> SickStatus = <String>[Sick];
  static const List<String> PermissionStatus = <String>[Permission];

}

//--end constan icon
String readTimestamp(int timestamp) {
  var now = DateTime.now();
  var format = DateFormat('HH:mm a');
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  var diff = now.difference(date);
  var time = '';

  if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 || diff.inMinutes > 0 && diff.inHours == 0 || diff.inHours > 0 && diff.inDays == 0) {
    time = format.format(date);
  } else if (diff.inDays > 0 && diff.inDays < 7) {
    if (diff.inDays == 1) {
      time = diff.inDays.toString() + ' DAY AGO';
    } else {
      time = diff.inDays.toString() + ' DAYS AGO';
    }
  } else {
    if (diff.inDays == 7) {
      time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
    } else {

      time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
    }
  }


  return time;
}
String numberCurrency(jsonObject) {
  String string = NumberFormat.currency(locale: 'id', decimalDigits: 0)
      .format(jsonObject);

  return string;
}