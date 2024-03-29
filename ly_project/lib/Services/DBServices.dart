import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DBServices {
  static Future<void> createUserDoc({
    @required String name,
    @required String email,
    @required String phone,
    @required String address,
    @required String ward,
    @required String occupation,
    @required String age,
  }) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(email.trim().toLowerCase())
        .set({
      'name': name,
      'email': email.trim().toLowerCase(),
      'mobile': phone.trim(),
      'photo':
          "https://www.winhelponline.com/blog/wp-content/uploads/2017/12/user.png",
      'address': address,
      'age': age,
      'ward': ward,
      'date': DateTime.now().toString(),
      'occupation': occupation,
    });
  }

  static Future<DocumentSnapshot> getUserDoc(String email) async {
    final ds =
        await FirebaseFirestore.instance.collection('users').doc(email).get();
    return ds;
  }
}
