import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ly_project/auth.dart';
import 'navigation.dart';
import 'landing.dart';

class RootPage extends StatefulWidget {
  final BaseAuth auth;
  RootPage({this.auth});
  @override
  State<StatefulWidget> createState() => _RootPageState();
}

enum AuthStatus {
  notDetermined,
  notSignedIn,
  signedIn,
  // signedUp
}

class _RootPageState extends State<RootPage> {
  String role = "";
  String user = "";
  AuthStatus authStatus = AuthStatus.notSignedIn;

  @override
  void initState() {
    super.initState();
    print("Inside init state function");
    widget.auth.currentUserEmail().then((useremail) {
      user = useremail;
      if (user != ""){
      FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: useremail)
          .snapshots()
          .listen((data) {
        setState(() {
          role = 'citizen';
          print('Citizen Role: $role');
        });
      });

      FirebaseFirestore.instance
          .collection('supervisors')
          .where('email', isEqualTo: useremail)
          .snapshots()
          .listen((data) {
        setState(() {
          role = 'supervisor';
          print('Supervisor Role: $role');
        });
      });
      }
      print("Inside widget.auth.currentUser function");
      print("useremail: " + useremail.toString());
      setState(() {
        authStatus =
            (useremail == "" || useremail == null) ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  void _signedIn() {
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut() {
    setState(() {
      authStatus = AuthStatus.notSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notDetermined:
        return _buildWaitingScreen();
        break;

      case AuthStatus.notSignedIn:
        print('Welcome Screen');
        return MyLoginPage(
          auth: widget.auth,
          onSignedIn: _signedIn,
        );
        break;

      case AuthStatus.signedIn:
        if (role == "") {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ),
          );
        } else if (role == "citizen") {
          print('User1 Screen');
          return User1(
            auth: widget.auth,
            onSignedOut: _signedOut,
          );
        } else {
          print('Supervisor Screen');
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ),
          );
        }

        break;

      default:
        return _buildWaitingScreen();
    }
  }

  Widget _buildWaitingScreen() {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
      ),
    );
  }
}
