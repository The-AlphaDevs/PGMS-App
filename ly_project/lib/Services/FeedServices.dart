import 'package:cloud_firestore/cloud_firestore.dart';

class FeedServices {
  static get complaintStream => FirebaseFirestore.instance
      .collection("complaints")
      .where("status", whereIn: ["Pending", "In Progress"])
      .orderBy("upvoteCount", descending: true)
      .snapshots()
      .distinct();

  static Stream<QuerySnapshot> getNotificationStream(String user) =>
      FirebaseFirestore.instance
          .collection('supervisors')
          .doc(user)
          .collection('notifications')
          .snapshots();

  static Stream<QuerySnapshot> getHistoryStream(String supervisorEmail) =>
      FirebaseFirestore.instance
          .collection("complaints")
          .where("supervisorEmail", isEqualTo: supervisorEmail)
          .where("status", whereIn: ["Resolved", "Closed"]).snapshots();

  static Stream<QuerySnapshot> getOverdueStream(String supervisorEmail) =>
      FirebaseFirestore.instance
          .collection("complaints")
          .where("supervisorEmail", isEqualTo: supervisorEmail)
          .where("status", isEqualTo: "In Progress")
          .where("overdue", isEqualTo: true)
          .snapshots();

  static Stream<QuerySnapshot> getCurrentStream(String supervisorEmail) =>
      FirebaseFirestore.instance
          .collection("complaints")
          .where("supervisorEmail", isEqualTo: supervisorEmail)
          .where("status", whereIn: ["In Progress"])
          .orderBy("upvoteCount", descending: true)
          .snapshots();
}
