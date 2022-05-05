import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ly_project/Models/ComplaintModel.dart';
import 'package:ly_project/Pages/TrackComplaint/track_complaint.dart';
import 'package:ly_project/Services/auth.dart';

class NotifsCard extends StatefulWidget {
  final id;
  final complaint;
  final date;
  final location;
  final latitude;
  final longitude;
  final status;
  final BaseAuth auth;
  final supervisorImageUrl;

  NotifsCard({
    @required this.auth,
    @required this.id,
    @required this.complaint,
    @required this.date,
    @required this.location,
    @required this.latitude,
    @required this.longitude,
    @required this.status,
    @required this.supervisorImageUrl,
  });

  @override
  State<NotifsCard> createState() => _NotifsCardState();
}

class _NotifsCardState extends State<NotifsCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.015),
      color: Colors.amber[100],
      child: ListTile(
        onTap: () async{
          QuerySnapshot complaintSnapshot = await FirebaseFirestore.instance.collection("complaints").where("id", isEqualTo: widget.id).get();
          if(complaintSnapshot != null){
            Map<String, dynamic> snapshot = complaintSnapshot.docs.first.data();
            Complaint complaint = Complaint.fromJSON(snapshot);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => 
                    TrackComplaints(
                      auth: widget.auth,
                      complaint: complaint,
                      supervisorImageUrl: snapshot["supervisorImageData"]["url"],
                    ),
                ),
            );
          }else{
            print("Error finding complaint!");
          }
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
        title: Text("Congratulations!!",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
        subtitle: Text(
            "\nYour Complaint \"" + widget.complaint + "\" has been resolved.",
            style: TextStyle(fontSize: 14)),
      ),
    );
  }
}
