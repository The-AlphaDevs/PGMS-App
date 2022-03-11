import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ly_project/utils/constants.dart';

/// Contains helper methods for processing the ward leaderboard data
class LeaderboardServices {
  static Stream<QuerySnapshot> getWardScores({String duration = "today"}) =>
      FirebaseFirestore.instance
          .collection("wards")
          .orderBy(L_DURATIONS_TO_DB_FIELD_MAP[duration], descending: true)
          .snapshots();

  static List<Map<String, String>> formatScores({
    @required String duration,
    @required List<QueryDocumentSnapshot> wardList
    }) {
    List<Map<String, String>> result = new List<Map<String, String>>();
    String field = L_DURATIONS_TO_DB_FIELD_MAP[duration];

    wardList.asMap().forEach((index, wardDoc) {
      result.add({
        "Rank": "${index + 1}",
        "Ward": wardDoc.data()["ward"],
        "Locality": wardDoc.data()["locality"],
        "Points": wardDoc.data()[field].toString()
      });
    });

    return result;
  }
}
