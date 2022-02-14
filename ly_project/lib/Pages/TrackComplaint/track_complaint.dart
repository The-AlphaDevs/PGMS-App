// import 'package:InstiComplaints/TrackComplaintsCard.dart';
// import 'loading.dart';
// import 'UpdateNotification.dart';
// import 'package:InstiComplaints/search.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';
// import 'dart:math';
// import 'feedCard.dart';
// import 'loading.dart';

class TrackComplaints extends StatefulWidget {
  const TrackComplaints({Key key}) : super(key: key);
  @override
  _TrackComplaintsState createState() => _TrackComplaintsState();
}

class _TrackComplaintsState extends State<TrackComplaints>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Column(children: [
      SizedBox(height: size.height * 0.08),
      location_card(),
      timeline(),
      Container(
        margin: EdgeInsets.fromLTRB(70, 0, 70, 40),
        child: FlatButton(
          minWidth: 5,
          onPressed: () => {},
          color: Colors.amber,
          textColor: Colors.white,
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment
                .center, // Replace with a Row for horizontal icon + text
            children: <Widget>[Icon(Icons.close), Text("Close Complaint")],
          ),
        ),
      ),
    ]));
  }

  Widget location_card() {
    Size size = MediaQuery.of(context).size;
    final String statuss = "In Progress";
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(25.0),
          child: Card(
              margin: EdgeInsets.fromLTRB(15, 2, 15, 3),
              elevation: 6,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11)),
              // showDialog(
              //     context: context,
              //     builder: (BuildContext context) => widget.onTap);
              child: Container(
                padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
                child: Row(
                  children: [
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Potholes on Road",
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.calendar_today),
                              // SizedBox(
                              //   width: 5,
                              // ),
                              Text(
                                "10/12/2021",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),

                          SizedBox(height: 10),
                          //   Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //     crossAxisAlignment: CrossAxisAlignment.end,
                          //     children: <Widget>[
                          //     Center(
                          //       child: Column(
                          //         mainAxisAlignment: MainAxisAlignment.end,
                          //         crossAxisAlignment: CrossAxisAlignment.center,
                          //         children: <Widget>[
                          //           Text(statuss,
                          //               style: TextStyle(
                          //                 fontSize: 16,
                          //                 color: statuss == 'Rejected'
                          //                     ? Colors.red
                          //                     : statuss == 'Solved'
                          //                         ? Colors.green
                          //                         : statuss == 'In Progress'
                          //                             ? Colors.blue
                          //                             : statuss == 'Passed'
                          //                                 ? Colors.cyan
                          //                                 : Colors.deepOrange,
                          //                 fontWeight: FontWeight.bold,
                          //               )),
                          //           // SizedBox(
                          //           //   height: 8,
                          //           // ),
                          //           Text(
                          //             'Status',
                          //             overflow: TextOverflow.ellipsis,
                          //             style: TextStyle(
                          //               fontSize: 13,
                          //               ),
                          //               textAlign: TextAlign.center,
                          //             ),
                          //           ],
                          //         ),
                          //       ),

                          //   ],
                          // ),

                          Center(
                            child: Flexible(
                              child: Text(
                                "Narasimha Chintaman Kelkar Road, Dadar West, Mumbai - 400030",
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 5,
                          ),

                          Center(
                            child: Flexible(
                              child: Text(
                                "Posted 5 days ago",
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),

                          // Center(
                          //   child: Container(
                          //     margin: EdgeInsets.symmetric(vertical: 1),
                          //     width: size.width * 0.2,
                          //      child: ClipRRect(
                          //       borderRadius: BorderRadius.circular(25),
                          //       child: FlatButton(
                          //         padding: EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                          //         color: Colors.amber,
                          //         onPressed: (){
                          //           // Navigator.push(context, MaterialPageRoute(builder: (context)=> InDetail(auth: widget.auth, helper_data_new: helper_data_new[index])));
                          //         },
                          //         child: Text(
                          //           'Comment',
                          //           style: TextStyle(
                          //           fontSize: 12,
                          //           color: Colors.white,
                          //           fontWeight: FontWeight.bold,
                          //           )
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.35,
                      child: Flexible(
                        child: Column(
                          children: [
                            Image(image: AssetImage('assets/loc.jpg')),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ),
      ],
    );
  }

  Widget timeline() {
    Size size = MediaQuery.of(context).size;
    return Flexible(
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 120, 0),
        alignment: Alignment.topLeft,
        child: Timeline.tileBuilder(
          builder: TimelineTileBuilder.fromStyle(
            contentsAlign: ContentsAlign.basic,
            contentsBuilder: (context, index) => SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                  child: Card(
                    elevation: 6,
                    color: Colors.green[100],
                    child: Container(
                      padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: size.width * 0.035,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Title",
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey),
                                ),
                                SizedBox(height: 5),
                                SizedBox(height: 5),
                                Text(
                                  "Description",
                                  maxLines: 3,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
            ),
            itemCount: 4,
          ),
        ),
      ),
    );
  }
}
