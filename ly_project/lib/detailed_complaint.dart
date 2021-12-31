// import 'dart:js';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ly_project/track_complaint.dart';



class DetailComplaint extends StatefulWidget {
  // DetailComplaint({Key? key}) : super(key: key);

  @override
  _DetailComplaintState createState() => _DetailComplaintState();
}

class _DetailComplaintState extends State<DetailComplaint> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        // mainAxisSize: MainAxisSize.,
        children: [
          SizedBox(height: size.height*0.06),
          Row(
            children:[
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Text(
                'Complaint#2587',
                style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        ),
              )
              ),
              SizedBox(width:220),
              Icon(
                    Icons.more_vert,
                    size: 24,
                    color: Color(0xFF36497E),
                  )
            ]
          ),
          SizedBox(height:20),
          SizedBox(
                  // width: widget.size,
                  child: Flexible(
                    child: Column(
                      children: [
                        CarouselSlider(
                          items:[
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                image: DecorationImage(
                                  image: AssetImage('assets/47.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                image: DecorationImage(
                                  image: AssetImage('assets/loc.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                          options: CarouselOptions(
                          height: 320.0,
                          enlargeCenterPage: true,
                          autoPlay: false,
                          aspectRatio: 16 / 9,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: false,
                          autoPlayAnimationDuration: Duration(milliseconds: 800),
                          viewportFraction: 0.8,
                        ),
                        ),
                      ],
                    )
                  ),
          ),
          SizedBox(height:10),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Row(
              children:[
                Icon(
                  Icons.insert_comment_outlined,
                  size: 30,
                  color: Colors.black,
                ),
                SizedBox(
                  width:20,
                ),
                Text(
                '50 Comments',
                style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        ),
              
              
              ),
              // ),
              SizedBox(
                width: size.width*0.4,
              ),
              Icon(
                Icons.bookmark_border_rounded,
                size: 30,
                color: Colors.black,
              ),
            ],
          ),
          ),

          SizedBox(
            height:20,
          ),

          Row(
            children: [
          // Text(
          //   'Location: ',
          //   style: TextStyle(
          //           fontSize: 15,
          //           color: Colors.black,
          //           fontWeight: FontWeight.bold,
          //           ),
          // ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                'Narasimha Chintaman Kelkar Road, Dadar West, Mumbai - 400030',
                style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                        ),
              ),
            ),
          ),
            ],
          ),

          SizedBox(
            height:10,
          ),
          
          Row(
            children: [
                // Text(
                //   'Username: ',
                //   style: TextStyle(
                //           fontSize: 18,
                //           color: Colors.black,
                //           fontWeight: FontWeight.bold,
                //           ),
                // ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text(
                      'There were lot of potholes on road',
                      style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              ),
                    ),
                  ),
                ),
            ],
          ),

          SizedBox(
            height:10,
          ),

          Row(
            children: [
          // Text(
          //   'Status: ',
          //   style: TextStyle(
          //           fontSize: 15,
          //           color: Colors.black,
          //           fontWeight: FontWeight.bold,
          //           ),
          // ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Text(
              'In Progress',
              style: TextStyle(
                      fontSize: 20,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),

          SizedBox(
            height:10,
          ),
          
  

          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Text(
                'Supervisor: ',
                style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        ),
              ),
              Text(
                'Supervisor Details',
                style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        ),
              ),
            ],
          ),
          
          SizedBox(
            height:10,
          ),
          Row(
            children: [
          // Text(
          //   'Date: ',
          //   style: TextStyle(
          //           fontSize: 15,
          //           color: Colors.black,
          //           fontWeight: FontWeight.bold,
          //           ),
          // ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                '20 Dec 2021',
                style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        ),
              ),
            ),
            ],
          ),


          SizedBox(
            height:size.height*0.05,
          ),

          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(150)
            ),
            margin: EdgeInsets.fromLTRB(100, 0, 70, 40),
            child: Center(
              child: FlatButton(
                minWidth: 5,
                onPressed: () => {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TrackComplaints()))
                },
                color: Colors.blueAccent,
                textColor: Colors.white,
                padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center, // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    Icon(Icons.track_changes_rounded),
                    SizedBox(
                      width:20,
                    ),
                    Text("Track Complaint")
                  ],
                ),
              ),
            ),
          ),

        ]
      )
    );
  }
}










