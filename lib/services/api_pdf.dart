// import 'dart:convert';
// import 'dart:io';
//
//
//
// import 'package:intl/intl.dart';
// import 'package:magentahrdios/models/invoice.dart';
// import 'package:magentahrdios/models/pdf.dart';
// import 'package:magentahrdios/services/pdf_pyslip_api.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:pdf/widgets.dart';
//
// class PdfPyslipApi {
//   static Future<File> generate(
//       var income, var deduction,var totalIncome,totalDeduction,var totalTakeHomePay,var period, Invoice invoice) async {
//     final pdf = Document();
//
//     pdf.addPage(MultiPage(
//       build: (context) => [
//         buildTitle(period),
//         pw.Row(children: [
//           pw.Container(
//             child: ColumnLeft(invoice),
//           ),
//           pw.Container(
//             margin: EdgeInsets.only(left: 30),
//             child: ColumnRight(invoice),
//           )
//         ]),
//         buildIncome(income),
//         buildtotalincome(totalIncome),
//
//         pw.SizedBox(height: 20),
//         buildDeduction(deduction),
//         buildtotaldeduction(totalDeduction, totalTakeHomePay),
//       ],
//       // footer: (context) => buildFooter(invoice),
//     ));
// var tes=totalDeduction.toString();
//     return PdfApi.saveDocument(name: 'Slip Gajii bulanan .pdf', pdf: pdf);
//   }
//
//   static Widget buildTitle(var datetime) => Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             '${datetime}',
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 0.8 * PdfPageFormat.cm),
//           SizedBox(height: 0.8 * PdfPageFormat.cm),
//         ],
//       );
//
//   // static Widget buildCustomerAddress(Pdf pdf) => Column(
//   //       crossAxisAlignment: CrossAxisAlignment.start,
//   //       children: [
//   //         Text(customer.name, style: TextStyle(fontWeight: FontWeight.bold)),
//   //         Text(customer.address),
//   //       ],
//   //     );
//
//   static Widget namaEmployee(Pdf customer) => Row(children: [
//         Container(width: 70, child: Text("Nama")),
//         Container(margin: pw.EdgeInsets.only(left: 10), child: Text(": ")),
//         Container(child: Text(customer.name.toString()))
//       ]);
//
//   static Widget EmployeeID(Pdf customer) => Row(children: [
//         Container(width: 70, child: Text("Employee ID")),
//         Container(margin: pw.EdgeInsets.only(left: 10), child: Text(": ")),
//         Container(child: Text(customer.employee_id.toString()))
//       ]);
//
//   static Widget Division(Pdf customer) => Row(children: [
//         Container(width: 70, child: Text("Divisi")),
//         Container(margin: pw.EdgeInsets.only(left: 10), child: Text(": ")),
//         Container(child: Text(customer.division.toString()))
//       ]);
//
//   static Widget Departement(Pdf customer) => Row(children: [
//         Container(width: 120, child: Text("Departemen")),
//         Container(margin: pw.EdgeInsets.only(left: 5), child: Text(": ")),
//         Container(child: Text(customer.departement.toString()))
//       ]);
//
//   static Widget StatusKaryawan(Pdf customer) => Row(children: [
//         Container(width: 120, child: Text("Status Karyawan")),
//         Container(margin: pw.EdgeInsets.only(left: 5), child: Text(": ")),
//         Container(child: Text(customer.status_karyawan.toString()))
//       ]);
//
//   static Widget JobTitle(Pdf customer) => Row(children: [
//         Container(width: 120, child: Text("Baigian")),
//         Container(margin: pw.EdgeInsets.only(left: 5), child: Text(": ")),
//         Container(child: Text(customer.job_title.toString()))
//       ]);
//
//
//
//   // static Widget LamaBekerja(Pdf customer) => Row(children: [
//   //       Container(width: 120, child: Text("Lama bekerja")),
//   //       Container(margin: pw.EdgeInsets.only(left: 5), child: Text(":")),
//   //       Container(child: Text(customer.lama_bekerja.toString()))
//   //     ]);
//
//   static Widget ColumnLeft(Invoice invoice) =>
//       Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
//         namaEmployee(invoice.pdf),
//         pw.SizedBox(height: 5),
//         EmployeeID(invoice.pdf),
//         pw.SizedBox(height: 5),
//         Division(invoice.pdf),
//         pw.SizedBox(height: 20),
//       ]);
//
//   static Widget ColumnRight(Invoice invoice) =>
//       Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
//         Departement(invoice.pdf),
//         pw.SizedBox(height: 5),
//         JobTitle(invoice.pdf),
//         pw.SizedBox(height: 5),
//         StatusKaryawan(invoice.pdf),
//
//         pw.SizedBox(height: 20),
//       ]);
//
//   static Widget buildIncome(List invoice) {
//     final headers = [
//       'Income',
//       'Ammount',
//     ];
//     final data = invoice.map((item) {
//       return [
//         item['name'],
//         //Utils.formatDate(item.date),
//         NumberFormat.currency(locale: 'id', decimalDigits: 0)
//             .format(int.parse(item['value'].toString()))
//       ];
//     }).toList();
//     // NumberFormat.currency(locale: 'id', decimalDigits: 0)
//     //     .format(item['value'])
//     return Table.fromTextArray(
//       headers: headers,
//       data: data,
//       border: null,
//       headerStyle: TextStyle(fontWeight: FontWeight.bold),
//       headerDecoration: BoxDecoration(color: PdfColors.grey300),
//       cellHeight: 30,
//       cellAlignments: {
//         0: Alignment.centerLeft,
//         1: Alignment.centerRight,
//         2: Alignment.centerRight,
//         3: Alignment.centerRight,
//         4: Alignment.centerRight,
//       },
//     );
//   }
//
//   static Widget buildtotalincome(var totalIncome) {
//
//
//     return Container(
//       alignment: Alignment.centerRight,
//       child: Row(
//         children: [
//
//           Expanded(
//             flex: 4,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//
//                 Divider(),
//                 buildText(
//                   title: 'Total Income',
//                   titleStyle: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   value: "${totalIncome}",
//                   unite: true,
//                 ),
//                 SizedBox(height: 2 * PdfPageFormat.mm),
//                 Container(height: 1, color: PdfColors.grey400),
//                 SizedBox(height: 0.5 * PdfPageFormat.mm),
//                 Container(height: 1, color: PdfColors.grey400),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//   static Widget buildtotaldeduction(var totalDeduction,var takehomepay,) {
//
//
//     return Container(
//       alignment: Alignment.centerRight,
//       child: Row(
//         children: [
//
//           Expanded(
//             flex: 4,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//
//                 Divider(),
//                 buildText(
//                   title: 'Total deduction',
//                   titleStyle: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   value: "${totalDeduction}",
//                   unite: true,
//                 ),
//
//                 Divider(),
//                 buildText(
//                   title: 'Take Home Pay',
//                   titleStyle: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   value: "${takehomepay}",
//                   unite: true,
//                 ),
//                 SizedBox(height: 2 * PdfPageFormat.mm),
//                 Container(height: 1, color: PdfColors.grey400),
//                 SizedBox(height: 0.5 * PdfPageFormat.mm),
//                 Container(height: 1, color: PdfColors.grey400),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   static Widget buildDeduction(List invoice) {
//     final headers = [
//       'Deduction',
//       'Amount',
//     ];
//     final data = invoice.map((item) {
//       return [
//         item['name'],
//         //Utils.formatDate(item.date),
//         NumberFormat.currency(locale: 'id', decimalDigits: 0)
//             .format(int.parse(item['value'].toString()))
//       ];
//     }).toList();
//
//     return Table.fromTextArray(
//       headers: headers,
//       data: data,
//       border: null,
//       headerStyle: TextStyle(fontWeight: FontWeight.bold),
//       headerDecoration: BoxDecoration(color: PdfColors.grey300),
//       cellHeight: 30,
//       cellAlignments: {
//         0: Alignment.centerLeft,
//         1: Alignment.centerRight,
//         2: Alignment.centerRight,
//         3: Alignment.centerRight,
//         4: Alignment.centerRight,
//       },
//     );
//   }
//
//   String numberCurrency(jsonObject) {
//     String string = NumberFormat.currency(locale: 'id', decimalDigits: 0)
//         .format(jsonObject);
//
//     return string;
//   }
//
//   static buildText({
//     String? title,
//     String? value,
//     double width = double.infinity,
//     TextStyle? titleStyle,
//     bool unite = false,
//   }) {
//     final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);
//
//     return Container(
//       width: width,
//       child: Row(
//         children: [
//           Expanded(child: Text(title, style: style)),
//           Text(value, style: unite ? style : null),
//         ],
//       ),
//     );
//   }
// }
