import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ly_project/Pages/Feed/feedCard.dart';
import 'package:ly_project/Pages/Feed/feedCardShimmer.dart';
import 'package:ly_project/Services/auth.dart';
import 'package:uuid/uuid.dart';

class FeedTab extends StatefulWidget {
  final BaseAuth auth;
  FeedTab({this.auth});

  @override
  State<FeedTab> createState() => _FeedTabState();
}

class _FeedTabState extends State<FeedTab> {
  var uuid = Uuid();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.fromLTRB(10, size.height * 0.2, 10, 20),
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("complaints")
              .where("status", whereIn: ["Pending", "In Progress"])
              .where("supervisorEmail", isEqualTo: widget.auth.currentUserEmail())
              .orderBy("upvoteCount", descending: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ListView.builder(
                  itemCount: 5,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  shrinkWrap: true,
                  key: new Key(uuid.v4()),
                  itemBuilder: (context, index) =>
                      ComplaintOverviewCardShimmer(size));
            }

            if (snapshot.hasError) {
              return Card(
                child: Center(
                  child: Text("Something went wrong!"),
                ),
              );
            }
            if (!snapshot.hasData) {
              print("Connection state: has no data");
              return Column(
                children: [
                  SizedBox(
                    height: size.height * 0.2,
                  ),
                  CircularProgressIndicator(),
                ],
              );
            } else {
              print("Connection state: hasdata");
              if (snapshot.data.docs.length == 0) {
                return Center(
                  child: Text("No Past Feeds"),
                );
              } else {
                print("List built !!");
                return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  shrinkWrap: true,
                  key: new Key(uuid.v4()),
                  itemBuilder: (context, index) {
                    return ComplaintOverviewCard(
                      docId: snapshot.data.docs[index].id,
                      supervisorDocRef: snapshot.data.docs[index]["supervisorDocRef"],
                      id: snapshot.data.docs[index]["id"],
                      auth: widget.auth,
                      complaint: snapshot.data.docs[index]["complaint"],
                      date: snapshot.data.docs[index]["dateTime"],
                      status: snapshot.data.docs[index]["status"],
                      image: snapshot.data.docs[index]["imageData"]["url"],
                      location: snapshot.data.docs[index]["imageData"]["location"],
                      supervisor: snapshot.data.docs[index]["supervisorName"],
                      supervisorEmail: snapshot.data.docs[index]["supervisorEmail"],
                      lat: snapshot.data.docs[index]["latitude"],
                      long: snapshot.data.docs[index]["longitude"],
                      description: snapshot.data.docs[index]["description"],
                      citizenEmail: snapshot.data.docs[index]["citizenEmail"],
                      upvoteCount: snapshot.data.docs[index]["upvoteCount"],
                      overdue: snapshot.data.docs[index]["overdue"],
                    );
                  },
                );
              }
            }
          }),
    );
  }
}
