import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ly_project/Services/DBServices.dart';
import 'package:ly_project/Services/auth.dart';
import 'package:ly_project/Utils/constants.dart';
import 'package:ly_project/utils/constant_strings.dart';
// import 'package:ly_project/utils/constants.dart';

class AuthServices {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static Future<void> registerUser({
    @required String email,
    @required String password,
    @required String name,
    @required String phone,
    @required String address,
    @required String ward,
    @required String occupation,
    @required String age,
    @required Function successCallback,
    @required Function errorCallback,
  }) async {
    try {
      final newUser = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final ds = await DBServices.getUserDoc(email);
      if (newUser != null && !ds.exists) {
        await DBServices.createUserDoc(
          address: address,
          age: age,
          email: email,
          name: name,
          occupation: occupation,
          phone: phone,
          ward: ward,
        );
        successCallback();
        return;
      }
      errorCallback(DEFAULT_AUTH_ERROR);
    } catch (e) {
      print("Error during login with email.");
      print(e);

      String errorMessage = DEFAULT_AUTH_ERROR;
      if (e is FirebaseAuthException) {
        print(e);
        print(e.code);
        errorMessage = emailRegistrationExceptionMessageMap[e.code] == null
            ? DEFAULT_AUTH_ERROR
            : emailRegistrationExceptionMessageMap[e.code];
      }

      print("Attempting to log out");
      Auth().signOut();
      errorCallback(errorMessage);
    }
  }
}
