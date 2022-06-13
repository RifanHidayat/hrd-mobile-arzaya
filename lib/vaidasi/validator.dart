import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:magentahrdios/services/api_clien.dart';
import 'package:toast/toast.dart';

//     GMSServices.provideAPIKey("AIzaSyCJnyF9_FCUvQWnI_HmJrKiz1_bbmK9Y08")
class Validasi {
  Services services = new Services();

  //lvalidasi login employee
  void validation_login(
      BuildContext context, String username, String password) {
    if (username.isEmpty) {
      Toast.show("Username anda belum diisi", context,
          duration: 5, gravity: Toast.BOTTOM);
    } else if (password.isEmpty) {
      Toast.show("Password anda belum diisi", context,
          duration: 5, gravity: Toast.BOTTOM);
    } else {
      services.loginEmployee(context, username, password);
    }
  }

  //validasi transaction
  void validation_transaction(
      BuildContext context,
      var amount,
      date,
      note,
      event_id,
      budget_category_id,
      requested_by,
      image,
      var project_number,
      transaction_id,
      status_transaction,
      status,
      path) {
    if (amount.isEmpty) {
      Toast.show("jumlah uang belum diisi", context,
          duration: 5, gravity: Toast.BOTTOM);
    } else if (date.isEmpty) {
      Toast.show("Masukan tanggal transaksi", context,
          duration: 5, gravity: Toast.BOTTOM);
    } else {
      if (status == 'save') {
        services.expenseBudget(
            context,
            amount,
            date,
            note,
            event_id,
            budget_category_id,
            requested_by,
            image,
            project_number,
            "approved");
      } else if (status == 'update') {
        services.editTransaction(
            context,
            amount,
            date,
            note,
            event_id,
            budget_category_id,
            requested_by,
            image,
            project_number,
            transaction_id,
            status_transaction,
            path);
      } else if (status == 'repayment') {
        services.expenseBudget(context, amount, date, note, event_id,
            budget_category_id, requested_by, image, project_number, "pending");
      } else {
        print("tes");
      }
    }
  }

  ///validasi checkin
  void validation_checkin(
      BuildContext context,
      var photos,
      remark,
      lat,
      long,
      employee_id,
      date,
      time,
      departement_name,
      distance,
      office_latitude,
      office_longitude,
      categoryAbsence,
      category) {
    print("categort absence ${categoryAbsence}");
    // if (departement_name == "office") {
    //   if (category == "present") {
    //     if (distance <= 10) {
    //       if (photos.isEmpty) {
    //         Toast.show("Ambil terlebih dahulu photo anda", context,
    //             duration: 5, gravity: Toast.BOTTOM);
    //       } else if ((lat.toString() == "null") || (long.toString() == "null")) {
    //         Toast.show(
    //             "system tidak menemukan lokasi anda,aktifkan terlebih dahulu GPS device anda",
    //             context,
    //             duration: 5,
    //             gravity: Toast.BOTTOM);
    //       } else {
    //         services.checkin(
    //             context,
    //             photos,
    //             remark,
    //             employee_id,
    //             lat,
    //             long,
    //             date,
    //             time,
    //             "approved",
    //             office_latitude,
    //             office_longitude,
    //             category);
    //       }
    //     } else {
    //       Toast.show("Anda di luar radius perusahaan", context,
    //           duration: 5, gravity: Toast.BOTTOM);
    //     }
    //   } else {
    //     if (photos.isEmpty) {
    //       Toast.show("Ambil terlebih dahulu photo anda", context,
    //           duration: 5, gravity: Toast.BOTTOM);
    //     } else if ((lat.toString() == "null") || (long.toString() == "null")) {
    //       Toast.show(
    //           "system tidak menemukan lokasi anda,aktifkan terlebih dahulu GPS device anda",
    //           context,
    //           duration: 5,
    //           gravity: Toast.BOTTOM);
    //     } else if (remark.toString().isEmpty) {
    //       Toast.show("Remarks tidak boleh kosong", context,
    //           duration: 5, gravity: Toast.BOTTOM);
    //     } else {
    //       services.checkin(
    //           context,
    //           photos,
    //           remark,
    //           employee_id,
    //           lat,
    //           long,
    //           date,
    //           time,
    //           "pending",
    //           office_latitude,
    //           office_longitude,
    //           category);
    //     }
    //   }
    // } else {
    if ((lat.toString() == "null") || (long.toString() == "null")) {
      Toast.show(
          "system tidak menemukan lokasi anda,aktifkan terlebih dahulu GPS device anda",
          context,
          duration: 5,
          gravity: Toast.BOTTOM);
    } else {
      if (distance > 20) {
         if (photos != 'null') {
          print(photos.toString());
          if (remark.toString().isNotEmpty) {
            services.checkin(
                context,
                photos,
                remark,
                employee_id,
                lat,
                long,
                date,
                time,
                "approved",
                office_latitude,
                office_longitude,
                categoryAbsence,
                category);
          } else {
            Toast.show("Catatan wajib dimasukan", context,
                duration: 5, gravity: Toast.BOTTOM);
          }
       }
        else {
          Toast.show("Ambil terlebih dahulu photo anda", context,
              duration: 5, gravity: Toast.BOTTOM);
        }
      } else {
        services.checkin(context, photos, remark, employee_id, lat, long, date,
            time, "approved", office_latitude, office_longitude,categoryAbsence, category);
      }
    }
    // if ((category == "present")) {
    //   if (photos.isEmpty) {
    //     Toast.show("Ambil terlebih dahulu photo anda", context,
    //         duration: 5, gravity: Toast.BOTTOM);
    //   } else if ((lat.toString()=="null") || (long.toString() == "null")) {
    //     Toast.show(
    //         "system tidak menemukan lokasi anda,aktifkan terlebih dahulu GPS device anda",
    //         context,
    //         duration: 5,
    //         gravity: Toast.BOTTOM);
    //   } else {
    //     services.checkin(
    //         context,
    //         photos,
    //         remark,
    //         employee_id,
    //         lat,
    //         long,
    //         date,
    //         time,
    //         "approved",
    //         office_latitude,
    //         office_longitude,
    //         category);
    //   }
    // } else {
    //   if (photos.isEmpty) {
    //     Toast.show("Ambil terlebih dahulu photo anda", context,
    //         duration: 5, gravity: Toast.BOTTOM);
    //   } else if ((lat.toString()=="null") || (long.toString()=="null")) {
    //     Toast.show(
    //         "system tidak menemukan lokasi anda,aktifkan terlebih dahulu GPS device anda",
    //         context,
    //         duration: 5,
    //         gravity: Toast.BOTTOM);
    //   } else if (remark.toString().isEmpty) {
    //     Toast.show("Remarks tidak boleh kosong", context,
    //         duration: 5, gravity: Toast.BOTTOM);
    //   } else {
    //     services.checkin(
    //         context,
    //         photos,
    //         remark,
    //         employee_id,
    //         lat,
    //         long,
    //         date,
    //         time,
    //         "pending",
    //         office_latitude,
    //         office_longitude,
    //         category);
    //   }
    // }
    //}
  }

