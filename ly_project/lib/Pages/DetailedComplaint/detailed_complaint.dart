import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ly_project/Models/ComplaintModel.dart';
import 'package:ly_project/Pages/DetailedComplaint/FullScreenImage.dart';
import 'package:ly_project/Pages/SupervisorScorecard/SupervisorScorecard.dart';
import 'package:ly_project/Widgets/Map.dart';
import 'package:ly_project/Pages/TrackComplaint/track_complaint.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ly_project/Pages/Comments/commentsCard.dart';
import 'package:ly_project/Services/auth.dart';
import 'package:ly_project/utils/colors.dart';
import 'package:geolocator/geolocator.dart';

class DetailComplaint extends StatefulWidget {

  final BaseAuth auth;
  final docId;
  final Complaint complaint;
  final supervisorImageUrl;


  DetailComplaint({
    @required this.auth,
    @required this.complaint,
    @required this.docId,
    @required this.supervisorImageUrl,
  });
  @override
  _DetailComplaintState createState() => _DetailComplaintState();
}

class _DetailComplaintState extends State<DetailComplaint> {
  Complaint complaint;

  String id;
  String status;
  String image;
  String date;
  String supervisor;
  String location;
  double latitude;
  double longitude;
  String description;
  String _name = "";
  String _photo = "";
  String appBarTitle = "";
  double distanceInMeters;
  final _formKey = GlobalKey<FormState>();
  final _issueFormKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController _commentController = new TextEditingController();
  TextEditingController _issueController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    complaint = widget.complaint;
    // latitude = double.parse(complaint.latitude);
    latitude = complaint.imageData.lat;
    // longitude = double.parse(complaint.longitude);
    longitude = complaint.imageData.long;
    String complaintStr = complaint.complaint.toString();
    appBarTitle =
        "${complaintStr.substring(0, complaintStr.length > 25 ? 25 : complaintStr.length)} ${complaintStr.length > 25 ? '...' : ''}";
  }

  void printDistance(){
    distanceInMeters = Geolocator.distanceBetween(19.0729945, 72.89921259972223, 19.072989, 72.899208);
    print("distanceInMeters: " + distanceInMeters.toString() + " meters");
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    printDistance();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          appBarTitle ?? "Ye null hai 1",
          style: TextStyle(
              fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: DARK_BLUE,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: screenSize.height * 0.02),
              CarouselSlider(
                items: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: ImageFullScreenWrapperWidget(
                      child: CachedNetworkImage(
                        imageUrl: complaint.imageData.url,
                        placeholder: (context, url) => Center(
                            child: Container(
                                height: 40,
                                width: 500,
                                child: CircularProgressIndicator())),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        fit: BoxFit.fitHeight,
                      ),
                      dark: true,
                    ),
                  ),

                  ComplaintMap(latitude: latitude, longitude: longitude),

                  complaint.supervisorImageData.url != null ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: ImageFullScreenWrapperWidget(
                      child: CachedNetworkImage(
                        imageUrl: complaint.supervisorImageData.url,
                        placeholder: (context, url) => Center(
                            child: Container(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator())),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        fit: BoxFit.fitHeight,
                      ),
                      dark: true,
                    ),
                  ):Center(child: Text("Supervisor Image Not Available", style: TextStyle(fontWeight: FontWeight.bold),),),
                ],
                options: CarouselOptions(
                  height: screenSize.height * 0.30,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: false,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  viewportFraction: 0.75,
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: screenSize.height * 0.015),
                child: Divider(thickness: 1.5),
              ),
              complaintDetails(screenSize),
              SizedBox(height: screenSize.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  
                  // sendNotifButton(context, screenSize),
                  trackComplaintButton(context, screenSize),
                  if(complaint.status == "Resolved")
                      raiseIssueButton(context, screenSize)

                ],
              ),
              SizedBox(height: screenSize.height * 0.03),
              commentBar(context, screenSize),
              SizedBox(height: screenSize.height * 0.01),
            ],
          ),
        ),
      ),
    );
  }

  Container commentBar(BuildContext context, Size screenSize) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: screenSize.height * 0.003,
          horizontal: screenSize.width * 0.02),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.grey[300]),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.white,
                    //elevates modal bottom screen
                    elevation: 100,
                    // gives rounded corner to modal bottom screen
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    builder: (BuildContext context) {
                      return Container(
                        height: size.height * 0.75,
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: size.width * 0.005,
                              left: size.width * 0.005,
                              top: size.height * 0.01,
                              bottom: size.height * 0.01),
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("complaints")
                                .doc(widget.docId)
                                .collection("comments")
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                print("Connection state: has no data");
                                return Column(
                                  children: [
                                    SizedBox(
                                      height: size.height * 0.2,
                                    ),
                                    CircularProgressIndicator(),
                                  ],
                                );
                              } else if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                print("Connection state: waiting");
                                return Column(
                                  children: [
                                    SizedBox(
                                      height: size.height * 0.2,
                                    ),
                                    CircularProgressIndicator(),
                                  ],
                                );
                              } else {
                                if (snapshot.data.docs.length == 0) {
                                  return Center(
                                    child: Text("No Comments"),
                                  );
                                } else {
                                  return ListView.builder(
                                    // scrollDirection: Axis.vertical,
                                    itemCount: snapshot.data.docs.length,
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return CommentsCard(
                                        photo: snapshot.data.docs[index]
                                            ["photo"],
                                        name: snapshot.data.docs[index]["name"],
                                        comment: snapshot.data.docs[index]
                                            ["comment"],
                                        timestamp: snapshot.data.docs[index]["timestamp"]
                                      );
                                    },
                                  );
                                }
                              }
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.insert_comment_outlined,
                        size: 25, color: Colors.black),
                    SizedBox(width: 15),
                    Text('Comments',
                        style: TextStyle(fontSize: 16, color: Colors.black)),
                  ],
                ),
              ),
              complaint.status == "In Progress" || complaint.status == "Pending"
              ?
              IconButton(
                splashColor: Colors.transparent,
                icon: Icon(Icons.bookmark_border_rounded,
                    size: 25, color: Colors.black),
                onPressed: () => print("Bookmark"),
              )
              :
              SizedBox(height:45)
              ,
            ],
          ),
          if(complaint.status == "In Progress" || complaint.status == "Pending")
          Form(
            key: _formKey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: size.width * 0.625,
                  height: size.height * 0.05,
                  child: TextFormField(
                    controller: _commentController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter some value";
                      } else {
                        if (value.length < 3) {
                          return "Minimum length must be 3";
                        }
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelStyle:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                      labelText: "Type your Comment here",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(color: Colors.black)),
                    ),
                  ),
                ),
                FlatButton(
                  
                  onPressed: () async {
                    if (validateAndSave(_formKey)) {
                      String result = await uploadcomments();
                      if (result == 'Success') {
                        const snackBar = SnackBar(
                          content: Text('Comment Posted!'),
                          duration: Duration(seconds: 2),
                        );
                        FocusScope.of(context).unfocus();
                        _scaffoldKey.currentState.showSnackBar(snackBar);
                        _commentController.clear();
                      } else {
                        const snackBar = SnackBar(
                          content: Text('Error in Posting Comment!'),
                        );

                        _scaffoldKey.currentState.showSnackBar(snackBar);
                      }
                    }
                  },
                  child: Text('Post',
                      style: TextStyle(color: DARK_BLUE, fontSize: 15)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool validateAndSave(formKey) {
    final isValid = formKey.currentState.validate();
    if (isValid) {
      formKey.currentState.save();
      return true;
    } else {
      return false;
    }
  }

  Future<String> uploadcomments() async {
    try {
      final emailid = widget.auth.currentUserEmail();
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(emailid)
          .get();
      _name = doc.data()['name'];
      _photo = doc.data()['photo'];
      print("Photo: " + _photo.toString());
      await FirebaseFirestore.instance
          .collection('complaints')
          .doc(widget.docId)
          .collection('comments')
          .doc()
          .set({
        'name': _name,
        'comment': _commentController.text.toString(),
        'photo': _photo,
        'timestamp': DateTime.now().toString(),
      });
      print("Dusra Photo: " + _photo.toString());
      return "Success";
    } catch (e) {
      print("Error: " + e.toString());
      return "Error";
    }
  }

  Container complaintDetails(Size screenSize) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: DARK_PURPLE)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: screenSize.width * 0.8,
            child: Text(
              complaint.complaint ?? "Complaint Title",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.004),
            child: Divider(thickness: 1.5),
          ),
          Row(
            children: [
              Container(
                width: screenSize.width * 0.25,
                child: Text(
                  'Location: ',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                complaint.location ?? "Complaint Location",
                style: TextStyle(fontSize: 15, color: Colors.grey[800]),
              ),
            ],
          ),
          SizedBox(height: screenSize.height * 0.008),
          Row(
            children: [
              Container(
                width: screenSize.width * 0.25,
                child: Text(
                  'Ward: ',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                complaint.ward ?? "Complaint Ward",
                style: TextStyle(fontSize: 15, color: Colors.grey[800]),
              ),
            ],
          ),
          SizedBox(height: screenSize.height * 0.008),
          Row(
            children: [
              Container(
                width: screenSize.width * 0.25,
                child: Text(
                  'Description: ',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  complaint.description ?? "Complaint Description",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: screenSize.height * 0.008),
          Row(
            children: [
              Container(
                width: screenSize.width * 0.25,
                child: Text(
                  'Status: ',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                complaint.status,
                style: TextStyle(
                  fontSize: 15,
                  color: COMPLAINT_STATUS_COLOR_MAP[complaint.status] != null
                      ? COMPLAINT_STATUS_COLOR_MAP[complaint.status]
                      : Colors.deepOrange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: screenSize.height * 0.008),
          Row(
            children: [
              Container(
                width: screenSize.width * 0.25,
                child: Text(
                  'Supervisor: ',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Flexible(child:InkWell(
                onTap: () => complaint.supervisorName != null ? showScorecard() : {},
                child: Container(
                  padding: EdgeInsets.only(
                      bottom: 1), //Space between text and underline
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: DARK_PURPLE,
                        width: 0.8,
                      ),
                    ),
                  ), //width of the underline
                  child:
                      Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                       Flexible(child:Text(complaint.supervisorName ?? "Supervisor Name",
                            style:
                                TextStyle(fontSize: 15, color: Colors.black87)),),
                    
                      SizedBox(width: 3),
                      Icon(
                        Icons.open_in_new,
                        size: 16,
                        color: Colors.black87,
                      )
                    ],
                  ),
                ),
              ),
              ),
            ],
          ),
          SizedBox(height: screenSize.height * 0.008),
          Row(
            children: [
              Container(
                width: screenSize.width * 0.25,
                child: Text(
                  'Date: ',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                DateFormat.yMMMMd().format(DateTime.parse(complaint.dateTime)),
                style: TextStyle(fontSize: 15, color: Colors.grey[800]),
              ),
            ],
          ),
          SizedBox(height: screenSize.height * 0.008),
          Row(
            children: [
              Container(
                width: screenSize.width * 0.25,
                child: Text(
                  'Time: ',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                DateFormat.jms().format(DateTime.parse(complaint.dateTime)),
                style: TextStyle(fontSize: 15, color: Colors.grey[800]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Row trackComplaintButton(BuildContext context, Size screenSize) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: FlatButton(
              onPressed: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TrackComplaints(
                              auth: widget.auth,
                              complaint: complaint,
                              supervisorImageUrl: widget.supervisorImageUrl,
                            )))
              },
              color: DARK_BLUE,
              textColor: Colors.white,
              padding: EdgeInsets.symmetric(
                  vertical: screenSize.height * 0.012,
                  horizontal: screenSize.width * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.track_changes_rounded,
                    size: 20,
                  ),
                  SizedBox(width: screenSize.width * 0.01),
                  Text("Track Complaint")
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row raiseIssueButton(BuildContext context, Size screenSize) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.03,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: FlatButton(
              onPressed: () => showIssueForm(screenSize),
              color: Colors.orange,
              textColor: Colors.white,
              padding: EdgeInsets.symmetric(
                  vertical: screenSize.height * 0.012,
                  horizontal: screenSize.width * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.report_gmailerrorred_outlined,
                    size: 20,
                  ),
                  SizedBox(width: screenSize.width * 0.01),
                  Text("Report Issue")
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  showScorecard() async {
    Dialog scorecard = Dialog(
        child: SupervisorScorecard(supervisorDocRef: complaint.supervisorDocRef));
    await showDialog(context: context, builder: (_) => scorecard);
  }

  Container getIssueForm(Size size) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.03, vertical: size.height * 0.03),
      child: Form(
        key: _issueFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Report issue about the work done",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            TextFormField(
              controller: _issueController,
              validator: (value) {
                if (value.isEmpty) {
                  return "Please enter some value";
                } else {
                  if (value.length < 3) {
                    return "Minimum length must be 3";
                  }
                }
                return null;
              },
              decoration: InputDecoration(
                labelStyle:
                    TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                labelText: "Type your issue here",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: Colors.black)),
              ),
            ),
            SizedBox(height: size.height * 0.04),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: FlatButton(
                    onPressed: () async{
                      if (validateAndSave(_issueFormKey)) {
                        var complaintDoc =
                          FirebaseFirestore.instance.collection("complaints").doc(widget.docId);
                        print("complaintDoc.path");
                        print(complaintDoc.path);
                        String issue = _issueController.text.toString();
                        await complaintDoc.set({"feedback":issue, "status":"Issue Reported", "issueReportedDateTime": DateTime.now().toString()}, SetOptions(merge : true));
                        _issueController.clear();
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }
                    },
                    color: Colors.orange,
                    textColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.012,
                        horizontal: size.width * 0.03),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.report_gmailerrorred_outlined,
                          size: 20,
                        ),
                        SizedBox(width: size.width * 0.01),
                        Text("Raise issue")
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  showIssueForm(size) async {
    Dialog issueForm = Dialog(
      child: getIssueForm(size),
    );
    await showDialog(context: context, builder: (_) => issueForm);
  }
  // Row sendNotifButton(BuildContext context, Size screenSize) {
  //   return Row(
  //     mainAxisSize: MainAxisSize.min,
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Container(
  //         child: ClipRRect(
  //           borderRadius: BorderRadius.circular(30),
  //           child: FlatButton(
  //             onPressed: () async {
  //               // change status to resolve
  //               await FirebaseFirestore.instance
  //                   .collection('complaints')
  //                   .doc(widget.id)
  //                   .update({
  //                 'status': 'Resolved',
  //               });

  //               // set complaint in notif collection of user
  //               await FirebaseFirestore.instance
  //                   .collection('users')
  //                   .doc(widget.citizenEmail)
  //                   .collection('notifications')
  //                   .doc(widget.id)
  //                   .set({
  //                 'id': widget.id,
  //                 'complaint': complaint.complaint,
  //                 'location': widget.location,
  //                 'latitude': widget.lat.toString(),
  //                 'longitude': widget.long.toString(),
  //                 'date': widget.date.toString(),
  //                 'status': 'Resolved',
  //               });
  //               print(
  //                   "Status changed to resolved and complaint added to notif collection!");
  //             },
  //             color: Colors.orange[900],
  //             textColor: Colors.white,
  //             padding: EdgeInsets.symmetric(
  //                 vertical: screenSize.height * 0.012,
  //                 horizontal: screenSize.width * 0.03),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: <Widget>[
  //                 Icon(Icons.notifications_active, size: 20),
  //                 SizedBox(width: screenSize.width * 0.01),
  //                 Text("Close Complaint")
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

}
