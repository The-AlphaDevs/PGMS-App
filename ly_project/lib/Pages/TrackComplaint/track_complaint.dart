import 'package:flutter/material.dart';
import 'package:ly_project/Models/ComplaintModel.dart';
import 'package:ly_project/Pages/TrackComplaint/ComplaintTimeline.dart';
import 'package:ly_project/Pages/TrackComplaint/locationCard.dart';
import 'package:ly_project/Services/auth.dart';
import 'package:ly_project/Utils/colors.dart';

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
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: size.height * 0.005),
            ComplaintCard(
              complaint: complaint.complaint,
              date: complaint.dateTime,
              location: complaint.location,
              latitude: double.parse(complaint.latitude),
              longitude: double.parse(complaint.longitude),
            ),
            SizedBox(height: size.height * 0.005),
            ComplaintTimeline(
                id: complaint.id,
                status: complaint.status,
                supervisorImageUrl: widget.supervisorImageUrl,
                complaint: complaint,
                auth: widget.auth,
              ),
          ],
        ),
      ),
    );
  }


}
