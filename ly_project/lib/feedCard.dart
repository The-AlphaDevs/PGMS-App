// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
  final String statuss = "In Progress";

  @override
  Widget build(BuildContext context) {
    // upvoteArray = widget.upvotes;
    return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
        child: InkWell(
          splashColor: Colors.blue.withAlpha(300),
          onTap: () {
            // showDialog(
            //     context: context,
            //     builder: (BuildContext context) => widget.onTap);
          },
          child: Container(
            padding: EdgeInsets.all(10),
            child: Wrap(
              children: <Widget>[
                Text(
                  "Potholes on Road",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'Posted by ',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12),
                    ),
                    Expanded(
                      child: Text(
                        "abc@gmail.com",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                    /*IconButton(
                        icon: Icon(Icons
                            .bookmark_border),
                        onPressed: () {
                          //TODO: Add color change
                    })*/
                  ],
                ),
                SizedBox(height: 20),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.end,
                  children: [
                    Icon(Icons.calendar_today),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                     "10/12/2021",
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      ' in ',
                      style: TextStyle(fontSize: 13),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Potholes",
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        "There are lot of potholes on LBS road due to rain.",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 15),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 7),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(statuss,
                              style: TextStyle(
                                fontSize: 16,
                                color: statuss == 'Rejected'
                                    ? Colors.red
                                    : statuss == 'Solved'
                                        ? Colors.green
                                        : statuss == 'In Progress'
                                            ? Colors.blue
                                            : statuss == 'Passed'
                                                ? Colors.cyan
                                                : Colors.deepOrange,
                                fontWeight: FontWeight.bold,
                              )),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Status',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          // icon: Icon(Icons.arrow_upward,color: (upvoteArray.contains(FirebaseAuth.instance.currentUser.uid))?Colors.blue[400]:Colors.black,),
                          onPressed: () async {
                            // final complaint = await FirebaseFirestore.instance
                            //     .collection('complaints')
                            //     .doc(widget.id)
                            //     .get();
                            // final complaintDoc = FirebaseFirestore.instance
                            //     .collection('complaints')
                            //     .doc(widget.id);

                            // if (complaint.data()['upvotes'].contains(
                            //     FirebaseAuth.instance.currentUser.uid)) {
                            //   await complaintDoc.update({
                            //     'upvotes': FieldValue.arrayRemove(
                            //         [FirebaseAuth.instance.currentUser.uid])
                            //   });
                            //   setState(() {
                            //     upvoteArray = complaint.data()['upvotes'];
                            //   });
                            // } else {
                            //   await complaintDoc.update({
                            //     'upvotes': FieldValue.arrayUnion(
                            //         [FirebaseAuth.instance.currentUser.uid])
                            //   });
                            //   setState(() {
                            //     upvoteArray = complaint.data()['upvotes'];
                            //   });
                            // }
                          },
                        ),
                        Text(
                          '5 Upvotes',
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}