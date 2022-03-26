import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ly_project/Services/auth.dart';
import 'navigation.dart';
import 'landing.dart';

class RootPage extends StatefulWidget {
  final BaseAuth auth;
  RootPage({@required this.auth});
  @override
  State<StatefulWidget> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Column(
              children: [Text("Initializing..."), CircularProgressIndicator()],
            ),
          );
        }
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text(
                  "Something went wrong. Please restart the app or try to clear cache."),
            ),
          );
        }
        if (snapshot.hasData) {
          User user = snapshot.data;
          if (user == null) {
            return LandingPage(auth: widget.auth);
          }
          return BottomNavBar(auth: widget.auth, userEmail: user.email);
        }
        if ((snapshot.connectionState == ConnectionState.active) &&
            (!snapshot.hasData)) {
          return LandingPage(auth: widget.auth);
        }
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Please wait..."),
                SizedBox(height: 10),
                CircularProgressIndicator(),
              ],
            ),
          ),
        );
      },
    );
  }
}
