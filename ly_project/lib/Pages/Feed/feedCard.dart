// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ly_project/utils/colors.dart';
// import 'package:intl/intl.dart';

class ComplaintOverviewCard extends StatefulWidget {
  // final String title;
  // final Widget onTap;
  // final String email;
  // final String category;
  // final String description;
  // final String status;
  // final filingTime;
  // final upvotes;
  // final id;

  // const ComplaintOverviewCard(
  //     {Key key,
  //     this.title,
  //     this.onTap,
  //     this.email,
  //     this.filingTime,
  //     this.category,
  //     this.description,
  //     this.status,
  //     this.upvotes,
  //     this.id})
  //     : super(key: key);

  @override
  _ComplaintOverviewCardState createState() => _ComplaintOverviewCardState();
}

class _ComplaintOverviewCardState extends State<ComplaintOverviewCard> {
  List upvoteArray;
  final String complaintStatus = "In Progress";

  @override
  Widget build(BuildContext context) {
    // upvoteArray = widget.upvotes;
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Card(
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            // showDialog(
            //     context: context,
            //     builder: (BuildContext context) => widget.onTap);
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.03, vertical: size.height * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Row(
                  //   children: <Widget>[
                  //     Text(
                  //       'Posted by ',
                  //       overflow: TextOverflow.ellipsis,
                  //       style: TextStyle(fontSize: 12),
                  //     ),
                  //     Expanded(
                  //       child: Text(
                  //         "abc@gmail.com",
                  //         overflow: TextOverflow.ellipsis,
                  //         style: TextStyle(
                  //             fontSize: 12, fontWeight: FontWeight.bold),
                  //       ),
                  //     ),
                  //     /*IconButton(
                  //         icon: Icon(Icons
                  //             .bookmark_border),
                  //         onPressed: () {
                  //           //TODO: Add color change
                  //     })*/
                  //   ],
                  // ),
                  // SizedBox(height: 20),
                  Column(
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
                          Icon(
                            Icons.calendar_today,
                            size: 16,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "10/12/2021",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      // Row(
                      //   children: <Widget>[
                      //     Flexible(
                      //       child: Text(
                      //         "There are lot of potholes on LBS road due to rain.",
                      //         overflow: TextOverflow.ellipsis,
                      //         style: TextStyle(fontSize: 15),
                      //         maxLines: 1,
                      //         softWrap: false,
                      //       ),
                      //     )
                      //   ],
                      // ),

                      // Text(
                      //   ' in ',
                      //   style: TextStyle(fontSize: 13),
                      //   overflow: TextOverflow.ellipsis,
                      // ),
                      // Text(
                      //   "Potholes",
                      //   overflow: TextOverflow.ellipsis,
                      //   style:
                      //       TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                      // ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(complaintStatus,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: COMPLAINT_STATUS_COLOR_MAP[complaintStatus] != null ?COMPLAINT_STATUS_COLOR_MAP[complaintStatus] : Colors.deepOrange,
                                      fontWeight: FontWeight.bold,
                                    )),
                                // SizedBox(
                                //   height: 8,
                                // ),
                                // Text(
                                //   'Status',
                                //   overflow: TextOverflow.ellipsis,
                                //   style: TextStyle(
                                //     fontSize: 13,
                                //   ),
                                //   textAlign: TextAlign.center,
                                // ),
                              ],
                            ),
                          ),

                          // Column(
                          //   children: <Widget>[
                          //     IconButton(
                          //       icon: Icon(Icons.arrow_back),
                          //       // icon: Icon(Icons.arrow_upward,color: (upvoteArray.contains(FirebaseAuth.instance.currentUser.uid))?Colors.blue[400]:Colors.black,),
                          //       onPressed: () async {
                          //         // final complaint = await FirebaseFirestore.instance
                          //         //     .collection('complaints')
                          //         //     .doc(widget.id)
                          //         //     .get();
                          //         // final complaintDoc = FirebaseFirestore.instance
                          //         //     .collection('complaints')
                          //         //     .doc(widget.id);

                          //         // if (complaint.data()['upvotes'].contains(
                          //         //     FirebaseAuth.instance.currentUser.uid)) {
                          //         //   await complaintDoc.update({
                          //         //     'upvotes': FieldValue.arrayRemove(
                          //         //         [FirebaseAuth.instance.currentUser.uid])
                          //         //   });
                          //         //   setState(() {
                          //         //     upvoteArray = complaint.data()['upvotes'];
                          //         //   });
                          //         // } else {
                          //         //   await complaintDoc.update({
                          //         //     'upvotes': FieldValue.arrayUnion(
                          //         //         [FirebaseAuth.instance.currentUser.uid])
                          //         //   });
                          //         //   setState(() {
                          //         //     upvoteArray = complaint.data()['upvotes'];
                          //         //   });
                          //         // }
                          //       },
                          //     ),

                          //     ],
                          //   )
                        ],
                      ),

                      SizedBox(height: 4),

                      // Center(
                      //   child: Text(
                      //     'Comment',
                      //     style: TextStyle(
                      //     fontSize: 16,
                      //     color: Color(0xFFF49F1C),
                      //     fontWeight: FontWeight.bold,
                      //     )
                      //   ),
                      // ),

                      Container(
                        height: size.height * 0.04,
                        child: FlatButton(
                          color: Colors.amber[500],
                          onPressed: () {
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=> InDetail(auth: widget.auth, helper_data_new: helper_data_new[index])));
                          },
                          child: Text('Comment',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: size.width * 0.42,
                    child: Image(
                      image: AssetImage('assets/47.jpg'),
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
