import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ly_project/Pages/Complaints/current_complaints_tab.dart';
import 'package:ly_project/Pages/Complaints/history_tab.dart';
import 'package:ly_project/Pages/Feed/notifsPage.dart';
import 'package:ly_project/Services/auth.dart';
import 'package:ly_project/Utils/colors.dart';
import 'package:ly_project/Widgets/CurveClipper.dart';

import 'overdue_complaints.dart';

class ComplaintsPage extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userEmail;
  ComplaintsPage({Key key, this.auth, this.onSignedOut, this.userEmail});

  @override
  _ComplaintsPageState createState() => _ComplaintsPageState();
}

class _ComplaintsPageState extends State<ComplaintsPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin<ComplaintsPage>{
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  Stream <QuerySnapshot> notifStream;
  TabController _tabController;
  int selectedIndex = 0;
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 3);
    notifStream = FirebaseFirestore.instance
                  .collection('supervisors')
                  .doc(widget.userEmail)
                  .collection('notifications')
                  .snapshots();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return StreamBuilder(
          stream: notifStream,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              print("Connection state: waiting");
              // return getScreen(context,size);
              return Scaffold(
                body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child:CircularProgressIndicator(),
                    )
                  ],
                ),
              );
            }       
            else    if(!snapshot.hasData){
              print("Connection state: has no data");            
              // return getScreen(context,size);
              return Scaffold(
                body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: CircularProgressIndicator(),
                    )
                  ],
                ),
              );

            }
            
            else{
              // return ListView(
                // children: snapshot.data.docs.map((document) {
                print("Connection state: hasdata");
                  return Scaffold(
                      
                      key: _scaffoldState,
                      appBar: AppBar(
                        backgroundColor: DARK_BLUE,
                        title: Column(
                          children: [
                            SizedBox(height: size.height * 0.03),
                              Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(width: 30),
                                    Text(
                                      'PGMS',
                                      style: TextStyle(
                                        fontSize: 25.0,
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
                          ]
                        ),
                        bottom: PreferredSize(
                          preferredSize: Size.fromHeight(56),
                          child: Container(
                          
                            child: TabBar(
                              controller: _tabController,
                              indicatorSize: TabBarIndicatorSize.label,
                              indicatorColor: Colors.white,
                              tabs: [
                                Tab(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.bookmark,
                                          // color: Colors.grey[600],
                                          size: 24,
                                        ),
                                        Text(
                                          'Overdue',
                                          style: TextStyle(fontSize: 12, color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Tab(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.mode_comment,
                                          size: 24,
                                        ),
                                        Flexible(
                                          child: Text(
                                            'Ongoing',
                                            style: TextStyle(fontSize: 12, color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Tab(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.bookmark,
                                          // color: Colors.grey[600],
                                          size: 24,
                                        ),
                                        Text(
                                          'Past',
                                          style: TextStyle(fontSize: 12, color: Colors.white),
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
                      
                      body: Stack(
                        children: [
                          //TabBarViews
                          Container(
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                OverdueComplaintsTab(userEmail: widget.userEmail, auth: widget.auth),
                                CurrentComplaintsTab(userEmail: widget.userEmail, auth: widget.auth),
                                ComplaintsHistoryTab(userEmail: widget.userEmail, auth: widget.auth),
                              ],
                            ),
                          ),

                          // Container(
                          //   child: Stack(
                          //     children: <Widget>[
                               
                                // Column(
                                //   children: [
                                //     SizedBox(height: size.height * 0.03),
                                //     Row(
                                //         mainAxisSize: MainAxisSize.max,
                                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //         children: [
                                //           SizedBox(width: 30),
                                //           Text(
                                //             'PGMS',
                                //             style: TextStyle(
                                //               fontSize: 25.0,
                                //               color: Colors.white,
                                //               fontFamily: 'Amaranth',
                                //             ),
                                //           ),
                                //         Stack(
                                //           children: <Widget>[
                                //             Positioned(
                                //               child: IconButton(
                                //                 icon: Icon(
                                //                   Icons.notifications,
                                //                   color: Colors.white,
                                //                   size: 30.0,
                                //                 ),
                                //                 onPressed: () {
                                //                   print("Onpressed k andar aaya");
                                //                   Navigator.push(context, MaterialPageRoute(builder: (context) => Notifications(auth: widget.auth)));
                                //                 },
                                //               ),
                                //             ),
                                //             snapshot.data.docs.length>0?Positioned(
                                //                 right: size.width*0.013,
                                //                 top: size.width*0.013,
                                //                 child: CircleAvatar(
                                //                           radius: size.width*0.025,
                                //                           backgroundColor: Colors.green,
                                //                           child: Center(
                                //                             child: Text(
                                //                               snapshot.data.docs.length.toString(),
                                //                               style: TextStyle(color: Colors.white),
                                //                             ),
                                //                           ),
                                //                         ),
                                //             ):Text('')
                                //         ],
                                //       ),
                                //         ],
                                //       ),

                                //     SizedBox(height: 10.0),

                                    // Implementation of tabbar
                                    // Center(
                                    //   child: Container(
                                    //     width: 300.0,
                                    //     height: 60,
                                    //     child: TabBar(
                                    //       controller: _tabController,
                                    //       indicatorSize: TabBarIndicatorSize.label,
                                    //       indicator: BoxDecoration(
                                    //         color: Color(0xFF606fad),
                                    //         borderRadius: BorderRadius.only(
                                    //           topLeft: Radius.circular(15),
                                    //           topRight: Radius.circular(15),
                                    //           bottomRight: Radius.circular(15),
                                    //           bottomLeft: Radius.circular(15),
                                    //         ),
                                    //       ),
                                    //       tabs: [
                                    //         Tab(
                                    //           child: Padding(
                                    //             padding: EdgeInsets.fromLTRB(42.0, 0, 42.0, 0),
                                    //             child: Column(
                                    //               children: [
                                    //                 Icon(
                                    //                   Icons.mode_comment,
                                    //                   color: Colors.white,
                                    //                   size: 24,
                                    //                 ),
                                    //                 Text(
                                    //                   'Feed',
                                    //                   style: TextStyle(
                                    //                       fontSize: 11, color: Colors.white),
                                    //                 ),
                                    //               ],
                                    //             ),
                                    //           ),
                                    //         ),
                                    //         Tab(
                                    //           child: Padding(
                                    //             padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                                    //             child: Column(
                                    //               children: [
                                    //                 Icon(
                                    //                   Icons.bookmark,
                                    //                   color: Colors.white,
                                    //                   size: 24,
                                    //                 ),
                                    //                 Text(
                                    //                   'Bookmarks',
                                    //                   style: TextStyle(
                                    //                       fontSize: 11, color: Colors.white),
                                    //                 ),
                                    //               ],
                                    //             ),
                                    //           ),
                                    //         )
                                    //       ],
                                    //     ),
                                    //   ),
                                    // ),
                                  // ],
                                // ),


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
                          //     ],
                          //   ),
                          // )
                ],
              ),
            );
          }
        }  
    );
  }

  @override
  bool get wantKeepAlive => true;
}
