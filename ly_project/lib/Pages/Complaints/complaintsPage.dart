import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ly_project/Pages/Complaints/current_complaints_tab.dart';
import 'package:ly_project/Pages/Complaints/history_tab.dart';
import 'package:ly_project/Services/auth.dart';
import 'package:ly_project/Utils/colors.dart';

class ComplaintsPage extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userEmail;
  ComplaintsPage({Key key, this.auth, this.onSignedOut, this.userEmail});

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
        title: Text('Your Complaints', ),
        backgroundColor: DARK_BLUE,
        
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
                          Icons.mode_comment,
                          size: 24,
                        ),
                        Flexible(
                          child: Text(
                            'Ongoing Complaints ',
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
                          'Past Complaints',
                          style: TextStyle(fontSize: 12, color: Colors.white),
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
          CurrentComplaintsTab(userEmail: widget.userEmail),
          ComplaintsHistoryTab(userEmail: widget.userEmail),
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
