import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ly_project/Pages/TrackComplaint/ComplaintTimeline.dart';
import 'package:ly_project/Pages/TrackComplaint/locationCard.dart';
import 'package:ly_project/Services/auth.dart';
import 'package:ly_project/Utils/colors.dart';

class TrackComplaints extends StatefulWidget {
  final id;
  final complaint;
  final date;
  final location;
  final latitude;
  final longitude;
  final status;
  final BaseAuth auth;
  final supervisorImageUrl;

  TrackComplaints({
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
  _TrackComplaintsState createState() => _TrackComplaintsState();
}

class _TrackComplaintsState extends State<TrackComplaints>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Track Complaint"),
        backgroundColor: DARK_BLUE,
      ),
      body: Column(
        children: [
          SizedBox(height: size.height * 0.05),
          ComplaintCard(
            complaint: widget.complaint,
            date: widget.date,
            location: widget.location,
            latitude: widget.latitude,
            longitude: widget.longitude,
          ),
          SizedBox(height: size.height * 0.05),
          ComplaintTimeline(
            id: widget.id,
            status: widget.status,
            supervisorImageUrl: widget.supervisorImageUrl
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 100, vertical: 40),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FlatButton(
                minWidth: 5,
                onPressed: () {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.WARNING,
                    animType: AnimType.BOTTOMSLIDE,
                    title: 'Close Complaint',
                    desc: 'Do you want to really close this complaint?',
                    btnCancelOnPress: () {
                      // Navigator.pop(context);
                    },
                    btnOkOnPress: () async {
                      String result = await closeComplaint();
                      print("result:" + result);
                      if (result == "Status Updated") {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      } else if (result == "Status not resolved") {
                        print("andar aya");
                        AwesomeDialog(
                            context: context,
                            dialogType: DialogType.ERROR,
                            title: 'Cannot close Complaint',
                            desc:
                                'Cannot close this Complaint since it is not resolved yet!',
                            btnCancelOnPress: () {},
                            btnOkOnPress: () {})
                          ..show();
                      }
                    },
                  )..show();
                },
                color: Colors.orange[900],
                textColor: Colors.white,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.close),
                    SizedBox(width: 15),
                    Text("Close Complaint"),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String> closeComplaint() async {
    final user = widget.auth.currentUserEmail();
    try {
      if (widget.status == 'Resolved') {
        await FirebaseFirestore.instance
            .collection("complaints")
            .doc(widget.id)
            .update({
          "status": "Closed",
        });
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user)
            .collection('notifications')
            .doc(widget.id)
            .delete();
        return "Status Updated";
      } else {
        return "Status not resolved";
      }
    } catch (e) {
      return "Failed to update status: $e";
    }
  }
}
