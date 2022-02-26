import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerAbsence extends StatefulWidget {
  ShimmerAbsence({Key? key}) : super(key: key);

  @override
  _ShimmerAbsenceState createState() => _ShimmerAbsenceState();
}

class _ShimmerAbsenceState extends State {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(5.0),
            child: Center(
              child: Shimmer.fromColors(
                  direction: ShimmerDirection.ltr,
                  period: Duration(seconds: 2),
                  child: Column(
                    children: [0, 1, 2, 4, 5, 6, 7]
                        .map((_) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context)
                                        .size
                                        .width /
                                        2,
                                    height: 20.0,
                                    color: Colors.white,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2.0),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2.0),
                                  ),
                                  Container(
                                    width: 100.0,
                                    height: 20.0,
                                    color: Colors.white,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2.0),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                      MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              right: 20),
                                          width: 70.0,
                                          height: 20.0,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ))
                        .toList(),
                  ),
                  baseColor: Colors.grey,
                  highlightColor: Colors.grey),
            )),
      ),
    );
  }
}


// Future upload() async {
//   var date = DateFormat("yyyy:MM:dd").format(DateTime.now());
//   if (_category_absent == null) {
//     _category_absent = "Present";
//   }
//   if (_category_absent.toString().toLowerCase() != 'present') {
//     if (base64.toString() == "null") {
//       Toast.show("Foto wajib digunakan", context,
//           duration: 5, gravity: Toast.BOTTOM);
//     } else if (Cremark.text.toString().isEmpty) {
//       Toast.show("Remarks tidak boleh kosong", context,
//           duration: 5, gravity: Toast.BOTTOM);
//     } else {
//       //Toast.show("$_category_absent", context);
//       validation_checkout(
//           context,
//           base64.toString(),
//           Cremark.text,
//           _lat.toString().trim(),
//           _long.toString().trim(),
//           _employee_id,
//           date,
//           time,
//           _departement_name,
//           _distance,
//           _lat_mainoffice,
//           _long_mainoffice,
//           _category_absent.toString().toLowerCase());
//     }
//   } else {
//     validation_checkout(
//         context,
//         base64.toString(),
//         Cremark.text,
//         _lat.toString().trim(),
//         _long.toString().trim(),
//         _employee_id,
//         date,
//         time,
//         _departement_name,
//         _distance,
//         _lat_mainoffice,
//         _long_mainoffice,
//         _category_absent.toString().toLowerCase());
//   }
// }