import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ly_project/Pages/Feed/feedCard.dart';
import 'package:ly_project/Services/auth.dart';
import 'package:uuid/uuid.dart';

class CardListContainer extends StatefulWidget {
  final BaseAuth auth;
  final AsyncSnapshot<QuerySnapshot> snapshot;

  CardListContainer({Key key, @required this.snapshot, @required this.auth})
      : super(key: key);

  @override
  _CardListContainerState createState() => _CardListContainerState();
}

class _CardListContainerState extends State<CardListContainer> {
  final uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.snapshot.data.docs.length,
      padding: EdgeInsets.only(left: 10, right: 10),
      shrinkWrap: true,
      // cacheExtent: 5,
      key: new Key(uuid.v4()),
      itemBuilder: (context, index) {
        return ComplaintOverviewCard(
          docId: widget.snapshot.data.docs[index].id,
          id: widget.snapshot.data.docs[index]["id"],
          auth: widget.auth,
          complaint: widget.snapshot.data.docs[index]["complaint"],
          date: widget.snapshot.data.docs[index]["dateTime"],
          status: widget.snapshot.data.docs[index]["status"],
          image: widget.snapshot.data.docs[index]["imageData"]["url"],
          location: widget.snapshot.data.docs[index]["imageData"]["location"],
          supervisor: widget.snapshot.data.docs[index]["supervisorName"],
          supervisorDocRef: widget.snapshot.data.docs[index]
              ["supervisorDocRef"],
          lat: widget.snapshot.data.docs[index]["latitude"],
          long: widget.snapshot.data.docs[index]["longitude"],
          description: widget.snapshot.data.docs[index]["description"],
          citizenEmail: widget.snapshot.data.docs[index]["citizenEmail"],
          upvoteCount: widget.snapshot.data.docs[index]["upvoteCount"],
        );
      },
    );
  }
}
