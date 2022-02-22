import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<String> signInWithEmailAndPassword(String email, String password);
  Future<String> createUserWithEmailAndPassword(String email, String password);
  Future<String> currentUserEmail();
  Future<void> signOut();
  Future<String> currentUser();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<String> signInWithEmailAndPassword(String email, String password) async {
    print("sign in with email and password k andar aaya!!!!");
    final User loginuser = (await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).user;

    return loginuser?.uid;
  }

  @override
  Future<String> createUserWithEmailAndPassword(String email, String password) async {
    final User registeruser = (await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).user;
    return registeruser?.uid;
  }

  @override
  Future<String> currentUserEmail() async {

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
  }

  @override
  Future<void> signOut() async {
    print("Signout called !!!");
    return _firebaseAuth.signOut();
  }
}