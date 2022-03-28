import 'package:flutter/material.dart';
import 'package:ly_project/Pages/DetailedComplaint/detailed_complaint.dart';
import 'package:ly_project/Services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotifsCard extends StatefulWidget {
  final id;
  final BaseAuth auth;
  final status;
  final image;
  final date;
  final supervisor;
  final lat;
  final long;
  final complaint;
  final location;
  final description;
  final citizenEmail;
  final docId;
  final supervisorDocRef;
  final supervisorEmail;

  NotifsCard({
    @required this.id,
    @required this.auth,
    @required this.complaint,
    @required this.description,
    @required this.location,
    @required this.status,
    @required this.image,
    @required this.date,
    @required this.supervisor,
    @required this.lat,
    @required this.long,
    @required this.citizenEmail,
    @required this.docId,
    @required this.supervisorDocRef,
    @required this.supervisorEmail,
  });

  @override
  State<NotifsCard> createState() => _NotifsCardState();
}

class _NotifsCardState extends State<NotifsCard> {
  @override
  Widget build(BuildContext context) {
    final user = widget.auth.currentUserEmail();
    Size size = MediaQuery.of(context).size;
    return Card(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.015),
      color: Colors.amber[100],
      child: ListTile(
        onTap: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailComplaint(
                        supervisorDocRef: widget.supervisorDocRef,
                        auth: widget.auth,
                        id: widget.id,
                        docId: widget.docId,
                        complaint: widget.complaint,
                        description: widget.description,
                        // name: widget.name,
                        date: widget.date,
                        status: widget.status,
                        image: widget.image,
                        supervisor: widget.supervisor,
                        location: widget.location,
                        lat: widget.lat,
                        long: widget.long,
                        citizenEmail: widget.citizenEmail,
                        supervisorEmail: widget.supervisorEmail,
                      )));
          await FirebaseFirestore.instance
              .collection('supervisors')
              .doc(user)
              .collection('notifications')
              .doc(widget.id)
              .delete();
        },
        leading: CircleAvatar(
          radius: size.width * 0.04,
          backgroundColor: Colors.green,
          child: Icon(
            Icons.check,
            color: Colors.white,
          ),
        ),
        trailing: Icon(Icons.keyboard_arrow_right,
            color: Colors.black, size: size.width * 0.1),
        title: Text("Attention!!",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
        subtitle: Text(
            "\n New Complaint \"" +
                widget.complaint +
                "\" has been assign to you.",
            style: TextStyle(fontSize: 14)),
      ),
    );
  }
}
