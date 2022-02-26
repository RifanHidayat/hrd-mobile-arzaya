
import 'package:flutter/material.dart';

class ListTask extends StatefulWidget {
  ListTask({
    this.category
});
  String? category;
  @override
  _ListTaskState createState() => _ListTaskState();
}

class _ListTaskState extends State<ListTask> {
  Widget _buildnotif(){
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 100,
          child: Card(
            elevation: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5,top: 10,),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,

                        children: <Widget>[
                          Flexible(
                            child: Container(

                              width: double.infinity,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  //container text
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(

                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                                        children: <Widget>[




                                        ],
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      margin: EdgeInsets.only(top: 10,left: 10),
                                      width: MediaQuery.of(context).size.width,

                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[

                                          Row(
                                            children: [
                                              Text("Eza  ",style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.redAccent[100]
                                              ),),
                                              Text("Have been upload task",style: TextStyle(
                                                  fontSize: 15,color: Colors.black87
                                              )),

                                            ],
                                          ),
                                          Text("22 years ago",style: TextStyle(
                                              fontSize: 15,color: Colors.black26
                                          )

                                          ),
                                          Container(
                                            margin: EdgeInsets.only(right: 5,bottom: 5,),
                                            width: double.infinity,

                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: <Widget>[
                                                Container(
                                                  child: InkWell(
                                                    onTap: (){
                                                      // Navigator.push(context, MaterialPageRoute(
                                                      //     builder: (context) => detailpending()
                                                      // ));
                                                    },
                                                    child: Container(
                                                      child: Text("LIHAT DETAIL",
                                                        style: TextStyle(
                                                            color: Colors.redAccent[100]
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )





                                        ],
                                      ),
                                    ),
                                  ),

                                ],

                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),

                ),


              ],
            ),

          ),
        ),

      ],


    );


  }

  Widget _buildnotif1(){
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 100,
          child: Card(
            elevation: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5,top: 10,),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,

                        children: <Widget>[
                          Flexible(
                            child: Container(

                              width: double.infinity,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  //container text
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(


                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      margin: EdgeInsets.only(top: 10,left: 10),
                                      width: MediaQuery.of(context).size.width,

                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[

                                          Row(
                                            children: [
                                              Text("rifan ",style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.redAccent[100]
                                              ),),
                                              Text("have been upload task",style: TextStyle(
                                                  fontSize: 15,color: Colors.black87
                                              )),

                                            ],
                                          ),
                                          Text("22 years ago",style: TextStyle(
                                              fontSize: 15,color: Colors.black26
                                          )
                                          ),

                                          InkWell(
                                            onTap: (){
                                              // Navigator.push(context, MaterialPageRoute(
                                              //     builder: (context) => detailpending()
                                              // ));
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(right: 5,bottom: 5,),
                                              width: double.infinity,

                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: <Widget>[
                                                  Container(
                                                    child: Text("LIHAT DETAIL",
                                                      style: TextStyle(
                                                        color: Colors.redAccent[100]
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )





                                        ],
                                      ),
                                    ),
                                  ),

                                ],

                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),

                ),


              ],
            ),

          ),
        ),

      ],


    );


  }


  @override
  Widget build(BuildContext context) {


      return Scaffold(

        body:Container(
          child: Column(
            children: <Widget>[
              _buildnotif(),
              _buildnotif1()
              // Text("tes")
            ],

          ),
        ),
      );

  }
}
