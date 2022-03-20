import 'package:cloud_firestore/cloud_firestore.dart';

class FeedServices {
  static get complaintStream => FirebaseFirestore.instance
      .collection("complaints")
      .where("status", whereIn: ["Pending", "In Progress"])
      .orderBy("upvoteCount", descending: true)
      .snapshots()
      .distinct();

  static Stream<QuerySnapshot> getNotificationStream(String user) => FirebaseFirestore.instance
      .collection('users')
      .doc(user)
      .collection('notifications')
      .snapshots()
      .distinct();
}
