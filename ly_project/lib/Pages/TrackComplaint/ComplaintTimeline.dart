import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ly_project/Models/ComplaintModel.dart';
import 'package:ly_project/Services/auth.dart';
import 'package:ly_project/Widgets/Accordion.dart';
import 'package:ly_project/utils/colors.dart';
import 'package:ly_project/utils/constants.dart';
import 'package:timelines/timelines.dart';

class ComplaintTimeline extends StatefulWidget {
  final id;
  final status;
  final supervisorImageUrl;
  final Complaint complaint;
  final BaseAuth auth;
  ComplaintTimeline(
      {@required this.id,
      @required this.status,
      @required this.supervisorImageUrl,
      @required this.complaint,
      @required this.auth});
  @override
  State<ComplaintTimeline> createState() => _ComplaintTimelineState();
}

class _ComplaintTimelineState extends State<ComplaintTimeline> {
  Complaint complaint;
  int itemCount;
  int complaintStatusIndex;
  bool isLoading = false;
  List<String> statusStrings;
  @override
  void initState() {
    super.initState();
    complaint = widget.complaint;

    if(complaint.status == "Rejected"){
      statusStrings = statusForRejectedString;
    }
    else if (complaint.feedback != null) {
      statusStrings = statusWithIssueString;
    } else {
      statusStrings = statusWithNoIssuesString;
    }

    itemCount = statusStrings.length;
    complaintStatusIndex = statusStrings.indexOf(widget.complaint.status);
    if (complaintStatusIndex < 0) {
      complaintStatusIndex = 0;
    }
    print("statusStrings");
    print(statusStrings);
  }

  bool isEdgeIndex(int index) => (index == 0 || index == itemCount - 1);
  
  bool isStepComplete(int index) => index <= complaintStatusIndex;
  
  void setLoading(bool isLoadingValue) =>
      setState(() => isLoading = isLoadingValue);

  String formatDateTime(String dateTime)=> (DateFormat.yMMMMd().format(DateTime.parse(dateTime)) + " at " + DateFormat.jms().format(DateTime.parse(dateTime)));

