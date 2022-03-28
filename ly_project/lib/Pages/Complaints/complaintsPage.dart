import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ly_project/Pages/Complaints/FeedPageAppBar.dart';
import 'package:ly_project/Pages/Complaints/current_complaints_tab.dart';
import 'package:ly_project/Pages/Complaints/history_tab.dart';
import 'package:ly_project/Services/FeedServices.dart';
import 'package:ly_project/Services/auth.dart';
import 'package:ly_project/Utils/colors.dart';

import 'overdue_complaints.dart';

class ComplaintsPage extends StatefulWidget {
  final BaseAuth auth;
  final String userEmail;
  ComplaintsPage({Key key, this.auth, this.userEmail});

  @override
  _ComplaintsPageState createState() => _ComplaintsPageState();
}

class _ComplaintsPageState extends State<ComplaintsPage> with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<ComplaintsPage> {
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  Stream<QuerySnapshot> notifStream, complaintStream;
  TabController _tabController;
  int selectedIndex = 0;

  void onItemTapped(int index) => setState(() => selectedIndex = index);

  @override
  void initState() {
    super.initState();
    String user = widget.auth.currentUserEmail();
    _tabController = new TabController(vsync: this, length: 3);
    notifStream = FeedServices.getNotificationStream(user);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: FeedPageAppbar(
          auth: widget.auth,
          notificationStream: notifStream,
          size: size,
        ),
        backgroundColor: DARK_BLUE,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: Container(
            child: buildTabBar(),
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
                OverdueComplaintsTab(
                    userEmail: widget.userEmail, auth: widget.auth),
                CurrentComplaintsTab(
                    userEmail: widget.userEmail, auth: widget.auth),
                ComplaintsHistoryTab(
                    userEmail: widget.userEmail, auth: widget.auth),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TabBar buildTabBar() {
    return TabBar(
      controller: _tabController,
      indicatorSize: TabBarIndicatorSize.label,
      indicatorColor: Colors.white,
      tabs: [
        Tab(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            child: Column(
              children: [
                Icon(Icons.bookmark, size: 24),
                Text('Overdue',
                    style: TextStyle(fontSize: 12, color: Colors.white)),
              ],
            ),
          ),
        ),
        Tab(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            child: Column(
              children: [
                Icon(Icons.mode_comment, size: 24),
                Flexible(
                  child: Text('Ongoing',
                      style: TextStyle(fontSize: 12, color: Colors.white)),
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
                Icon(Icons.bookmark, size: 24),
                Text('Past',
                    style: TextStyle(fontSize: 12, color: Colors.white)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
