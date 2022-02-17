import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ly_project/Pages/RaiseComplaint/raise_complaint.dart';
import 'package:ly_project/Pages/Profile/profile.dart';
import 'package:ly_project/Pages/DetailedComplaint/detailed_complaint.dart';
import 'package:ly_project/Pages/Feed/feedPage.dart';
import 'package:ly_project/Services/auth.dart';


class User1 extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  User1({this.auth, this.onSignedOut});
  @override
  _User1State createState() => _User1State();
}

class _User1State extends State<User1> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
            final List<Widget> children1 = [
              Feed(auth: widget.auth, onSignedOut: widget.onSignedOut),
              DetailComplaint(),
              // ComplaintDialog('ewefwe'),
              ProfileScreen(),
              RaiseComplaint(),
            ];
            final List<Widget> children2 = [
              Feed(),
              User1(),
              User1()
            ];
            final List<Widget> children3 = [
              Feed(),
              User1(),
              User1(),
              User1(),
              User1()
            ];
            void onTapped(int index) {
              setState(() {
                currentIndex = index;
              });
            }
            const TYPE = 'student';
            return Scaffold(
                body: ( TYPE == 'admin')
                    ? children2[currentIndex]
                    : (TYPE == 'student')
                        ? children1[currentIndex]
                        : children3[currentIndex],
                bottomNavigationBar: (TYPE == 'admin')
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
                            Icons.person_add,
                            size: 30,
                            color: Colors.white,
                          ),
                        ],
                        onTap: onTapped,
                        index: currentIndex,
                      )
                    : (TYPE == 'student')
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
                                Icons.notifications,
                                size: 30,
                                color: Colors.white,
                              ),
                              Icon(
                                Icons.person,
                                size: 30,
                                color: Colors.white,
                              ),
                              Icon(
                                Icons.add,
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
                                Icons.person,
                                size: 30,
                                color: Colors.white,
                              ),
                              Icon(
                                Icons.add,
                                size: 30,
                                color: Colors.white,
                              ),
                              Icon(
                                Icons.assignment,
                                size: 30,
                                color: Colors.white,
                              ),
                            ],
                            onTap: onTapped,
                            index: currentIndex,
                          ));
        }
}