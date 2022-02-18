import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ly_project/Pages/TrackComplaint/ComplaintTimeline.dart';
import 'package:ly_project/Pages/TrackComplaint/locationCard.dart';

class TrackComplaints extends StatefulWidget {
  const TrackComplaints({Key key}) : super(key: key);
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
        title: Text("Complaint Status"),
      ),
      body: Column(
        children: [
          SizedBox(height: size.height * 0.02),
          ComplaintCard(),
          ComplaintTimeline(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 70, vertical: 20),
            child: FlatButton(
              minWidth: 5,
              onPressed: () => {},
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
        ],
      ),
    );
  }
}
