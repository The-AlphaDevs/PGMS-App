import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ly_project/Pages/Complaints/complaintsPage.dart';
import 'package:ly_project/Pages/Profile/profile.dart';
import 'package:ly_project/Pages/Performance/performance_tab.dart';
import 'package:ly_project/Services/auth.dart';

class BottomNavBar extends StatefulWidget {
  final BaseAuth auth;
  final String userEmail;
  BottomNavBar({@required this.auth, this.userEmail});
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> supervisorTabs = [
      ComplaintsPage(auth: widget.auth, userEmail: widget.userEmail),
      Performance(),
      ProfileScreen(auth: widget.auth),
    ];

    void onTapped(int index) => setState(() => currentIndex = index);

    return Scaffold(
      body: supervisorTabs[currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Color(0xFF181d3d),
        buttonBackgroundColor: Color(0xFFF49F1C),
        height: 50,
        animationDuration: Duration(milliseconds: 200),
        animationCurve: Curves.bounceInOut,
        items: <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.star_rate_outlined, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
        ],
        onTap: onTapped,
        index: currentIndex,
      ),
    );
  }
}
