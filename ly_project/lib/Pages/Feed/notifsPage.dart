import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ly_project/Services/auth.dart';
import 'package:ly_project/utils/colors.dart';
import 'package:uuid/uuid.dart';
import 'package:ly_project/Pages/Feed/notifsCard.dart';

class Notifications extends StatefulWidget {
  final BaseAuth auth;
  Notifications({this.auth});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  var uuid = Uuid();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final user = widget.auth.currentUserEmail();
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        backgroundColor: DARK_BLUE,
        title: Text(
          "Notifications",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(size.width * 0.03, size.height * 0.03,
            size.width * 0.03, size.height * 0.06),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("supervisors")
                .doc(user)
                .collection('notifications')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                print("Connection state: has no data");
                return Column(
                  children: [
                    SizedBox(height: size.height * 0.2),
                    CircularProgressIndicator(),
                  ],
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                print("Connection state: waiting");
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
                  return Center(child: Text("No Notifications"));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    shrinkWrap: true,
                    key: new Key(uuid.v4()),
                    itemBuilder: (context, index) {
                      return NotifsCard(
                        supervisorDocRef: snapshot.data.docs[index]
                            ["supervisorDocRef"],
                        docId: snapshot.data.docs[index]['docId'],
                        id: snapshot.data.docs[index]["id"],
                        auth: widget.auth,
                        complaint: snapshot.data.docs[index]["complaint"],
                        date: snapshot.data.docs[index]["dateTime"],
                        status: snapshot.data.docs[index]["status"],
                        image: snapshot.data.docs[index]["imageurl"],
                        location: snapshot.data.docs[index]["location"],
                        supervisor: snapshot.data.docs[index]["supervisorName"],
                        supervisorEmail: snapshot.data.docs[index]
                            ["supervisorEmail"],
                        lat: snapshot.data.docs[index]["latitude"],
                        ward: snapshot.data.docs[index]["ward"],
                        long: snapshot.data.docs[index]["longitude"],
                        description: snapshot.data.docs[index]["description"],
                        citizenEmail: snapshot.data.docs[index]["citizenEmail"],
                        supervisorImageUrl: snapshot.data.docs[index]["supervisorImageUrl"],
                      );
                    },
                  );
                }
              }
            }),
      ),
    );
  }
}
