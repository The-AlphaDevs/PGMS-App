import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ly_project/Pages/DetailedComplaint/Scorecard.dart';
import 'package:ly_project/Pages/TrackComplaint/track_complaint.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ly_project/Services/PredictonServices.dart';
import 'package:ly_project/Services/StorageServices.dart';
import 'package:ly_project/Services/auth.dart';
import 'package:ly_project/Pages/DetailedComplaint/FullScreenImage.dart';
import 'package:ly_project/Widgets/Map.dart';
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
  final supervisorEmail;
  final docId;
  final supervisorDocRef;
  final supervisorImageUrl;

  DetailComplaint({
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
    @required this.supervisorImageUrl,
  });
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
  // String _comment = "";
  // String _name = "";
  // String _photo = "";
  String appBarTitle = "";
  // final _formKey = GlobalKey<FormState>();
  String fileUrl;

  File file;

  String imageUrl =
      "https://www.winhelponline.com/blog/wp-content/uploads/2017/12/user.png";

  bool isModelLoaded = false;
  bool isProcessingImage = false;
  bool isSubmittingComplaint = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // TextEditingController _commentController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    latitude = double.parse(widget.lat);
    longitude = double.parse(widget.long);
    String complaint = widget.complaint.toString();

    appBarTitle = complaint == null
        ? "Detailed Complaint"
        : "${complaint.substring(0, complaint.length > 25 ? 25 : complaint.length)} ${complaint.length > 25 ? '...' : ''}";

    //Load the prediction model
    PredictionServices.loadModel()
        .then((value) => setState(() => isModelLoaded = true));

    print("detail ka latitude - " + latitude.toString());
    print("detail ka longitude - " + longitude.toString());
  }

  void dispose() async {
    super.dispose();
    await PredictionServices.disposeModel();
  }

  void showSnackbar(String message, [int duration = 3]) {
    final snackBar =
        SnackBar(content: Text(message), duration: Duration(seconds: duration));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  AlertDialog approveComplaint(context) {
    Size screenSize = MediaQuery.of(context).size;
    Widget okButton = OutlinedButton(
      style: ButtonStyle(
        side: MaterialStateProperty.all(BorderSide(color: Colors.green)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        ),
      ),
      child: Text("Approve", style: TextStyle(color: Colors.green[900])),
      onPressed: () async {
        try {
          await changeStatus(true);
          Navigator.pop(context, null);
          Navigator.pop(context, null);
        } catch (e) {
          print("Error in approval!!");
          print(e);
        }
      },
    );
    Widget cancelButton = OutlinedButton(
        autofocus: true,
        style: ButtonStyle(
          side: MaterialStateProperty.all(BorderSide(color: Colors.red)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          ),
        ),
        child: Text("Reject", style: TextStyle(color: Colors.red[900])),
        onPressed: () async {
          try {
            await changeStatus(false);
            Navigator.pop(context, null);
            Navigator.pop(context, null);
          } catch (e) {
            print("Error in approval!!");
            print(e);
          }
        });

    AlertDialog alert = AlertDialog(
      title: Text("Approval"),
      content: Text("Do you want to approve this complaint?"),
      actions: [okButton, cancelButton],
      titlePadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 5.0),
      contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 8.0),
      actionsPadding: EdgeInsets.fromLTRB(
          screenSize.width * 0.05, 10.0, screenSize.width * 0.18, 5.0),
    );
    return alert;
  }

  _upload() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ["jpg", "jpeg", "png", "heif", "bmp"]);
    file = File(result.files.single.path);
    print("File path from upload func: " + file.path);
    // fileUrl = await uploadFiles(file);
    setState(() {
      if (result != null) {
      } else {
        // User canceled the picker
      }
    });
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
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
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
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(6.0)),
                    child: ImageFullScreenWrapperWidget(
                      child: CachedNetworkImage(
                        imageUrl: widget.image,
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
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: screenSize.height * 0.015),
                child: Divider(thickness: 1.5),
              ),
              complaintDetails(screenSize),
              SizedBox(height: screenSize.height * 0.025),
              widget.status == "Pending"
                  ? Padding(
                      padding: EdgeInsets.fromLTRB(
                          screenSize.width * 0.25,
                          screenSize.height * 0.005,
                          screenSize.width * 0.25,
                          screenSize.height * 0.005),
                      child: MaterialButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                approveComplaint(context),
                          );
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22.0)),
                        color: Colors.blue,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check_circle_outline_outlined,
                                color: Colors.white),
                            SizedBox(width: 10),
                            Text("Approve",
                                style: TextStyle(color: Colors.white))
                          ],
                        ),
                      ),
                    )
                  : widget.status == "In Progress"
                      ? file == null
                          ? Padding(
                              padding: EdgeInsets.fromLTRB(
                                  screenSize.width * 0.25,
                                  screenSize.height * 0.005,
                                  screenSize.width * 0.25,
                                  screenSize.height * 0.005),
                              child: MaterialButton(
                                onPressed: () async => await _upload(),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(22.0)),
                                color: Colors.blue,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.photo, color: Colors.white),
                                    SizedBox(width: 10),
                                    Text("Add Photo",
                                        style: TextStyle(color: Colors.white))
                                  ],
                                ),
                              ),
                            )
                          : Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 6),
                                  child: Image.file(File(file.path),
                                      fit: BoxFit.cover,
                                      width: double.infinity),
                                ),
                                //Unselected the image
                                Positioned(
                                  right: 2,
                                  top: 8,
                                  child: CircleAvatar(
                                    radius: 16,
                                    backgroundColor: Colors.grey[300],
                                    child: IconButton(
                                      color: Colors.red,
                                      icon: Icon(
                                        Icons.close,
                                        semanticLabel: "Clear selected image",
                                        size: 16,
                                      ),
                                      focusColor: Colors.white,
                                      onPressed: () =>
                                          setState(() => file = null),
                                    ),
                                  ),
                                ),
                              ],
                            )
                      : SizedBox(),

              widget.status == "In Progress" ? SizedBox(height: screenSize.height * 0.025) : SizedBox(height: screenSize.height * 0),

              widget.status == "In Progress"
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // sendNotifButton(context, screenSize),
                        resolveComplaintButton(context, screenSize),
                      ],
                    )
                  : SizedBox(),

              SizedBox(height: screenSize.height * 0.02),

              // trackComplaintButton(context, screenSize),
              // SizedBox(
              //   height: screenSize.height * 0.04,
              // ),
              // commentBar(context, screenSize),
            ],
          ),
        ),
      ),
    );
  }

  Widget resolveComplaintButton(BuildContext context, Size screenSize) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        (!isProcessingImage && !isSubmittingComplaint)
            ? Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: FlatButton(
                    color: DARK_BLUE,
                    onPressed: () async {
                      if (file == null) {
                        showSnackbar(
                            "Please add image of work done to resolve the complaint",
                            5);
                        return;
                      }
                      setState(() => isProcessingImage = true);
                      bool isPotholeDetected = await checkForPotholes();
                      setState(() => isProcessingImage = false);

                      if (isPotholeDetected) {
                        await _showErrorDialog(context, "Error",
                            "Cannot resolve this complaint since pothole is detected in the image.");
                        return;
                      }

                      _showDialog(context);

                      setState(() => isSubmittingComplaint = true);
                      String status = await mixtureofcalls(context);
                      setState(() => isSubmittingComplaint = true);

                      Navigator.pop(context);

                      if (status == 'Success') {
                        _showSuccessDialog(context, 'Success',
                            'The Complaint has been successfully resolved..');
                      } else {
                        _showErrorDialog(context, "Error", status);
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_box_outlined, color: Colors.white, size: 20),
                        SizedBox(width: screenSize.width * 0.01),
                        Text("Solve Complaint",
                            style: TextStyle(color: Colors.white))
                      ],
                    ),
                  ),
                ),
              )
            : Container(width: 20, child: CircularProgressIndicator()),
      ],
    );
  }

  showScorecard() async {
    Dialog scorecard = Dialog(
        child: SupervisorScorecard(supervisorDocRef: widget.supervisorDocRef));
    await showDialog(context: context, builder: (_) => scorecard);
  }

  Container complaintDetails(Size screenSize) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25, horizontal: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: DARK_PURPLE)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: screenSize.width * 0.8,
            child: Text(
              widget.complaint ?? "Complaint Title",
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
                widget.location ?? "Complaint Location",
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
                  widget.description ?? "Complaint Description",
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
                widget.status,
                style: TextStyle(
                  fontSize: 15,
                  color: COMPLAINT_STATUS_COLOR_MAP[widget.status] != null
                      ? COMPLAINT_STATUS_COLOR_MAP[widget.status]
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
              InkWell(
                onTap: () => widget.supervisor != null ? showScorecard() : {},
                child: Container(
                  //Space between text and underline
                  padding: EdgeInsets.only(bottom: 1),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: DARK_PURPLE, width: 0.8),
                    ),
                  ), //width of the underline
                  child: Row(
                    children: [
                      Text(widget.supervisor ?? "Supervisor Name",
                          style:
                              TextStyle(fontSize: 15, color: Colors.black87)),
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
                DateFormat.yMMMMd().format(DateTime.parse(widget.date)),
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
                DateFormat.jms().format(DateTime.parse(widget.date)),
                style: TextStyle(fontSize: 15, color: Colors.grey[800]),
              ),
            ],
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

  void _showDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF181D3D)),
          ),
          Container(
              margin: EdgeInsets.only(left: 7),
              child: Text("Resolving Complaint...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () {
            return;
          },
          child: alert,
        );
      },
    );
  }

  // Future<String> uploadcomments() async {
  //   try {
  //     final emailid = widget.auth.currentUserEmail();
  //     final doc = await FirebaseFirestore.instance.collection('users').doc(emailid).get();
  //     _name = doc.data()['name'];
  //     _photo = doc.data()['photo'];
  //     print("Photo: "+_photo.toString());
  //     await FirebaseFirestore.instance.collection('complaints').doc(widget.id).collection('comments').doc().set({
  //       'name': _name,
  //       'comment': _commentController.text.toString(),
  //       'photo': _photo,
  //       'timestamp':DateTime.now().toString(),
  //     });
  //     print("Dusra Photo: "+_photo.toString());
  //     return "Success";
  //   } catch (e) {
  //     print("Error: " + e.toString());
  //     return "Error";
  //   }
  // }

  Future<void> changeStatus(approve) async {
    if (approve) {
      try {
        await FirebaseFirestore.instance
            .collection('complaints')
            .doc(widget.id)
            .set({
          'status': 'In Progress',
          'dateTime': DateTime.now().toString(),
        }, SetOptions(merge: true));
      } catch (e) {
        print("Error: " + e.toString());
      }
    } else {
      try {
        await FirebaseFirestore.instance
            .collection('complaints')
            .doc(widget.id)
            .set({
          'status': 'Rejected',
          'dateTime': DateTime.now().toString(),
        }, SetOptions(merge: true));
      } catch (e) {
        print("Error: " + e.toString());
      }
    }
  }

  Future<String> store(File _image) async {
    String userId = await widget.auth.currentUser();
    imageUrl = await StorageServices.uploadImage(userId, _image);
    if (imageUrl == null)
      return "Something went wrong while uploading image. Please check your internet connection.";

    try {
      final emailid = widget.auth.currentUserEmail();
      await FirebaseFirestore.instance
          .collection('complaints')
          .doc(widget.id)
          .set({
        'supervisorImageData': {
          'dateTime': DateTime.now().toString(),
          'lat': 100,
          'long': 100,
          'submittedBy': emailid,
          'userType': 'supervisor',
          'url': imageUrl,
        },
        'resolutionDateTime': DateTime.now().toString(),
        'status': 'Resolved',
      }, SetOptions(merge: true));

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
        'supervisorImageUrl': imageUrl
      });

      return "Success";
    } catch (e) {
      print("Error: " + e.toString());
      return "Something went wrong! Check your internet connection!";
    }
  }

  Future<String> mixtureofcalls(BuildContext context) async {
    String status = await store(file);
    return status;
  }

  // Column complaintDetails(Size screenSize) {
  //   return Column(
  //     children: [
  //       Row(
  //         children: [
  //           Flexible(
  //             child: Text(
  //               widget.complaint ?? "Complaint null hai",
  //               style: TextStyle(
  //                 fontSize: 20,
  //                 color: Colors.black,
  //                 fontWeight: FontWeight.w600,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //       SizedBox(
  //         height: screenSize.height * 0.008,
  //       ),
  //       Row(
  //         children: [
  //           Text(
  //             'Description: ',
  //             style: TextStyle(
  //               fontSize: 15,
  //               color: Colors.black,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //           Flexible(
  //             child: Text(
  //               widget.description,
  //               style: TextStyle(
  //                 fontSize: 12,
  //                 color: Colors.black,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //       SizedBox(
  //         height: screenSize.height * 0.005,
  //       ),
  //       Row(
  //         children: [
  //           Text(
  //             'Status: ',
  //             style: TextStyle(
  //               fontSize: 15,
  //               color: Colors.black,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //           Text(
  //             widget.status,
  //             style: TextStyle(
  //               fontSize: 15,
  //               color: Colors.lightGreen,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //         ],
  //       ),
  //       SizedBox(
  //         height: screenSize.height * 0.005,
  //       ),
  //       Row(
  //         children: [
  //           Text(
  //             'Supervisor: ',
  //             style: TextStyle(
  //               fontSize: 15,
  //               color: Colors.black,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //           Text(
  //             widget.supervisor ?? "Supervisor null hai 1",
  //             style: TextStyle(
  //               fontSize: 15,
  //               color: Colors.black,
  //             ),
  //           ),
  //         ],
  //       ),
  //       SizedBox(
  //         height: screenSize.height * 0.005,
  //       ),
  //       Row(
  //         children: [
  //           Text(
  //             'Date: ',
  //             style: TextStyle(
  //               fontSize: 15,
  //               color: Colors.black,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //           Text(
  //             DateFormat.yMMMMd().format(DateTime.parse(widget.date)),
  //             style: TextStyle(
  //               fontSize: 15,
  //               color: Colors.grey[800],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }

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
            borderRadius: BorderRadius.circular(30),
            child: FlatButton(
              onPressed: () async {
                // change status to resolve
                await FirebaseFirestore.instance
                    .collection('complaints')
                    .doc(widget.id)
                    .update({'status': 'In Progress'});

                // set complaint in notif collection of user
                await FirebaseFirestore.instance
                    .collection('supervisors')
                    .doc(widget.supervisorEmail)
                    .collection('notifications')
                    .doc(widget.id)
                    .set({
                  'supervisorDocRef': widget.supervisorDocRef,
                  'docId': widget.docId,
                  'id': widget.id,
                  'complaint': widget.complaint,
                  'dateTime': widget.date,
                  'status': 'In Progress',
                  'imageurl': widget.image,
                  'location': widget.location,
                  'supervisorName': widget.supervisor,
                  'supervisorEmail': widget.supervisorEmail,
                  'latitude': widget.lat.toString(),
                  'longitude': widget.long.toString(),
                  'description': widget.description,
                  'citizenEmail': widget.citizenEmail,
                  'supervisorImageUrl': widget.supervisorImageUrl
                });
                print(
                    "Status changed to In Progress and complaint added to notif collection of supervisor!");
              },
              color: Colors.orange[900],
              textColor: Colors.white,
              padding: EdgeInsets.symmetric(
                  vertical: screenSize.height * 0.012,
                  horizontal: screenSize.width * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.notifications_active, size: 20),
                  SizedBox(width: screenSize.width * 0.01),
                  Text("Assign Supervisor")
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _showSuccessDialog(
      BuildContext context, String title, String message) async {
    AwesomeDialog alert = AwesomeDialog(
      btnOkOnPress: () {
        Navigator.pop(context);
      },
      desc: message,
      dialogType: DialogType.SUCCES,
      title: title,
      context: context,
    );
    await alert.show();
  }

  Future<void> _showErrorDialog(
      BuildContext context, String title, String message) async {
    AwesomeDialog alert = AwesomeDialog(
      btnOkOnPress: () {},
      desc: message,
      dialogType: DialogType.ERROR,
      title: title,
      context: context,
    );
    await alert.show();
  }

  Future<bool> checkForPotholes() async {
    if (isModelLoaded && file != null) {
      final output = await PredictionServices.classifyImage(file);
      print(output.toString());
      return output.isNotEmpty;
    }
    return false;
  }
}