  ///check out
  void validation_checkout(
      BuildContext context,
      var photos,
      remark,
      lat,
      long,
      employee_id,
      date,
      time,
      departement_name,
      distance,
      office_latitude,
      office_longitude,
      category,isLembur) {
    if ((lat.toString() == "null") || (long.toString() == "null")) {
      Toast.show(
          "system tidak menemukan lokasi anda,aktifkan terlebih dahulu GPS device anda",
          context,
          duration: 5,
          gravity: Toast.BOTTOM);
    } else {
      if (distance > 20) {
        if (photos != 'null') {
          print(photos.toString());
          if (remark.toString().isNotEmpty) {
            services.checkout(
                context,
                photos,
                remark,
                employee_id,
                lat,
                long,
                date,
                time,
                "approved",
                office_latitude,
                office_longitude,
                category,isLembur);
          } else {
            Toast.show("Catatan wajib dimasukan", context,
                duration: 5, gravity: Toast.BOTTOM);
          }
        } else {
          Toast.show("Ambil terlebih dahulu photo anda", context,
              duration: 5, gravity: Toast.BOTTOM);
        }
      } else {
        services.checkout(context, photos, remark, employee_id, lat, long, date,
            time, "approved", office_latitude, office_longitude, category,isLembur);
      }
    }
    // if (departement_name == "office") {
    //   if (category == "present") {
    //     if (distance <= 10) {
    //       if (photos.isEmpty) {
    //         Toast.show("Ambil terlebih dahulu photo anda", context,
    //             duration: 5, gravity: Toast.BOTTOM);
    //       } else if ((lat.toString() == "null") ||
    //           (long.toString() == "null")) {
    //         Toast.show(
    //             "system tidak menemukan lokasi anda,aktifkan terlebih dahulu GPS device anda",
    //             context,
    //             duration: 5,
    //             gravity: Toast.BOTTOM);
    //       } else {
    //         services.checkout(
    //             context,
    //             photos,
    //             remark,
    //             employee_id,
    //             lat,
    //             long,
    //             date,
    //             time,
    //             "approved",
    //             office_latitude,
    //             office_longitude,
    //             category);
    //       }
    //     } else {
    //       Toast.show("Anda di luar radius perusahaan", context,
    //           duration: 5, gravity: Toast.BOTTOM);
    //     }
    //   } else {
    //     if (photos.isEmpty) {
    //       Toast.show("Ambil terlebih dahulu photo anda", context,
    //           duration: 5, gravity: Toast.BOTTOM);
    //     } else if ((lat.toString() == "null") || (long.toString() == "null")) {
    //       Toast.show(
    //           "system tidak menemukan lokasi anda,aktifkan terlebih dahulu GPS device anda",
    //           context,
    //           duration: 5,
    //           gravity: Toast.BOTTOM);
    //     } else if (remark.toString().isEmpty) {
    //       Toast.show("Remarks tidak boleh kosong", context,
    //           duration: 5, gravity: Toast.BOTTOM);
    //     } else {
    //       services.checkout(
    //           context,
    //           photos,
    //           remark,
    //           employee_id,
    //           lat,
    //           long,
    //           date,
    //           time,
    //           "pending",
    //           office_latitude,
    //           office_longitude,
    //           category);
    //     }
    //   }
    // } else {
    //   if ((category == "present")) {
    //     if (photos.isEmpty) {
    //       Toast.show("Ambil terlebih dahulu photo anda", context,
    //           duration: 5, gravity: Toast.BOTTOM);
    //     } else if ((lat.toString() == "null") || (long.toString() == "null")) {
    //       Toast.show(
    //           "system tidak menemukan lokasi anda,aktifkan terlebih dahulu GPS device anda",
    //           context,
    //           duration: 5,
    //           gravity: Toast.BOTTOM);
    //     } else {
    //       services.checkout(
    //           context,
    //           photos,
    //           remark,
    //           employee_id,
    //           lat,
    //           long,
    //           date,
    //           time,
    //           "approved",
    //           office_latitude,
    //           office_longitude,
    //           category);
    //     }
    //   } else {
    //     if (photos.isEmpty) {
    //       Toast.show("Ambil terlebih dahulu photo anda", context,
    //           duration: 5, gravity: Toast.BOTTOM);
    //     } else if ((lat == "null") || (long == "null")) {
    //       Toast.show(
    //           "system tidak menemukan lokasi anda,aktifkan terlebih dahulu GPS device anda",
    //           context,
    //           duration: 5,
    //           gravity: Toast.BOTTOM);
    //     } else if (remark.toString().isEmpty) {
    //       Toast.show("Remarks tidak boleh kosong", context,
    //           duration: 5, gravity: Toast.BOTTOM);
    //     } else {
    //       services.checkout(
    //           context,
    //           photos,
    //           remark,
    //           employee_id,
    //           lat,
    //           long,
    //           date,
    //           time,
    //           "pending",
    //           office_latitude,
    //           office_longitude,
    //           category);
    //     }
    //   }
    // }
  }

