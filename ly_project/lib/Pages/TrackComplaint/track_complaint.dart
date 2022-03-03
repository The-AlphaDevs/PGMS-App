import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ly_project/Pages/TrackComplaint/ComplaintTimeline.dart';
import 'package:ly_project/Pages/TrackComplaint/locationCard.dart';
import 'package:ly_project/Utils/colors.dart';

class TrackComplaints extends StatefulWidget {
  final id;
  final complaint;
  final date;
  final location;
  final latitude;
  final longitude;
  final status;
  

  TrackComplaints({this.id, this.complaint, this.date, this.location, this.latitude, this.longitude, this.status});
  @override
  _TrackComplaintsState createState() => _TrackComplaintsState();
}

class _TrackComplaintsState extends State<TrackComplaints>with SingleTickerProviderStateMixin {

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

          ComplaintTimeline(id: widget.id, status: widget.status,),

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
                    btnOkOnPress: () async{
                      String result = await closeComplaint();
                      if(result=="Status Updated"){
                        Navigator.pop(context);
                        Navigator.pop(context);
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
                    SizedBox(width:15),
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

  Future<String> closeComplaint() async{
    try{
      await FirebaseFirestore.instance
      .collection("complaints")
      .doc(widget.id)
      .update({
        "status": "Closed",
      });
      return "Status Updated";
    }
    catch(e){
      return "Failed to update status: $e";
    }
  }

  
}