  String getDateTime(String status){
    String dateTime = status + " time";
    switch (status) {
      case "Pending":
          if(complaint.imageData.dateTime != null){
            dateTime = formatDateTime(complaint.imageData.dateTime);
          }
        break;
      case "In Progress":
        if(complaint.dateTime != null){
            dateTime = formatDateTime(complaint.dateTime);
          }
        break;
      case "Resolved":
        if(complaint.resolutionDateTime != null){
            dateTime = formatDateTime(complaint.resolutionDateTime);
          }
        break;
      case "Issue Reported":
        if(complaint.issueReportedDateTime != null){
            dateTime = formatDateTime(complaint.issueReportedDateTime);
          }
        break;
      case "Closed":
        if(complaint.closedDateTime != null){
            dateTime = formatDateTime(complaint.closedDateTime);
        }
        break;
      case "Rejected":
        if(complaint.closedDateTime != null){
            dateTime = formatDateTime(complaint.closedDateTime);
        }
        break;
      default:
        dateTime = status + " time";
    }
    return dateTime;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Timeline.tileBuilder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        // padding: EdgeInsets.symmetric(vertical: 5.0),
        theme: TimelineThemeData(
          nodePosition: 0,
          connectorTheme: ConnectorThemeData(
            thickness: 3.0,
            color: Color(0xffd3d3d3),
          ),
          indicatorTheme: IndicatorThemeData(size: 15.0),
        ),

        builder: TimelineTileBuilder.connected(
          itemCount: itemCount,
          indicatorBuilder: (_, index) => dotIndicator(index),
          contentsAlign: ContentsAlign.basic,
          connectorBuilder: (_, index, __) {
            if (index < complaintStatusIndex) {
              return SolidLineConnector(color: Color(0xff6ad192));
            }
            if (index == complaintStatusIndex) {
              return DashedLineConnector(color: Color(0xff6ad192), gap: 2.5);
            }
            if (!isEdgeIndex(index)) {
              return SolidLineConnector();
            }
          },
          contentsBuilder: (context, index) => timelineTile(context, index),
        ),
      ),
    );
  }

  Widget dotIndicator(int index) {
    IconData boxIcon;
    bool isComplete = isStepComplete(index);
    if (isComplete) {
      boxIcon = Icons.check;
    } else {
      boxIcon = Icons.circle;
    }
    return DotIndicator(
      color: isComplete ? Color(0xff6ad192) : Colors.grey,
      child: Icon(boxIcon, color: Colors.white, size: 15.0),
    );
  }

  Widget timelineTile(BuildContext context, int index, [String imageUrl]) {
    Size size = MediaQuery.of(context).size;
    Color boxColor, borderColor;
    bool isComplete = isStepComplete(index);
    String title, message, dateTime;

    if (isComplete) {
      boxColor =
          COMPLAINT_STATUS_COLOR_MAP[statusStrings[index]].withOpacity(0.35);
      borderColor = COMPLAINT_STATUS_COLOR_MAP[statusStrings[index]];
      title = tlCompleteTitles[statusStrings[index]];
      message = tlCompleteMessages[statusStrings[index]];
      dateTime = getDateTime(statusStrings[index]);
    } else {
      boxColor = Colors.red[100];
      if (index == complaintStatusIndex) {
        title = tlOngoingTitles[statusStrings[index]];
        message = tlOngoingMessages[statusStrings[index]];
        dateTime = getDateTime(statusStrings[index]);
      } else {
        title = tlIncompleteTitles[statusStrings[index]]??"title" + "";
        message = tlIncompleteMessages[statusStrings[index]]?? "message";
      }
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.symmetric(vertical: size.height * 0.015),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Container(
          decoration: BoxDecoration(
              color: isComplete ? boxColor : Colors.grey[200],
              border:
                  Border.all(color: isComplete ? borderColor : Colors.red[200]),
              borderRadius: BorderRadius.all(Radius.circular(12))),
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 12),
          child: Row(
            children: <Widget>[
              SizedBox(width: size.width * 0.025),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: isComplete ? Colors.black87 : Colors.black38,
                      ),
                    ),
                    if(isComplete)
                    Column(
                      children:[
                        SizedBox(height: size.height * 0.005),
                        Text(
                          dateTime,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black45,
                          ),
                        ),
                      ]
                    ),
                    SizedBox(height: size.height * 0.012),
                    Text(
                      message,
                      maxLines: 10,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: isComplete ? Colors.black45 : Colors.grey[400],
                      ),
                    ),
                    SizedBox(height: size.height * 0.005),
                    if (complaint.status == "Resolved" &&
                        statusStrings[index] == "Resolved")
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          isLoading
                              ? CircularProgressIndicator()
                              : CloseComplaintButton(
                                  complaint: complaint,
                                  auth: widget.auth,
                                  setLoading: setLoading,
                                  parentContext: context),
                        ],
                      ),
                    if (statusStrings[index] == "Issue Reported" && isComplete)
                        Container(
                          margin: EdgeInsets.only(top:4, right: 15),
                          padding: EdgeInsets.symmetric(vertical:4, horizontal:8),
                          decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(12)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              Text("Issue:", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold,),),
                              Divider(color: Colors.grey, thickness: 1.5,),
                              Row(
                                children: [
                                  Flexible(child: Text(complaint.feedback ?? "Issue about work done", style: TextStyle(color: Colors.black54),)),
                                ],
                              ),

                            ]),
                        ),
                    SizedBox(height: size.height * 0.005),
                    if (statusStrings[index] == "Resolved" &&
                        complaint.supervisorImageData.url != null)
                      Container(
                        child: Accordion(title: "Photo of the work done", image: complaint.supervisorImageData.url),
                      ),
                    if (statusStrings[index] == "Pending" &&
                        complaint.imageData.url != null)
                      Container(
                        child: Accordion(title: "Photo submitted by you", image: complaint.imageData.url),
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CloseComplaintButton extends StatelessWidget {
  final Complaint complaint;
  final BaseAuth auth;
  final Function setLoading;
  final BuildContext parentContext;
  const CloseComplaintButton(
      {Key key,
      @required this.complaint,
      @required this.auth,
      @required this.setLoading,
      @required this.parentContext});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
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
                setLoading(true);
                String result = await closeComplaint();
                print("result:" + result);
                if (result == "Status Updated") {
                  Navigator.pop(parentContext);
                  Navigator.pop(parentContext);
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
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.close),
              SizedBox(width: 8),
              Text("Close Complaint"),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> closeComplaint() async {
    final user = auth.currentUserEmail();
    try {
      DocumentReference complaintDocRef =
          FirebaseFirestore.instance.collection("complaints").doc(complaint.id);
      DocumentReference wardDocRef =
          FirebaseFirestore.instance.collection("wards").doc(complaint.wardId);
      DocumentReference supervisorDocRef = complaint.supervisorDocRef;
      DocumentReference notificationDocRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user)
          .collection('notifications')
          .doc(complaint.id);

      int points = complaint.overdue
          ? OVERDUE_NO_ISSUE_COMPLETION_POINTS
          : NO_OVERDUE_NO_ISSUE_COMPLETION_POINTS;

      if (complaint.status == 'Resolved') {
        await FirebaseFirestore.instance.runTransaction((transaction) async {
          /// Change complaint status to "Closed"
          transaction.set(
              complaintDocRef,
              {"status": "Closed", "closedDateTime": DateTime.now().toString()},
              SetOptions(merge: true));

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
          if (complaint.overdue) {
            transaction.update(supervisorDocRef, {
              "complaintsOverdue": FieldValue.increment(-1),
              "complaintsCompleted": FieldValue.increment(1),
              "score": FieldValue.increment(points)
            });
          } else {
            transaction.update(supervisorDocRef, {
              "complaintsCompleted": FieldValue.increment(1),
              "score": FieldValue.increment(points)
            });
          }

          //Delete Notification
          transaction.delete(notificationDocRef);
        });
        setLoading(false);
        return "Status Updated";
      } else {
        return "Status not resolved";
      }
    } catch (e) {
      setLoading(false);
      return "Failed to update status: $e";
    }
  }
}
