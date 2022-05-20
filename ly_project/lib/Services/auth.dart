import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseAuth {
  Future<String> signInWithEmailAndPassword(String email, String password);
  Future<String> createUserWithEmailAndPassword(String email, String password);
  String currentUserEmail();
  Future<void> signOut();
  Future<String> currentUser();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<String> signInWithEmailAndPassword(String email, String password) async {
    final User loginuser = (await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).user;
    // if(loginuser!=null){
    //   var userDoc = await FirebaseFirestore.instance.collection('users').doc(loginuser.email).get();
    //   // var userWard = sharedPreferr@
    //   var ward = userDoc.data()['ward'];
    //   final prefs = await SharedPreferences.getInstance();
    //   await prefs.setString('userWard', ward);
    //   print("USER WARD: " + ward.toString());
    // }
    return loginuser?.uid;
  }

  @override
  Future<String> createUserWithEmailAndPassword(String email, String password) async {
    final User registeruser = (await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).user;
    return registeruser?.uid;
  }

  @override
  String currentUserEmail() {

  String useremail = "";
    if (_firebaseAuth.currentUser !=  null){
      useremail = _firebaseAuth.currentUser.email;
    }

    print("User email: " + useremail);
    return useremail;
  }

  @override
  Future<String> currentUser() async {
    if (_firebaseAuth.currentUser !=  null){
      return _firebaseAuth.currentUser.uid;
    }
    return "";
  }

  @override
  Future<void> signOut() async {
    print("Signout called !!!");
    return _firebaseAuth.signOut();
  }
}