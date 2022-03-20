import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ly_project/Widgets/Map.dart';
import 'package:ly_project/Pages/TrackComplaint/track_complaint.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ly_project/Pages/Comments/commentsCard.dart';
import 'package:ly_project/Services/auth.dart';
import 'package:ly_project/utils/colors.dart';

class DetailComplaint extends StatefulWidget {
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

  DetailComplaint(
      {this.id,
      this.auth,
      this.complaint,
      this.description,
      this.location,
      this.status,
      this.image,
      this.date,
      this.supervisor,
      this.lat,
      this.long,
      this.citizenEmail,
      this.docId});
  @override
  _DetailComplaintState createState() => _DetailComplaintState();
}

class _DetailComplaintState extends State<DetailComplaint> {
  String id;
  String status;
  String image;
  String date;
  String supervisor;
  String complaint;
  String location;
  double latitude;
  double longitude;
  String description;
  String _comment = "";
  String _name = "";
  String _photo = "";
  String appBarTitle = "";
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController _commentController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    latitude = double.parse(widget.lat);
    longitude = double.parse(widget.long);
    String complaint = widget.complaint.toString();
    appBarTitle =
        "${complaint.substring(0, complaint.length > 20 ? 20 : complaint.length)} ${complaint.length > 20 ? '...' : ''}";
    print("detail ka latitude - " + latitude.toString());
    print("detail ka longitude - " + longitude.toString());
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          appBarTitle ?? "Ye null hai 1",
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: DARK_BLUE,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: screenSize.height * 0.03),
              CarouselSlider(
                items: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: widget.image,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  ComplaintMap(latitude: latitude, longitude: longitude),
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
              SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: screenSize.width * 0.04),
                child: Row(
                  children: [
                    Text(
                      'Location: ',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Text(
                        widget.location ?? "Location null hai",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: screenSize.height * 0.012,
                ),
                child: Divider(
                  thickness: 1.5,
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.01,
              ),
              complaintDetails(screenSize),
              SizedBox(
                height: screenSize.height * 0.04,
              ),
              sendNotifButton(context, screenSize),
              SizedBox(
                height: screenSize.height * 0.02,
              ),
              trackComplaintButton(context, screenSize),
              SizedBox(
                height: screenSize.height * 0.04,
              ),
              commentBar(context, screenSize),
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
          borderRadius: BorderRadius.circular(5), color: Colors.grey[200]),
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
                    Text(
                      'Comments',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ],
                ),
              ),
              IconButton(
                splashColor: Colors.transparent,
                icon: Icon(
                  Icons.bookmark_border_rounded,
                  size: 25,
                  color: Colors.black,
                ),
                onPressed: () => print("Bookmark"),
              ),
            ],
          ),
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
                      style: TextStyle(color: Colors.blue, fontSize: 15)),
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
          .doc(widget.id)
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

  Column complaintDetails(Size screenSize) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                widget.complaint ?? "Complaint null hai",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: screenSize.height * 0.008,
        ),
        Row(
          children: [
            Text(
              'Description: ',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Flexible(
              child: Text(
                widget.description,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: screenSize.height * 0.005,
        ),
        Row(
          children: [
            Text(
              'Status: ',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.status,
              style: TextStyle(
                fontSize: 15,
                color: Colors.lightGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(
          height: screenSize.height * 0.005,
        ),
        Row(
          children: [
            Text(
              'Supervisor: ',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.supervisor ?? "Supervisor null hai 1",
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ],
        ),
        SizedBox(
          height: screenSize.height * 0.005,
        ),
        Row(
          children: [
            Text(
              'Date: ',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              DateFormat.yMMMMd().format(DateTime.parse(widget.date)),
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Row trackComplaintButton(BuildContext context, Size screenSize) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(29),
            child: FlatButton(
              onPressed: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TrackComplaints(
                            auth: widget.auth,
                            id: widget.id,
                            complaint: widget.complaint,
                            date: widget.date,
                            location: widget.location,
                            latitude: latitude,
                            longitude: longitude,
                            status: widget.status)))
              },
              color: DARK_BLUE,
              textColor: Colors.white,
              padding: EdgeInsets.symmetric(
                  vertical: screenSize.height * 0.014,
                  horizontal: screenSize.width * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.track_changes_rounded),
                  SizedBox(width: screenSize.width * 0.03),
                  Text("Track Complaint")
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row sendNotifButton(BuildContext context, Size screenSize) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(29),
            child: FlatButton(
              onPressed: () async {
                // change status to resolve
                await FirebaseFirestore.instance
                    .collection('complaints')
                    .doc(widget.id)
                    .update({
                  'status': 'Resolved',
                });

                // set complaint in notif collection of user
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(widget.citizenEmail)
                    .collection('notifications')
                    .doc(widget.id)
                    .set({
                  'id': widget.id,
                  'complaint': widget.complaint,
                  'location': widget.location,
                  'latitude': widget.lat.toString(),
                  'longitude': widget.long.toString(),
                  'date': widget.date.toString(),
                  'status': 'Resolved',
                });
                print(
                    "Status changed to resolved and complaint added to notif collection!");
              },
              color: GOLDEN_YELLOW,
              textColor: Colors.white,
              padding: EdgeInsets.symmetric(
                  vertical: screenSize.height * 0.014,
                  horizontal: screenSize.width * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.notifications_active),
                  SizedBox(width: screenSize.width * 0.03),
                  Text("Close Complaint")
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
