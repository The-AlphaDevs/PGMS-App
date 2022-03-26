import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:ly_project/Services/auth.dart';
import 'package:ly_project/Pages/Login/login.dart';
import 'package:ly_project/Pages/Registration/registration.dart';

class LandingPage extends StatefulWidget {
  final BaseAuth auth;
  LandingPage({this.auth});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool loginChange = false;
  bool registerChange = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment(0.0, 0.0),
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/logo_final.jpg"), //adding background image
                fit: BoxFit.fill,
              ),
            ),
          ),
          ListView(children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20.0),
                SizedBox(height: 500.0),
                Container(
                  child: RaisedButton(
                    padding: EdgeInsets.fromLTRB(48.0, 12.0, 48.0, 9.0),
                    elevation: 20.0,
                    shape: loginChange
                        ? RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white, width: 3.0),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0)))
                        : RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.transparent, width: 3.0),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0))),
                    color: loginChange ? Colors.transparent : Color(0xFFF49F1C),
                    onPressed: () =>
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(auth: widget.auth))),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                          fontFamily: 'JosefinSans',
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: loginChange ? Colors.white : Color(0xFF181D3D),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  padding: EdgeInsets.fromLTRB(34.0, 12.0, 34.0, 9.0),
                  elevation: 20.0,
                  shape: registerChange
                      ? RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white, width: 3.0),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0)))
                      : RoundedRectangleBorder(
                          side: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0))),
                  color:
                      registerChange ? Colors.transparent : Color(0xFFF49F1C),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage(auth: widget.auth)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      "REGISTER",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'JosefinSans',
                        fontSize: 18.0,
                        color:
                            registerChange ? Colors.white : Color(0xFF181D3D),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ]),
          SizedBox(height: 30.0),
        ],
      ),
    );
  }
}