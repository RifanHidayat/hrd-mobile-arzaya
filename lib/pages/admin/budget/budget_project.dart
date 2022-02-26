// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:hrdmagenta/page/employee/budget/detail_budget.dart';
// import 'package:hrdmagenta/page/employee/budget/expense.dart';
// import 'package:hrdmagenta/page/employee/budget/shimmer_effect.dart';
// import 'package:hrdmagenta/page/employee/budget/tabmenu_budget.dart';
// import 'package:hrdmagenta/services/api_clien.dart';
// import 'package:hrdmagenta/utalities/color.dart';
// import 'package:hrdmagenta/utalities/constants.dart';
// import 'package:http/http.dart' as http;
// import 'package:magentahrdios/utalities/color.dart';
//
//
//
//
//
// class budgetprojectAdmin extends StatefulWidget {
//
//   budgetprojectAdmin({
//     this.title_event,
//     this.active_budget,
//     this.expired_budget,
//     this.balance,
//     this.remaining_budget,
//     this.event_id
//
// });
//
//   var title_event,active_budget,expired_budget,balance,remaining_budget,event_id;
//   @override
//   _budgetprojectAdmintState createState() => new _budgetprojectAdmintState();
// }
//
//
// class _budgetprojectAdmintState extends State<budgetprojectAdmin> {
//   final _scaffoldKey = new GlobalKey<ScaffoldState>();
//   Map _transaction;
//   bool _loading=false;
//
//
// //widget------------------
//   Widget _buildbidget(){
//     return Stack(
//       children: [
//         Container(
//           width: double.infinity,
//           height: 260,
//           child: Container(
//             margin: EdgeInsets.only(bottom: 60),
//             width: double.infinity,
//             height: 200,
//             color: baseColor,
//             child: Container(
//
//
//               margin: EdgeInsets.only(left: 30,right: 30),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//
//                 children: <Widget>[
//                   Text("${widget.title_event}",
//                     style: TextStyle(color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: "OpenSans"
//                     ),
//
//                   ),
//
//                   Container(
//                     height: 100,
//                     width: double.infinity,
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: <Widget>[
//                         Container(
//                           child: Container(
//                             margin: EdgeInsets.only(bottom: 20),
//                             child: Text("Active on ${widget.active_budget}",
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 color: Colors.white
//                               ),
//
//                             ),
//                           ),
//
//
//                         ),
//                         Expanded(
//                           flex: 1,
//                           child: Container(
//                             width: 200,
//                             margin: EdgeInsets.only(bottom: 20),
//
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 Text("Expired on ${widget.expired_budget}",
//                                   style: TextStyle(
//                                       fontSize: 12,
//                                       color: Colors.white
//                                   ),
//
//                                 ),
//                               ],
//                             ),
//
//                           ),
//                         )
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//         //container detail budget
//         Container(
//           margin: EdgeInsets.only(left: 20,right: 20),
//           width: double.infinity,
//           height: 260,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: <Widget>[
//
//               //card for remaining dan starting budget
//              Container(
//                child: Card(
//                  child: Container(
//                    width: double.infinity,
//                    height: 130,
//                    child: Row(
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      children: <Widget>[
//                        //Container
//                        Container(
//                          width: 140,
//                          margin: EdgeInsets.all(10),
//                          child: Column(
//                            crossAxisAlignment: CrossAxisAlignment.start,
//                            children: <Widget>[
//                              Container(
//                                child: Text("Remaining Budget",
//                                style: TextStyle(
//                                  color: Colors.black38,
//
//                                  fontSize: 16
//                                ),
//                                ),
//                              ),
//                              Container(
//
//                                margin: EdgeInsets.only(top: 20),
//
//                                child: Text("IDR ${widget.remaining_budget}",
//                                  style: TextStyle(
//                                    color: Colors.green,
//
//                                    fontSize: 16,
//                                    fontWeight: FontWeight.bold
//                                  ),
//                                ),
//                              )
//                            ],
//                          ),
//
//                        ),
//                        Container(
//                          margin: EdgeInsets.only(top: 10,bottom: 10),
//                            child: VerticalDivider(color: Colors.black38,)),
//                        //Container
//                        Expanded(
//                          child: Container(
//
//
//                            width: 140,
//                            margin: EdgeInsets.all(10),
//                            child: Column(
//                              crossAxisAlignment: CrossAxisAlignment.start,
//                              children: <Widget>[
//                                Container(
//                                  child: Text("Balance",
//                                    style: TextStyle(
//                                        color: Colors.black38,
//
//                                        fontSize: 16
//                                    ),
//                                  ),
//                                ),
//                                Container(
//                                  margin: EdgeInsets.only(top: 20),
//                                  child: Text("IDR ${widget.balance}",
//                                    style: TextStyle(
//                                        fontSize: 16,
//                                        fontWeight: FontWeight.bold
//                                    ),
//                                  ),
//                                )
//                              ],
//                            ),
//
//                          ),
//                        ),
//                      ],
//                    ),
//                  ),
//                ),
//              )
//
//             ],
//           ),
//         )
//
//       ],
//     );
//
//   }
//
//   Widget _buildTransaction(index){
//     return InkWell(
//       onTap: (){
//
//         Navigator.push(context, MaterialPageRoute(
//             builder: (context) => detailBudget()
//         ));
//
//       },
//       child: Center(
//         child: Container(
//           margin: EdgeInsets.only(top: 10),
//           width: double.infinity,
//           child: Row(
//             children: <Widget>[
//               //Container icon
//               Container(
//                 child: _transaction['data']['cash_flow'][index]['type']=="income"?Icon(
//                   Icons.monetization_on_outlined,
//                   color: Colors.green,
//                 ): Icon(
//                   Icons.monetization_on_outlined,
//                   color: Colors.redAccent,
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   width: 340,
//
//                   child: Card(
//                     child: Row(
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             Container(
//                               margin: EdgeInsets.only(left: 10,top: 10),
//                               child: Text(
//                                 "${_transaction['data']['cash_flow'][index]['budget_category']['name']}",
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               margin: EdgeInsets.only(left: 10,top: 10),
//                               child: Text(
//                                   "${_transaction['data']['cash_flow'][index]['note']}",
//                                 style: TextStyle(
//                                     fontSize: 16,
//                                    color: Colors.black38
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               margin: EdgeInsets.only(left: 10,top: 20,bottom: 10),
//                               child: Text(
//                                   "IDR ${_transaction['data']['cash_flow'][index]['amount']}",
//                                 style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold
//                                 ),
//                               ),
//                             ),
//                           ],
//
//                         ),
//                         Expanded(
//                           child: Container(
//                             margin: EdgeInsets.only(right: 10),
//                             width: double.maxFinite,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: <Widget>[
//                                 Container(
//                                     margin: EdgeInsets.only(right: 10),
//
//                                     child: _transaction['data']['cash_flow'][index]['type']=="income"? Text("Deposit",
//                                       style: TextStyle(
//                                           color: Colors.green
//                                       ),
//                                     ): Text("Expense",
//                                       style: TextStyle(
//                                         color: Colors.redAccent
//                                       ),
//                                     )
//                                 ),
//                                 Container(
//                                   width: 70,
//                                   height: 70,
//                                   color: Colors.black12,
//                                 )
//
//                               ],
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               )
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//
// //main context----------------------------------
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: baseColor,
//         actions: <Widget>[
//           PopupMenuButton<String>(
//             onSelected: choiceAction,
//             itemBuilder: (BuildContext context){
//               return Constants.choicesM.map((String choice){
//                 return PopupMenuItem<String>(
//                   value: choice,
//                   child: Text(choice),
//                 );
//               }).toList();
//
//             },
//           )
//         ],
//
//
//         title: new Text("",
//           style: TextStyle(color: Colors.black87),
//         ),
//       ),
//
//       body: RefreshIndicator(
//         child: new Container(
//           child: Container(
//             child: Container(
//               child: Center(
//                 child:Container(
//                   child: Column(
//                     children: <Widget>[
//                       _buildbidget(),
//                       Expanded(
//                         child: _loading?Center(child: ShimmerBudget(),):  ListView.builder(
//                             // itemCount: _budgeting['data']['cash_flow'].length,
//                           itemCount: _transaction['data']['cash_flow'].length==0?0:_transaction['data']['cash_flow'].length,
//                             itemBuilder:(context,index){
//                               return _transaction['data']['cash_flow'].length==0? _buildnodata(): _buildTransaction(index);
//                             }),
//                       ),
//
//
//                      //list transation
//                       SizedBox(height: 20,),
//
//
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         onRefresh: _dataBudgeting,
//       ),
//     );
//   }
//   //function
//   void choiceAction(String choice) {
//     if (choice==Constants.Buget){
//       Navigator.push(context, MaterialPageRoute(
//           builder: (context) =>   Tabsappbudget(event_id: widget.event_id,)
//       ));
//
//     }
//
//   }
//
//   Widget _buildnodata(){
//     return Container(
//       height: MediaQuery.of(context).size.height/2,
//
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Container(
//               child: no_data_transacation,
//             ),
//             SizedBox(height: 20,),
//             Container(
//                 child: Text("No transaction yet",
//                   style: TextStyle(
//                       color: Colors.black38,
//                       fontSize: 18
//                   ),
//
//                 )
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//
//   //ge data from api--------------------------------
//   Future _dataBudgeting() async{
//     try{
//       setState(() {
//         _loading=true;
//       });
//       http.Response response=await http.get("$base_url/api/events/${widget.event_id}/budgets?status=approved");
//       _transaction=jsonDecode(response.body);
//
//       print(_transaction);
//       setState(() {
//         _loading=false;
//       });
//     }catch(e){
//
//     }
//
//   }
//
//   //inilisasi state
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _dataBudgeting();
//
//
//
//   }
// }