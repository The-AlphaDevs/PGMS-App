import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ly_project/utils/constants.dart';

class SupScorecardServices {
  static Future<DocumentSnapshot> getPersonalPerformance({
    @required String email,
  }) {
    return FirebaseFirestore.instance
        .collection("supervisors")
        .doc(email)
        .get();
  }

  static Future<DocumentSnapshot> getSupervisorPerformance({
    @required DocumentReference supervisorDocRef,
  }) {
    return supervisorDocRef
        .get();
  }

  static Map<String, String> getLevelInfo(int score) {
    String level = "0", levelName = "Level";
    for (String levelInfo in SUPERVISOR_LEVELS["levels"].keys) {
      List<int> scoreRange = SUPERVISOR_LEVELS["levels"][levelInfo]["scores"];
      int minScore = scoreRange[0], maxScore = scoreRange[1];
      if (minScore <= score && score <= maxScore) {
        level = levelInfo;
        levelName = SUPERVISOR_LEVELS["levels"][levelInfo]["levelName"];
        break;
      }
    }
    return {"level": level, "levelName": levelName};
  }
}
