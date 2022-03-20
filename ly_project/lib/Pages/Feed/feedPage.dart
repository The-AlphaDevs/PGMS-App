import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ly_project/Pages/Feed/BookmarksTab.dart';
import 'package:ly_project/Pages/Feed/FeedTab.dart';
import 'package:ly_project/Pages/Feed/Widgets/FeedPageAppbar.dart';
import 'package:ly_project/Pages/RaiseComplaint/raise_complaint.dart';
import 'package:ly_project/Services/FeedServices.dart';
import 'package:ly_project/Services/auth.dart';
import 'package:ly_project/Utils/colors.dart';
import 'package:ly_project/Widgets/CurveClipper.dart';
import 'package:uuid/uuid.dart';

class Feed extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  Feed({Key key, this.auth, this.onSignedOut}) : super(key: key);

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  Stream<QuerySnapshot> notificationStream, complaintStream;

  var uuid = Uuid();
  TabController _tabController;
  int selectedIndex = 0;
  int len = 0;

  @override
  void initState() {
    super.initState();
    String user = widget.auth.currentUserEmail();
    complaintStream = FeedServices.complaintStream;
    notificationStream = FeedServices.getNotificationStream(user);

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

    return Scaffold(
      key: _scaffoldState,
      body: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Stack(
          children: [
            //TabBarViews
            Container(
              child: TabBarView(
                controller: _tabController,
                children: [
                  FeedTab(auth: widget.auth, complaintStream: complaintStream),
                  BookmarksTab()
                ],
              ),
            ),

            Container(
              child: Stack(
                children: <Widget>[
                  //Shape
                  buildTabbarShape(context),

                  Column(
                    children: [
                      SizedBox(height: size.height * 0.03),
                      FeedPageAppbar(
                          auth: widget.auth,
                          size: size,
                          notificationStream: notificationStream),
                      SizedBox(height: 10.0),
                      //Tabbar
                      buildTabbar(),
                    ],
                  ),

                  //Add Complaint Button
                  Positioned(
                    bottom: 30,
                    right: 20,
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  RaiseComplaint(auth: widget.auth)),
                        );
                      },
                      backgroundColor: DARK_BLUE,
                      child: const Icon(Icons.add),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Center buildTabbar() {
    return Center(
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
                    Icon(Icons.mode_comment, color: Colors.white, size: 24),
                    Text('Feed',
                        style: TextStyle(fontSize: 11, color: Colors.white)),
                  ],
                ),
              ),
            ),
            Tab(
              child: Padding(
                padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                child: Column(
                  children: [
                    Icon(Icons.bookmark, color: Colors.white, size: 24),
                    Text('Bookmarks',
                        style: TextStyle(fontSize: 11, color: Colors.white)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Column buildTabbarShape(BuildContext context) {
    return Column(
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
            child: Container(color: Color(0xFF181D3D)),
          ),
        ),
      ],
    );
  }
}
