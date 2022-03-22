import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ly_project/Services/auth.dart';
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
    String useremail = widget.auth.currentUserEmail();
    user = useremail;
    if (user != "" && role==""){
      FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: useremail)
        .get()
        .then((citizenDocSnapshot) => {
          if(citizenDocSnapshot.docs.isNotEmpty && citizenDocSnapshot.size > 0){
              setState(() {
                role = 'citizen';
                print('Citizen Role: $role');
              })
            }
          }
        );
      FirebaseFirestore.instance
          .collection('supervisors')
          .where('email', isEqualTo: useremail)
          .get()
          .then((supervisorDocSnapshot) => {
          if(supervisorDocSnapshot.docs.isNotEmpty && supervisorDocSnapshot.size > 0){
              setState(() {
              role = 'supervisor';
              print('supervisor Role: $role');
            })
          }
        }
      );
    }
    
    print("Inside widget.auth.currentUser function");
    print("useremail: " + useremail.toString());
    setState(() {
      authStatus =
          (useremail == "" || useremail == null) ? AuthStatus.notSignedIn : AuthStatus.signedIn;
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
        return LandingPage(
          auth: widget.auth,
          onSignedIn: _signedIn,
        );
        break;

      case AuthStatus.signedIn:
        // if (role == "") {
        //   return Scaffold(
        //     body: Center(
        //       child: CircularProgressIndicator(
        //         valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
        //       ),
        //     ),
        //   );
        // } else 
        // if (role == "citizen") {
          print('User1 Screen');
          return BottomNavBar(
            auth: widget.auth,
            onSignedOut: _signedOut,
            userEmail: user,
          );

        
        } else {
          // TODO: Put Supervisor Feed Page here 
          print('Supervisor Screen');
          return BottomNavBar(
            auth: widget.auth,
            onSignedOut: _signedOut,
            userEmail: user,
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
