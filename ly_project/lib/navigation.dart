import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ly_project/Pages/Complaints/complaintsPage.dart';
import 'package:ly_project/Pages/RaiseComplaint/raise_complaint.dart';
import 'package:ly_project/Pages/Profile/profile.dart';
import 'package:ly_project/Pages/Feed/NavDrawer.dart';
import 'package:ly_project/Pages/DetailedComplaint/detailed_complaint.dart';
import 'package:ly_project/Pages/Feed/feedPage.dart';
// import 'package:ly_project/Pages/WardInfo.dart/ward_tab.dart';
import 'package:ly_project/Pages/WardInfo/ward_tab.dart';
import 'package:ly_project/Services/auth.dart';

class BottomNavBar extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userEmail;
  BottomNavBar({this.auth, this.onSignedOut, this.userEmail});
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> citizenTabs = [
      Feed(auth: widget.auth, onSignedOut: widget.onSignedOut),
      ComplaintsPage(auth: widget.auth, onSignedOut: widget.onSignedOut, userEmail:widget.userEmail),
      // DetailComplaint(),
      WardInfo(),
      ProfileScreen(auth: widget.auth, onSignedOut: widget.onSignedOut),
    ];
    final List<Widget> supervisorTabs = [
      Feed(),
      ComplaintsPage(),
      BottomNavBar(),
      BottomNavBar()
    ];

    void onTapped(int index) {
      setState(() {
        currentIndex = index;
      });
    }

    const TYPE = 'citizen';
    return Scaffold(
        body: (TYPE == 'supervisor')
            ? supervisorTabs[currentIndex]
            : citizenTabs[currentIndex],
        bottomNavigationBar: (TYPE == 'supervisor')
        ? CurvedNavigationBar(
            backgroundColor: Colors.white,
            color: Color(0xFF181d3d),
            buttonBackgroundColor: Color(0xFFF49F1C),
            height: 50,
            animationDuration: Duration(
              milliseconds: 200,
            ),
            animationCurve: Curves.bounceInOut,
            items: <Widget>[
              Icon(
                Icons.home,
                size: 30,
                color: Colors.white,
              ),
              Icon(
                Icons.person,
                size: 30,
                color: Colors.white,
              ),
              Icon(
                Icons.view_list_rounded,
                size: 30,
                color: Colors.white,
              ),
            ],
            onTap: onTapped,
            index: currentIndex,
          )
        : CurvedNavigationBar(
            backgroundColor: Colors.white,
            color: Color(0xFF181d3d),
            buttonBackgroundColor: Color(0xFFF49F1C),
            height: 50,
            animationDuration: Duration(
              milliseconds: 200,
            ),
            animationCurve: Curves.bounceInOut,
            items: <Widget>[
              Icon(
                Icons.home,
                size: 30,
                color: Colors.white,
              ),
              Icon(
                Icons.notifications,
                size: 30,
                color: Colors.white,
              ),
              Icon(
                Icons.view_list_rounded,
                size: 30,
                color: Colors.white,
              ),
              Icon(
                Icons.person,
                size: 30,
                color: Colors.white,
              ),
            ],
            onTap: onTapped,
            index: currentIndex,
        )
    );
  }
}
