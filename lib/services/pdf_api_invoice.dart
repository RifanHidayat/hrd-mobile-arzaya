// import 'dart:io';
//
// import 'package:hrdmagenta/model/pdf.dart';
// import 'package:hrdmagenta/model/employee.dart';
// import 'package:hrdmagenta/model/invoice.dart';
// import 'package:hrdmagenta/model/supplier.dart';
//
// import 'package:hrdmagenta/services/pdf_pyslip_api.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:pdf/widgets.dart';
//
// class PdfInvoiceApi {
//   static Future<File> generate(Invoice invoice) async {
//     final pdf = Document();
//
//     pdf.addPage(MultiPage(
//       build: (context) => [
//         //buildHeader(invoice),
//         ///data employee
//         ///
//         buildTitle(invoice),
//         pw.Row(children: [
//           pw.Container(
//             child: ColumnLeft(invoice),
//           ),
//           pw.Container(
//             margin: EdgeInsets.only(left: 30),
//             child: ColumnRight(invoice),
//           )
//         ]),
//         buildInvoice(invoice),
//         pw.SizedBox(height: 20),
//         buildDeduction(invoice),
//
//         Divider(),
//         // buildTotal(invoice),
//       ],
//       // footer: (context) => buildFooter(invoice),
//     ));
//
//     return PdfApi.saveDocument(name: 'pyslip.pdf', pdf: pdf);
//   }
//
//   static Widget buildCustomerAddress(Pdf customer) => Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(customer.name, style: TextStyle(fontWeight: FontWeight.bold)),
//           Text(customer.address),
//         ],
//       );
//
//   static Widget namaEmployee(Customer customer) => Row(children: [
//         Container(width: 80, child: Text("Nama")),
//         Container(margin: pw.EdgeInsets.only(left: 50), child: Text(":")),
//         Container(child: Text(customer.name.toString()))
//       ]);
//
//   static Widget EmployeeID(Customer customer) => Row(children: [
//         Container(width: 80, child: Text("Employee ID")),
//         Container(margin: pw.EdgeInsets.only(left: 50), child: Text(":")),
//         Container(child: Text(customer.employee_id.toString()))
//       ]);
//
//   static Widget Bagina(Customer customer) => Row(children: [
//         Container(width: 80, child: Text("Bagian")),
//         Container(margin: pw.EdgeInsets.only(left: 50), child: Text(":")),
//         Container(child: Text(customer.bagian.toString()))
//       ]);
//
//   static Widget JobTitle(Customer customer) => Row(children: [
//         Container(width: 80, child: Text("Job Title")),
//         Container(margin: pw.EdgeInsets.only(left: 50), child: Text(":")),
//         Container(child: Text(customer.bagian.toString()))
//       ]);
//
//   static Widget StatusKaryawan(Customer customer) => Row(children: [
//         Container(width: 120, child: Text("Status Karyawan")),
//         Container(margin: pw.EdgeInsets.only(left: 50), child: Text(":")),
//         Container(child: Text(customer.job_title.toString()))
//       ]);
//
//   static Widget StatusPTKP(Customer customer) => Row(children: [
//         Container(width: 120, child: Text("Status PTKP")),
//         Container(margin: pw.EdgeInsets.only(left: 50), child: Text(":")),
//         Container(child: Text(customer.status_ptkp.toString()))
//       ]);
//
//   static Widget TanggalBergabung(Customer customer) => Row(children: [
//         Container(width: 120, child: Text("Tanggal Bergabung")),
//         Container(margin: pw.EdgeInsets.only(left: 50), child: Text(":")),
//         Container(child: Text(customer.tgl_bergabung.toString()))
//       ]);
//
//   static Widget LamaBekerja(Customer customer) => Row(children: [
//         Container(width: 120, child: Text("Lama bekerja")),
//         Container(margin: pw.EdgeInsets.only(left: 50), child: Text(":")),
//         Container(child: Text(customer.lama_bekerja.toString()))
//       ]);
//
//   static Widget ColumnLeft(Invoice invoice) =>
//       Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
//         namaEmployee(invoice.customer),
//         pw.SizedBox(height: 5),
//         EmployeeID(invoice.customer),
//         pw.SizedBox(height: 5),
//         Bagina(invoice.customer),
//         pw.SizedBox(height: 5),
//         JobTitle(invoice.customer),
//         pw.SizedBox(height: 20),
//       ]);
//
//   static Widget ColumnRight(Invoice invoice) =>
//       Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
//         StatusKaryawan(invoice.customer),
//         pw.SizedBox(height: 5),
//         StatusPTKP(invoice.customer),
//         pw.SizedBox(height: 5),
//         TanggalBergabung(invoice.customer),
//         pw.SizedBox(height: 5),
//         LamaBekerja(invoice.customer),
//         pw.SizedBox(height: 20),
//       ]);
//
//   static Widget buildTitle(Invoice invoice) => Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             '22 November 2020',
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),
//           ),
//           SizedBox(height: 0.8 * PdfPageFormat.cm),
//           SizedBox(height: 0.8 * PdfPageFormat.cm),
//         ],
//       );
//
//   static Widget buildInvoice(Invoice invoice) {
//     final headers = [
//       'Income',
//       'Ammount',
//     ];
//     final data = invoice.items.map((item) {
//       return [
//         item.name,
//         //Utils.formatDate(item.date),
//         item.income
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
//
//   }
//
//   static Widget buildDeduction(Invoice invoice) {
//     final headers = [
//       'Dedcution',
//       'Ammount',
//     ];
//     final data1 = invoice.itemss.map((item) {
//       return [item.description, item.unitPrice];
//     }).toList();
//
//     return Table.fromTextArray(
//       headers: headers,
//       data: data1,
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
//   // static Widget buildTotal(Invoice invoice) {
//   //   final netTotal = invoice.items
//   //       .map((item) => item.unitPri * item.quantity)
//   //       .reduce((item1, item2) => item1 + item2);
//   //   final vatPercent = invoice.items.first.vat;
//   //   final vat = netTotal * vatPercent;
//   //   final total = netTotal + vat;
//   //
//   //   return Container(
//   //     alignment: Alignment.centerRight,
//   //     child: Row(
//   //       children: [
//   //         Spacer(flex: 1),
//   //         Expanded(
//   //           flex: 4,
//   //           child: Column(
//   //             crossAxisAlignment: CrossAxisAlignment.start,
//   //             children: [
//   //               buildText(
//   //                 title: 'Total Income',
//   //                 value: Utils.formatPrice(netTotal),
//   //                 unite: true,
//   //               ),
//   //               buildText(
//   //                 title: 'Vat ${vatPercent * 100} %',
//   //                 value: Utils.formatPrice(vat),
//   //                 unite: true,
//   //               ),
//   //               Divider(),
//   //               buildText(
//   //                 title: 'Total amount due',
//   //                 titleStyle: TextStyle(
//   //                   fontSize: 14,
//   //                   fontWeight: FontWeight.bold,
//   //                 ),
//   //                 value: Utils.formatPrice(total),
//   //                 unite: true,
//   //               ),
//   //               SizedBox(height: 2 * PdfPageFormat.mm),
//   //               Container(height: 1, color: PdfColors.grey400),
//   //               SizedBox(height: 0.5 * PdfPageFormat.mm),
//   //               Container(height: 1, color: PdfColors.grey400),
//   //             ],
//   //           ),
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }
//
//   static Widget buildFooter(Invoice invoice) => Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Divider(),
//           SizedBox(height: 2 * PdfPageFormat.mm),
//           buildSimpleText(title: 'Address', value: invoice.supplier.address),
//           SizedBox(height: 1 * PdfPageFormat.mm),
//           buildSimpleText(title: 'Paypal', value: invoice.supplier.paymentInfo),
//         ],
//       );
//
//   static buildSimpleText({
//     String title,
//     String value,
//   }) {
//     final style = TextStyle(fontWeight: FontWeight.bold);
//
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: pw.CrossAxisAlignment.end,
//       children: [
//         Text(title, style: style),
//         SizedBox(width: 2 * PdfPageFormat.mm),
//         Text(value),
//       ],
//     );
//   }
//
//   static buildText({
//     String title,
//     String value,
//     double width = double.infinity,
//     TextStyle titleStyle,
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
