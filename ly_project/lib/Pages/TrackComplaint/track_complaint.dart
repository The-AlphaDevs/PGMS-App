import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ly_project/Models/ComplaintModel.dart';
import 'package:ly_project/Pages/TrackComplaint/ComplaintTimeline.dart';
import 'package:ly_project/Pages/TrackComplaint/locationCard.dart';
import 'package:ly_project/Services/auth.dart';
import 'package:ly_project/Utils/colors.dart';
import 'package:ly_project/utils/constants.dart';

class TrackComplaints extends StatefulWidget {
  final Complaint complaint;
  final BaseAuth auth;
  final String supervisorImageUrl;

  TrackComplaints({
    @required this.auth,
    @required this.complaint,
    @required this.supervisorImageUrl,
  });
  @override
  _TrackComplaintsState createState() => _TrackComplaintsState();
}

class _TrackComplaintsState extends State<TrackComplaints>
    with SingleTickerProviderStateMixin {
  Complaint complaint;
  
  @override
  void initState(){
    super.initState();
    complaint = widget.complaint;
  }
  
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
            complaint: complaint.complaint,
            date: complaint.dateTime,
            location: complaint.location,
            latitude: double.parse(complaint.latitude),
            longitude: double.parse(complaint.longitude),
          ),
          SizedBox(height: size.height * 0.05),
          ComplaintTimeline(
            id: complaint.id,
            status: complaint.status,
            supervisorImageUrl: widget.supervisorImageUrl
          ),
          if(complaint.status == "Resolved")
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
      DocumentReference complaintDocRef = FirebaseFirestore.instance.collection("complaints").doc(complaint.id);
      DocumentReference wardDocRef = FirebaseFirestore.instance.collection("wards").doc(complaint.wardId);
      DocumentReference supervisorDocRef = complaint.supervisorDocRef;
      DocumentReference notificationDocRef = FirebaseFirestore.instance.collection('users').doc(user).collection('notifications').doc(complaint.id);
      
      int points = complaint.overdue ? OVERDUE_NO_ISSUE_COMPLETION_POINTS : NO_OVERDUE_NO_ISSUE_COMPLETION_POINTS;
      
      if (complaint.status == 'Resolved') {
        await FirebaseFirestore.instance.runTransaction((transaction) async {
          /// Change complaint status to "Closed"
          transaction.set(complaintDocRef,
              {"status": "Closed", "closedDateTime":DateTime.now().toString()},
              SetOptions(merge : true)
          ); 
          
          /// Update ward points 
          transaction.update(wardDocRef, {
            "lifetimeScore": FieldValue.increment(points),
            "monthlyScore": FieldValue.increment(points),
            "realtimeScore": FieldValue.increment(points),
            "weeklyScore": FieldValue.increment(points),
            "yearlyScore": FieldValue.increment(points),
          });

          /// Update supervisor points and various complaint count:
          /// Increment count completed complaints and
          /// if the complaint was overdue, decrement overdue complaints by 1
          ///
          ///  Award supervisor the points for completing the work
          if(complaint.overdue){
            transaction.update(supervisorDocRef, {
              "complaintsOverdue": FieldValue.increment(-1),
              "complaintsCompleted": FieldValue.increment(1),
              "score": FieldValue.increment(points)
            });
          }else{
            transaction.update(supervisorDocRef, {
              "complaintsCompleted": FieldValue.increment(1),
              "score": FieldValue.increment(points)
            });
          }

          //Delete Notification 
          transaction.delete(notificationDocRef);
        });
        return "Status Updated";
      
      } else {
        return "Status not resolved";
      }
    } catch (e) {
      return "Failed to update status: $e";
    }
  }
}