  void validation_change_password(BuildContext context, var password, username,
      email, id, confirm_password) {
    if (password.toString().length < 8) {
      Toast.show("password harus lebih dari 8 karakter", context,
          duration: 5, gravity: Toast.BOTTOM);
    } else if (password != confirm_password) {
      Toast.show("Password tidak cocok", context,
          duration: 5, gravity: Toast.BOTTOM);
    } else {
      services.change_password(context, password, username, email, id);
    }
  }

  ///leave
  void validation_leaves_submision(BuildContext context, var id, employee_id,
      date_of_filling, leaves_dates, description, action) {
    if (leaves_dates.length <= 0) {
      Toast.show("tanggal Cuti belum dipilih", context);
    } else {
      if (action == "submit") {
        services.leaveSubmission(
            context, employee_id, date_of_filling, leaves_dates, description);
      } else {
        services.leaveEdit(context, id, employee_id, date_of_filling,
            leaves_dates, description);
      }
    }
  }

  ///sick
  void validation_sick_submision(BuildContext context, var id, employee_id,
      date_of_filling, sick_dates, old_sick_dates, description, action) {
    if (sick_dates.length <= 0) {
      Toast.show("tanggal sakit belum dipilih", context);
    } else {
      if (action == "submit") {
        services.sickSubmission(
            context, employee_id, date_of_filling, sick_dates, description);
      } else {
        print(id);
        print(employee_id);
        print(date_of_filling);
        print(sick_dates);
        print(old_sick_dates);
        print(description);
        services.sickEdit(context, id, employee_id, date_of_filling, sick_dates,
            old_sick_dates, description);

      }
    }
  }

  //permission
  void validation_permission_submision(
      BuildContext context,
      var id,
      employee_id,
      date_of_filing,
      permission_dates,
      number_of_days,
      permission_category_id,
      description,
      old_permission_dates,
      action) {
    if (permission_dates.length <= 0) {
      Toast.show("tanggal Permission belum dipilih", context);
    } else {
      if (action == "submit") {
        //services.leaveSubmission(context, employee_id, date_of_filling, leaves_dates, description);
        services.permissionSubmission(
            context,
            employee_id,
            date_of_filing,
            permission_dates,
            number_of_days,
            permission_category_id,
            description);
      } else {
        //services.leaveEdit(context,id, employee_id, date_of_filling, leaves_dates, description);
        services.editpermissionSubmission(
            context,
            id,
            employee_id,
            date_of_filing,
            permission_dates,
            number_of_days,
            permission_category_id,
            old_permission_dates,
            description);
      }
    }
  }

  //validasi login
  void validation_login_admin(
      BuildContext context, String username, String password) {
    if (username.isEmpty) {
      Toast.show("Username anda belum diisi", context,
          duration: 5, gravity: Toast.BOTTOM);
    } else if (password.isEmpty) {
      Toast.show("Password anda belum diisi", context,
          duration: 5, gravity: Toast.BOTTOM);
    } else {
      services.loginAdmin(context, username, password);
    }
  }
}
