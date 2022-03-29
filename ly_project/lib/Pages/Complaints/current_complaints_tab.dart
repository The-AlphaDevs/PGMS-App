import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ly_project/Pages/Feed/feedCard.dart';
import 'package:ly_project/Pages/Feed/feedCardShimmer.dart';
import 'package:ly_project/Services/auth.dart';
import 'package:uuid/uuid.dart';

class CurrentComplaintsTab extends StatefulWidget {
  final String userEmail;
  final BaseAuth auth;
  CurrentComplaintsTab({this.userEmail, this.auth});

  @override
  State<CurrentComplaintsTab> createState() => _CurrentComplaintsTabState();
}

class _CurrentComplaintsTabState extends State<CurrentComplaintsTab> {
  var uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
          right: size.width * 0.01,
          left: size.width * 0.01,
          top: size.height * 0.02,
          bottom: size.height * 0.03),
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("complaints")
              .where("citizenEmail", isEqualTo: widget.userEmail)
              .where("status", whereIn: ["Pending", "In Progress"])
              // .orderBy("dateTime", descending: true)
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
              if (snapshot.data.docs.length == 0) {
                return Center(
                  child: Text("No Past Feeds"),
                );
              } else {
                print(snapshot.data.docs.length);
                return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    String supervisorImageUrl = snapshot.data.docs[index]
                                  ['supervisorImageData'] ==
                              null
                          ? null
                          : snapshot.data.docs[index]['supervisorImageData']
                              ['url'];
                    return ComplaintOverviewCard(
                      auth: widget.auth,
                      id: snapshot.data.docs[index]["id"],
                      docId: snapshot.data.docs[index].id,
                      complaint: snapshot.data.docs[index]["complaint"],
                      date: snapshot.data.docs[index]["dateTime"],
                      status: snapshot.data.docs[index]["status"],
                      image: snapshot.data.docs[index]["imageData"]["url"],
                      location: snapshot.data.docs[index]["imageData"]
                          ["location"],
                      supervisor: snapshot.data.docs[index]["supervisorName"],
                      supervisorDocRef: snapshot.data.docs[index]["supervisorDocRef"],
                      
                      lat: snapshot.data.docs[index]["latitude"],
                      long: snapshot.data.docs[index]["longitude"],
                      description: snapshot.data.docs[index]["description"],
                      citizenEmail: snapshot.data.docs[index]["citizenEmail"],
                      upvoteCount: snapshot.data.docs[index]["upvoteCount"],
                      supervisorImageUrl:supervisorImageUrl
                    );
                  },
                );
              }
            }
          }),
    );
  }
}
