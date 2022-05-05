import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ly_project/Models/ComplaintModel.dart';
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
        String supervisorImageUrl = widget.snapshot.data.docs[index]
                                  ['supervisorImageData'] ==
                              null
                          ? null
                          : widget.snapshot.data.docs[index]['supervisorImageData']
                              ['url'];

        return ComplaintOverviewCard(
          auth: widget.auth,
          complaint: Complaint.fromJSON( widget.snapshot.data.docs[index].data()),
          docId: widget.snapshot.data.docs[index].id,
          supervisorImageUrl:supervisorImageUrl,
        );
      },
    );
  }
}