// // import 'package:InstiComplain
// 
// 
// ts/UpdateNotification.dart';
// // import 'package:InstiComplaints/loading.dart';
// import 'package:flutter/material.dart';
// // import 'package:intl/intl.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';

// class ComplaintDialog extends StatefulWidget {
//   final String _complaintID;
//   ComplaintDialog(this._complaintID);
//   @override
//   _ComplaintDialogState createState() => _ComplaintDialogState();
// }

// class _ComplaintDialogState extends State<ComplaintDialog> {
//   // final CollectionReference _complaints =
//   //     FirebaseFirestore.instance.collection('complaints');
//   // final DocumentReference _userDocument = FirebaseFirestore.instance
//   //     .collection('users')
//   //     .doc(FirebaseAuth.instance.currentUser.uid);

//   bool bookmarked = false;

//   @override
//   void initState() {
//     super.initState();
//     setState(() {
//       // _userDocument.get().then((value) async {
//       //   bookmarked =
//       //       await value.data()['bookmarked'].contains(widget._complaintID);
//       // });
//       print(bookmarked);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     //_userDocument.get().then((value) {bookmarked=value.data()['bookmarked'].contains(widget._complaintID);});
//     // return FutureBuilder<DocumentSnapshot>(
//     //     future: _userDocument.get(),
//     //     builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> aot) {
//     //       return StreamBuilder<DocumentSnapshot>(
//     //           stream: ComplaintShow(widget._complaintID).complaintsnap,
//     //           builder: (context, snapshot) {
//     //             if (snapshot.hasData) {
//     //               return
//                       return Dialog(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                       elevation: 5.0,
//                       backgroundColor: Colors.transparent,
//                       child: Container(
//                           width: MediaQuery.of(context).size.width,
//                           color: Colors.white,
//                           padding: EdgeInsets.all(15.0),
//                           child: SingleChildScrollView(
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: <Widget>[
//                                 Row(
//                                   children: <Widget>[
//                                     Expanded(
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: <Widget>[
//                                           Container(
//                                             alignment: Alignment.topLeft,
//                                             child: Text(
//                                               'Title',
//                                               // snapshot.data.data()['title'],
//                                               textAlign: TextAlign.left,
//                                               style: TextStyle(
//                                                   fontSize: 20.0,
//                                                   color: Color(0xFF181D3D),
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             height: 6.0,
//                                           ),
//                                           Text(
//                                             'posted by:',
//                                             style: TextStyle(fontSize: 12.0),
//                                           ),
//                                           Text(
//                                             // snapshot.data.data()['email'],
//                                             'abc@gmail.com',
//                                             style: TextStyle(
//                                                 decoration:
//                                                     TextDecoration.underline,
//                                                 color: Color.fromRGBO(
//                                                     53, 99, 184, 1),
//                                                 fontStyle: FontStyle.italic,
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 12.0),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     //new Spacer(),
//                                     IconButton(
//                                       onPressed: () async {
//                                         // if (await _userDocument.get().then(
//                                         //     (value) => value
//                                         //         .data()['bookmarked']
//                                         //         .contains(
//                                         //             widget._complaintID))) {
//                                         //   await _userDocument.update({
//                                         //     'bookmarked':
//                                         //         FieldValue.arrayRemove(
//                                         //             [widget._complaintID])
//                                         //   });
//                                         //   setState(() {
//                                         //     bookmarked = false;
//                                         //   });
//                                         // } else {
//                                         //   await _userDocument.update({
//                                         //     'bookmarked': FieldValue.arrayUnion(
//                                         //         [widget._complaintID])
//                                         //   });
//                                         //   setState(() {
//                                         //     bookmarked = true;
//                                         //   });
//                                         // }
//                                       },
//                                       icon: Icon(bookmarked
//                                           ? Icons.bookmark
//                                           : Icons.bookmark_border),
//                                     )
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 10.0,
//                                 ),
//                                 Row(
//                                   children: <Widget>[
//                                     Text(
//                                       'Date',
//                                       // DateFormat('kk:mm:a').format(snapshot.data
//                                       //         .data()['filing time']
//                                       //         .toDate()) +
//                                       //     '\n' +
//                                       //     DateFormat('dd-MM-yyyy').format(
//                                       //         snapshot.data
//                                       //             .data()['filing time']
//                                       //             .toDate()),
//                                       style: TextStyle(fontSize: 12.0),
//                                     ),
//                                     new Spacer(),
//                                     Text(
//                                       'Category',
//                                       // snapshot.data.data()['category'],
//                                         style: TextStyle(fontSize: 12.0))
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 10.0,
//                                 ),
//                                 Text('Description',
//                                   // snapshot.data.data()['description']
//                                   ),
//                                 SizedBox(
//                                   height: 10.0,
//                                 ),
//                                 // SizedBox(
//                                 //   height: 5 !=
//                                 //           0
//                                 //       ? (3.8 *
//                                 //               MediaQuery.of(context)
//                                 //                   .size
//                                 //                   .height) /
//                                 //           10
//                                 //       : 0, // card height
//                                 //   child: PageView(
//                                 //       scrollDirection: Axis.horizontal,
//                                 //       controller:
//                                 //           PageController(viewportFraction: 1),
//                                 //       //pageSnapping: ,
//                                 //       children: snapshot.data
//                                 //           .data()['list of Images']
//                                 //           .map<Widget>((imag) => Card(
//                                 //                 elevation: 6.0,
//                                 //                 child: Image.network(
//                                 //                   imag,
//                                 //                 ),
//                                 //                 margin: EdgeInsets.all(10.0),
//                                 //               ))
//                                 //           .toList()),
//                                 // ),
//                                 SizedBox(
//                                   height: 20.0,
//                                 ),
//                                 Row(
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: <Widget>[
//                                     Container(
//                                       height: (0.8 *
//                                               MediaQuery.of(context)
//                                                   .size
//                                                   .height) /
//                                           10,
//                                       width: (1.05 *
//                                                   MediaQuery.of(context)
//                                                       .size
//                                                       .width -
//                                               30) /
//                                           3,
//                                       decoration: BoxDecoration(
//                                         color: Color(0xFF181D3D),
//                                         shape: BoxShape.rectangle,
//                                         borderRadius: BorderRadius.only(
//                                             topLeft: Radius.circular((0.6 *
//                                                     MediaQuery.of(context)
//                                                         .size
//                                                         .height) /
//                                                 20),
//                                             bottomLeft: Radius.circular((0.6 *
//                                                     MediaQuery.of(context)
//                                                         .size
//                                                         .height) /
//                                                 20),
//                                             topRight: Radius.zero,
//                                             bottomRight: Radius.zero),
//                                       ),
//                                       child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: <Widget>[
//                                           Text(
//                                             'Status',
//                                             // snapshot.data.data()['status'],
//                                             style: TextStyle(
//                                                 fontSize: (0.12 *
//                                                         MediaQuery.of(context)
//                                                             .size
//                                                             .width) /
//                                                     3,
//                                                 color: Colors.yellow[900],
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                           Text(
//                                             'Status',
//                                             textAlign: TextAlign.center,
//                                             style: TextStyle(
//                                                 //fontWeight: FontWeight.bold,
//                                                 color: Colors.white,
//                                                 fontSize: (0.08 *
//                                                         MediaQuery.of(context)
//                                                             .size
//                                                             .width) /
//                                                     3),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     VerticalDivider(
//                                       color: Color.fromRGBO(58, 128, 203, 1),
//                                       width: 1.0,
//                                     ),
//                                     /*InkWell(
//                                       onTap: () {},
//                                       child: Container(
//                                           width: (0.7 *
//                                                       MediaQuery.of(context)
//                                                           .size
//                                                           .width -
//                                                   30) /
//                                               3,
//                                           height: (0.8 *
//                                                   MediaQuery.of(context)
//                                                       .size
//                                                       .height) /
//                                               10,
//                                           decoration: BoxDecoration(
//                                             color: Color(0xFF181D3D),
//                                             shape: BoxShape.rectangle,
//                                           ),
//                                           child: Icon(
//                                             Icons.share,
//                                             size: (0.35 *
//                                                     MediaQuery.of(context)
//                                                         .size
//                                                         .height) /
//                                                 10,
//                                             color: Colors.white,
//                                           )),
//                                     ),
//                                     VerticalDivider(
//                                       color: Color.fromRGBO(58, 128, 203, 1),
//                                       width: 1.0,
//                                     ),*/
//                                     InkWell(
//                                       onTap: () {
//                                         setState(() {
//                                           /*if (_like == true) {
//                                     _like = false;
//                                     complaint.upvotes
//                                         .remove("MY EMAIL ID: FROM BACKEND");
//                                     //TODO: Upload complaint to Backend
//                                   } else {
//                                     _like = true;
//                                     complaint.upvotes.add("MY EMAIL ID: FROM BACKEND");
//                                     //TODO: Upload complaint to Backend
//                                   }*/
//                                         });
//                                       },
//                                       child: Container(
//                                         width: (1.05 *
//                                                     MediaQuery.of(context)
//                                                         .size
//                                                         .width -
//                                                 30) /
//                                             3,
//                                         height: (0.8 *
//                                                 MediaQuery.of(context)
//                                                     .size
//                                                     .height) /
//                                             10,
//                                         decoration: BoxDecoration(
//                                           color: Color(0xFF181D3D),
//                                           shape: BoxShape.rectangle,
//                                           borderRadius: BorderRadius.only(
//                                               topLeft: Radius.zero,
//                                               bottomLeft: Radius.zero,
//                                               topRight: Radius.circular((0.6 *
//                                                       MediaQuery.of(context)
//                                                           .size
//                                                           .height) /
//                                                   20),
//                                               bottomRight: Radius.circular(
//                                                   (0.6 *
//                                                           MediaQuery.of(context)
//                                                               .size
//                                                               .height) /
//                                                       20)),
//                                         ),
//                                         // child: Row(
//                                         //   mainAxisAlignment:
//                                         //       MainAxisAlignment.center,
//                                         //   children: <Widget>[
//                                         //     IconButton(
//                                         //       icon: Icon(Icons.arrow_upward),
//                                         //       onPressed: () {
//                                         //         if (snapshot.data
//                                         //             .data()['upvotes']
//                                         //             .contains(FirebaseAuth
//                                         //                 .instance
//                                         //                 .currentUser
//                                         //                 .uid)) {
//                                         //           _complaints
//                                         //               .doc(widget._complaintID)
//                                         //               .update({
//                                         //             'upvotes':
//                                         //                 FieldValue.arrayRemove([
//                                         //               FirebaseAuth.instance
//                                         //                   .currentUser.uid
//                                         //             ])
//                                         //           });
//                                         //         } else {
//                                         //           _complaints
//                                         //               .doc(widget._complaintID)
//                                         //               .update({
//                                         //             'upvotes':
//                                         //                 FieldValue.arrayUnion([
//                                         //               FirebaseAuth.instance
//                                         //                   .currentUser.uid
//                                         //             ])
//                                         //           });
//                                         //         }
//                                         //       },
//                                         //       color: snapshot.data
//                                         //               .data()['upvotes']
//                                         //               .contains(FirebaseAuth
//                                         //                   .instance
//                                         //                   .currentUser
//                                         //                   .uid)
//                                         //           ? Colors.blue[400]
//                                         //           : Colors.grey,
//                                         //       iconSize: (0.35 *
//                                         //               MediaQuery.of(context)
//                                         //                   .size
//                                         //                   .height) /
//                                         //           10,
//                                         //     ),
//                                         //     SizedBox(width: 4.0,),
//                                         //     Text(
//                                         //       snapshot.data
//                                         //           .data()['upvotes']
//                                         //           .length
//                                         //           .toString(),
//                                         //       //complaint.upvotes.length.toString(),
//                                         //       style: TextStyle(
//                                         //           fontWeight: FontWeight.bold,
//                                         //           color: Colors.white,
//                                         //           fontSize: 15.0),
//                                         //     ),
//                                         //   ],
//                                         // ),
//                                       ),
//                                     )
//                                   ],
//                                 )
//                               ],
//                             ),
//                           )));
//   //               } else {
//   //                 return Loading();
//   //               }
//   //             });
//   //       });
//   // }
//   }
// }



// ********


