import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ly_project/Pages/WardInfo/LeaderboardTab/leaderboard_tab.dart';
import 'package:ly_project/Pages/WardInfo/WardPerformanceTab/performance_tab.dart';
import 'package:ly_project/Services/auth.dart';
import 'package:ly_project/Utils/colors.dart';

class WardInfo extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  WardInfo({Key key, this.auth, this.onSignedOut}) : super(key: key);

  @override
  _WardInfoState createState() => _WardInfoState();
}

class _WardInfoState extends State<WardInfo>
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
    // Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text('Ward Information'),
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
                            'Ward Performance ',
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
                          size: 24,
                        ),
                        Text(
                          'LeaderBoard',
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
      body: TabBarView(
        controller: _tabController,
        children: [
          WardPerformance(),
          Leaderboard(),
        ],
      ),
    );
  }
}
