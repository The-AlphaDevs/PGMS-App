import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ly_project/Pages/Complaints/current_complaints_tab.dart';
import 'package:ly_project/Pages/Complaints/history_tab.dart';
import 'package:ly_project/Services/auth.dart';

class ComplaintsPage extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  ComplaintsPage({Key key, this.auth, this.onSignedOut}) : super(key: key);

  @override
  _ComplaintsPageState createState() => _ComplaintsPageState();
}

class _ComplaintsPageState extends State<ComplaintsPage>
    with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

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
      appBar: AppBar(
        title: Text('Your Complaints'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: Container(
            // color: Colors.white,
            child: TabBar(
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.label,
              // indicator: BoxDecoration(
              //   color: Color(0xFF606fad),
              //   borderRadius: BorderRadius.only(
              //     topLeft: Radius.circular(15),
              //     topRight: Radius.circular(15),
              //     bottomRight: Radius.circular(15),
              //     bottomLeft: Radius.circular(15),
              //   ),
              // ),
              tabs: [
                Tab(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    child: Column(
                      children: [
                        Icon(
                          Icons.mode_comment,
                          // color: Colors.grey[500],
                          size: 24,
                        ),
                        Flexible(
                          child: Text(
                            'Ongoing Complaints ',
                            style: TextStyle(fontSize: 12, color: Colors.black),
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
                          'Past Complaints',
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body:
          // Stack(
          //   alignment: Alignment.topCenter,
          //   children: [
          //     Container(
          //       child:
          TabBarView(
        controller: _tabController,
        children: [
          CurrentComplaintsTab(),
          ComplaintsHistoryTab(),
        ],
      ),
      //     ),
      //     Container(
      //       child: Column(
      //         children: [
      //           SizedBox(height: size.height * 0.03),
      //           // appBar(),
      //           SizedBox(height: 10.0),

      //           // Implementation of tabbar
      //           // Center(
      //           //   child: Container(
      //           //     width: 300.0,
      //           //     height: 60,
      //           //     child: ),
      //           // ),
      //         ],
      //       ),
      //     )
      //   ],
      // ),
    );
  }
}