// Container commentBar(BuildContext context, Size screenSize) {
//   Size size = MediaQuery.of(context).size;
//   return Container(
//     padding: EdgeInsets.symmetric(
//         vertical: screenSize.height * 0.003,
//         horizontal: screenSize.width * 0.02),
//     decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(5), color: Colors.grey[200]),
//     child: Column(
//       children:[
//         Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         InkWell(
//           onTap: () {
//             // Navigator.push(
//             //     context,
//             //     MaterialPageRoute(
//             //         builder: (context) => Comments(
//             //               id: widget.id,
//             //             )));
//             showModalBottomSheet(
//               context: context,
//               backgroundColor: Colors.white,
//               //elevates modal bottom screen
//               elevation: 100,
//               // gives rounded corner to modal bottom screen
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               builder: (BuildContext context) {
//                 return Container(
//                   height: size.height*0.75,
//                   child: Padding(
//                     padding: EdgeInsets.only(right: size.width*0.005, left: size.width*0.005, top: size.height*0.01, bottom: size.height*0.01),
//                     child: StreamBuilder(
//                         stream: FirebaseFirestore.instance
//                                 .collection("complaints")
//                                 .doc(widget.docId)
//                                 .collection("comments")
//                                 .snapshots()
//                                 ,
//                         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
//                           if(!snapshot.hasData){
//                             print("Connection state: has no data");
//                             return Column(children: [
//                                 SizedBox(
//                                   height:size.height*0.2,
//                                 ),
//                                 CircularProgressIndicator(),
//                               ],
//                             );

//                           }
//                           else if(snapshot.connectionState == ConnectionState.waiting){
//                             print("Connection state: waiting");
//                             return Column(children: [
//                                   SizedBox(
//                                     height:size.height*0.2,
//                                   ),
//                                   CircularProgressIndicator(),
//                               ],
//                             );
//                           }

//                           else{
//                             // return ListView(
//                               // children: snapshot.data.docs.map((document) {
//                               print("Connection state: hasdata");
//                                 if(snapshot.data.docs.length == 0){
//                                   return Center(
//                                     child: Text("No Comments"),
//                                   );
//                                 }
//                                 else{
//                                   return

//                                       ListView.builder(
//                                       // scrollDirection: Axis.vertical,
//                                       itemCount: snapshot.data.docs.length,
//                                       padding: EdgeInsets.only(
//                                           left: 10, right: 10),
//                                       shrinkWrap: true,
//                                       itemBuilder: (context, index) {

//                                         return CommentsCard
//                                         (
//                                           photo: snapshot.data.docs[index]["photo"],
//                                           name: snapshot.data.docs[index]["name"],
//                                           comment: snapshot.data.docs[index]["comment"],
//                                         );
//                                       },
//                                 );
//                               }
//                             }
//                           }
//                         ),
//                   ),
//                 );
//               },
//             );
//           },
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Icon(
//                 Icons.insert_comment_outlined,
//                 size: 25,
//                 color: Colors.black,
//               ),
//               SizedBox(
//                 width: 15,
//               ),
//               Text(
//                 'Comments',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.black,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         IconButton(
//           splashColor: Colors.transparent,
//           icon: Icon(
//             Icons.bookmark_border_rounded,
//             size: 25,
//             color: Colors.black,
//           ),
//           onPressed: () {
//             print("Bookmark");
//           },
//         ),
//       ],
//     ),
//     Form(
//       key: _formKey,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children:[
//         Container(
//           width: size.width*0.625,
//           height: size.height*0.05,
//           child: TextFormField(
//             controller: _commentController,
//             validator: (value) {
//               if (value.isEmpty) {
//                 return "Please enter some value";
//               } else {
//                 if (value.length < 3) {
//                   return "Minimum length must be 3";
//                 }
//               }
//               return null;
//             },
//             decoration: InputDecoration(
//               labelStyle: TextStyle(
//                   fontSize: 13,
//                   fontWeight: FontWeight.bold),
//               labelText: "Type your Comment here",
//               border: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(
//                       Radius.circular(12)),
//                   borderSide: BorderSide(
//                       color: Colors.black)),
//             ),
//           ),
//         ),
//         // SizedBox(
//         //   width: size.width*0.0,
//         // ),
//         FlatButton(
//           onPressed: ()async {
//             if (validateAndSave(_formKey)) {
//               String result = await uploadcomments();
//               if(result=='Success'){
//                 const snackBar = SnackBar(
//                   content: Text('Comment Posted!'),
//                   duration: Duration(seconds: 2),
//                 );
//                 FocusScope.of(context).unfocus();
//                 _scaffoldKey.currentState.showSnackBar(snackBar);
//                 _commentController.clear();

//               }else{
//                 const snackBar = SnackBar(
//                   content: Text('Error in Posting Comment!'),
//                 );

//                 _scaffoldKey.currentState.showSnackBar(snackBar);
//               }
//             }
//            },
//           child: Text('Post',style:TextStyle(color: Colors.blue, fontSize: 15)),
//         )
//       ]
//     )
//     )
//       ]),
//   );
// }
