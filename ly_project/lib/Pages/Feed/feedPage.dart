// import 'package:InstiComplaints/feedCard.dart';
// import 'loading.dart';
// import 'UpdateNotification.dart';
// import 'package:InstiComplaints/search.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ly_project/Pages/Feed/BookmarksTab.dart';

import 'package:ly_project/Pages/Feed/FeedTab.dart';
import 'package:ly_project/Pages/Feed/notifsCard.dart';
import 'package:ly_project/Pages/RaiseComplaint/raise_complaint.dart';
import 'package:ly_project/Services/auth.dart';
import 'package:ly_project/Utils/colors.dart';
import 'package:ly_project/Widgets/CurveClipper.dart';
import 'package:top_modal_sheet/top_modal_sheet.dart';
import 'package:uuid/uuid.dart';
import 'notifsPage.dart';

// import 'package:firebase_messaging/firebase_messaging.dart';


class Feed extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  Feed({Key key, this.auth, this.onSignedOut}) : super(key: key);

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  // final FirebaseMessaging _fcm = FirebaseMessaging();
  var uuid = Uuid();
  TabController _tabController;
  int selectedIndex = 0;
  int len=0;
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);
    
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String user = widget.auth.currentUserEmail();
    return Padding(
      padding: EdgeInsets.fromLTRB(0,0,0,0),
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
                  .collection('supervisors')
                  .doc(user)
                  .collection('notifications')
                  .snapshots()
                  ,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              print("Connection state: has no data");            
              // return getScreen(context,size);

            }
            else if(snapshot.connectionState == ConnectionState.waiting){
              print("Connection state: waiting");
              // return getScreen(context,size);
            }          
            
            else{
              // return ListView(
                // children: snapshot.data.docs.map((document) {
                print("Connection state: hasdata");
                  return Scaffold(
                      
                      key: _scaffoldState,
                      body: Stack(
                        children: [
                          //TabBarViews
                          Container(
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                FeedTab(auth: widget.auth,),
                                BookmarksTab(),
                              ],
                            ),
                          ),

                          Container(
                            child: Stack(
                              children: <Widget>[
                                //Shape
                                Column(
                                  children: [
                                    Container(
                                      height: MediaQuery.of(context).size.height * 0.035,
                                      color: Color(0xFF181D3D),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.height * 0.8,
                                      child: ClipPath(
                                          clipper: CurveClipper(),
                                          child: Container(
                                            color: Color(0xFF181D3D),
                                          )),
                                    ),
                                  ],
                                ),

                                Column(
                                  children: [
                                    SizedBox(height: size.height * 0.03),
                                    Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(width: 30),
                                          Text(
                                            'PGMS For Supervisors',
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white,
                                              fontFamily: 'Amaranth',
                                            ),
                                          ),
                                        Stack(
                                          children: <Widget>[
                                            Positioned(
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.notifications,
                                                  color: Colors.white,
                                                  size: 30.0,
                                                ),
                                                onPressed: () {
                                                  print("Onpressed k andar aaya");
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Notifications(auth: widget.auth)));
                                                },
                                              ),
                                            ),
                                            snapshot.data.docs.length>0?Positioned(
                                                right: size.width*0.013,
                                                top: size.width*0.013,
                                                child: CircleAvatar(
                                                          radius: size.width*0.025,
                                                          backgroundColor: Colors.green,
                                                          child: Center(
                                                            child: Text(
                                                              snapshot.data.docs.length.toString(),
                                                              style: TextStyle(color: Colors.white),
                                                            ),
                                                          ),
                                                        ),
                                            ):Text('')
                                        ],
                                      ),
                                        ],
                                      ),
                                    SizedBox(height: 10.0),

                                    // Implementation of tabbar
                                    Center(
                                      child: Container(
                                        width: 300.0,
                                        height: 60,
                                        child: TabBar(
                                          controller: _tabController,
                                          indicatorSize: TabBarIndicatorSize.label,
                                          indicator: BoxDecoration(
                                            color: Color(0xFF606fad),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15),
                                              bottomRight: Radius.circular(15),
                                              bottomLeft: Radius.circular(15),
                                            ),
                                          ),
                                          tabs: [
                                            Tab(
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(42.0, 0, 42.0, 0),
                                                child: Column(
                                                  children: [
                                                    Icon(
                                                      Icons.mode_comment,
                                                      color: Colors.white,
                                                      size: 24,
                                                    ),
                                                    Text(
                                                      'Feed',
                                                      style: TextStyle(
                                                          fontSize: 11, color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Tab(
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                                                child: Column(
                                                  children: [
                                                    Icon(
                                                      Icons.bookmark,
                                                      color: Colors.white,
                                                      size: 24,
                                                    ),
                                                    Text(
                                                      'Bookmarks',
                                                      style: TextStyle(
                                                          fontSize: 11, color: Colors.white),
                                                    ),
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
                                // Positioned(
                                //   bottom: 30,
                                //   right: 20,
                                //   child: FloatingActionButton(
                                //     onPressed: () {
                                //       Navigator.push(
                                //         context,
                                //         MaterialPageRoute(
                                //           builder: (context) => RaiseComplaint(auth: widget.auth,)
                                //         )
                                //       );
                                //     },
                                //     backgroundColor: DARK_BLUE,
                                //     child: const Icon(Icons.add),
                                //   ),
                                // ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );

              }
            }
          ),
    );
  }


//   Widget getScreen(BuildContext context, Size size) {
  
//   return Scaffold(
//       key: _scaffoldState,
//       body: Stack(
//         children: [
//           //TabBarViews
//           Container(
//             child: TabBarView(
//               controller: _tabController,
//               children: [
//                 FeedTab(auth: widget.auth, ),
//                 BookmarksTab(),
//               ],
//             ),
//           ),

//           Container(
//             child: Stack(
//               children: <Widget>[
//                 //Shape
//                 Column(
//                   children: [
//                     Container(
//                       height: MediaQuery.of(context).size.height * 0.035,
//                       color: Color(0xFF181D3D),
//                     ),
//                     Container(
//                       width: MediaQuery.of(context).size.width,
//                       height: MediaQuery.of(context).size.height * 0.8,
//                       child: ClipPath(
//                           clipper: CurveClipper(),
//                           child: Container(
//                             color: Color(0xFF181D3D),
//                           )),
//                     ),
//                   ],
//                 ),

//                 Column(
//                   children: [
//                     SizedBox(height: size.height * 0.03),
//                     Row(
//                         mainAxisSize: MainAxisSize.max,
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           SizedBox(width: 30),
//                           Text(
//                             'PGMS',
//                             style: TextStyle(
//                               fontSize: 25.0,
//                               color: Colors.white,
//                               fontFamily: 'Amaranth',
//                             ),
//                           ),
//                         CircularProgressIndicator(),
//                         ],
//                       ),
//                     SizedBox(height: 10.0),

//                     // Implementation of tabbar
//                     Center(
//                       child: Container(
//                         width: 300.0,
//                         height: 60,
//                         child: TabBar(
//                           controller: _tabController,
//                           indicatorSize: TabBarIndicatorSize.label,
//                           indicator: BoxDecoration(
//                             color: Color(0xFF606fad),
//                             borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(15),
//                               topRight: Radius.circular(15),
//                               bottomRight: Radius.circular(15),
//                               bottomLeft: Radius.circular(15),
//                             ),
//                           ),
//                           tabs: [
//                             Tab(
//                               child: Padding(
//                                 padding: EdgeInsets.fromLTRB(42.0, 0, 42.0, 0),
//                                 child: Column(
//                                   children: [
//                                     Icon(
//                                       Icons.mode_comment,
//                                       color: Colors.white,
//                                       size: 24,
//                                     ),
//                                     Text(
//                                       'Feed',
//                                       style: TextStyle(
//                                           fontSize: 11, color: Colors.white),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             Tab(
//                               child: Padding(
//                                 padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
//                                 child: Column(
//                                   children: [
//                                     Icon(
//                                       Icons.bookmark,
//                                       color: Colors.white,
//                                       size: 24,
//                                     ),
//                                     Text(
//                                       'Bookmarks',
//                                       style: TextStyle(
//                                           fontSize: 11, color: Colors.white),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Positioned(
//                   bottom: 30,
//                   right: 20,
//                   child: FloatingActionButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => RaiseComplaint(auth: widget.auth,)
//                         )
//                       );
//                     },
//                     backgroundColor: DARK_BLUE,
//                     child: const Icon(Icons.add),
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );

// }


}


