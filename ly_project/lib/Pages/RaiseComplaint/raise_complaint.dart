import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ly_project/Widgets/Map.dart';
import 'package:ly_project/Services/PredictionServices.dart';
import 'package:ly_project/Utils/colors.dart';
import 'package:uuid/uuid.dart';
import 'package:ly_project/Services/auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class RaiseComplaint extends StatefulWidget {
  final BaseAuth auth;
  const RaiseComplaint({this.auth});

  @override
  _RaiseComplaintState createState() => _RaiseComplaintState();
}

class _RaiseComplaintState extends State<RaiseComplaint> {
  double lat, long;
  bool gotLocation = false;
  File file;
  final _formKey = GlobalKey<FormState>();
  var uuid = Uuid();
  String fileUrl;
  String imageUrl =
      "https://www.winhelponline.com/blog/wp-content/uploads/2017/12/user.png";
  String docname = "";

  Future<LocationData> getLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    _locationData = await location.getLocation();
    print("Apna Latitude: " + _locationData.latitude.toString());
    print("longitude: " + _locationData.longitude.toString());

    lat = _locationData.latitude;
    long = _locationData.longitude;
    return _locationData;
  }

  final _localityController = TextEditingController();
  final _grievanceController = TextEditingController();
  final _descriptionController = TextEditingController();
  String result = "";
  bool isModelLoaded = false;
  bool isProcessingImage = false;
  bool isSubmittingComplaint = false;

  @override
  void initState() {
    super.initState();
    //Load the prediction model
    PredictionServices.loadModel()
        .then((value) => setState(() => isModelLoaded = true));
  }

  @override
  void dispose() async {
    super.dispose();
    await PredictionServices.disposeModel();
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
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar:
          AppBar(title: Text("Raise a Complaint"), backgroundColor: DARK_BLUE),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  child: FutureBuilder<LocationData>(
                    future: getLocation(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: Container(
                            height: size.height * 0.04,
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else if (!snapshot.hasError) {
                        double longitude, latitude;
                        longitude = snapshot.data.longitude;
                        latitude = snapshot.data.latitude;
                        return ComplaintMap(
                            latitude: latitude, longitude: longitude);
                      }
                      return Center(
                        child: Container(
                          height: size.height * 0.02,
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 40),
                TextFormField(
                  controller: _localityController,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    labelText: 'Locality',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _grievanceController,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    labelText: 'Complaint',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    labelText: 'Description',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      80.0, size.height * 0.01, 70.0, size.height * 0.01),
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
                        Text("Add Photo", style: TextStyle(color: Colors.white))
                      ],
                    ),
                  ),
                ),
                file != null
                    ? Image.file(
                        File(file.path),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      )
                    : SizedBox(),
                Padding(
                  padding: EdgeInsets.fromLTRB(80.0, 20.0, 70.0, 10.0),
                  child: (!isProcessingImage && !isSubmittingComplaint)
                      ? Material(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22.0)),
                          elevation: 5.0,
                          color: DARK_BLUE,
                          clipBehavior: Clip.antiAlias,
                          child: MaterialButton(
                            color: DARK_BLUE,
                            onPressed: () async {
                              if (validateAndSave(_formKey)) {
                                setState(() => isProcessingImage = true);
                                bool isPotholeDetected =
                                    await checkForPotholes();
                                setState(() => isProcessingImage = false);

                                if (!isPotholeDetected) {
                                  await _showErrorDialog(context, "Error",
                                      "Cannot register complaint since no pothole is detected in the image.");
                                  return;
                                }

                                _showDialog(context);

                                setState(() => isSubmittingComplaint = true);
                                String status = await mixtureofcalls(context);
                                setState(() => isSubmittingComplaint = true);

                                Navigator.pop(context);
                                if (status == 'Success') {
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.SUCCES,
                                    animType: AnimType.BOTTOMSLIDE,
                                    title: 'Success',
                                    desc:
                                        'The Complaint has been successfully registered..',
                                    btnCancelOnPress: () =>
                                        Navigator.pop(context),
                                    btnOkOnPress: () => Navigator.pop(context),
                                  )..show();
                                } else {
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.ERROR,
                                    animType: AnimType.BOTTOMSLIDE,
                                    title: 'Error',
                                    desc:
                                        'Error occured while registering complaint..',
                                    btnCancelOnPress: () =>
                                        Navigator.pop(context),
                                    btnOkOnPress: () => Navigator.pop(context),
                                  )..show();
                                }
                              } else {
                                print("Failure in saving the form");
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add, color: Colors.white),
                                SizedBox(width: 10),
                                Text("Add Complaint",
                                    style: TextStyle(color: Colors.white))
                              ],
                            ),
                          ),
                        )
                      : CircularProgressIndicator(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String> store(File _image) async {
    print("Inside store function");
    print("Upload docs wala user\n");
    final user = await widget.auth.currentUser();
    print(user);
    String imageRef = user + '/' + _image.path.split('/').last;
    print(imageRef);
    imageUrl =
        await (await FirebaseStorage.instance.ref(imageRef).putFile(_image))
            .ref
            .getDownloadURL();
    print(imageUrl);

    try {

      ///TODO: Get ward Name and Id
      String ward = "Ward A";
      String wardId = "WardA#50ad3f7a-dea5-49aa-b27c-59b72aa0b1c2";
      final emailid = widget.auth.currentUserEmail();
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("supervisors").where("ward", isEqualTo: "Ward A").get();
      QueryDocumentSnapshot supervisorDoc = snapshot.docs.first; 
      String supervisorName = supervisorDoc["name"];
      String supervisorEmail = supervisorDoc["email"];
      String supervisorId = supervisorDoc["id"];
      DocumentReference supervisorDocRef = FirebaseFirestore.instance.collection("supervisors").doc(supervisorDoc.id);

      docname = uuid.v4();
      await FirebaseFirestore.instance
          .collection('complaints')
          .doc(docname)
          .set({
        'citizenEmail': emailid,
        'complaint': _grievanceController.text.toString(),
        'description': _descriptionController.text.toString(),
        'dateTime': DateTime.now().toString(),
        'id': docname,
        'imageData': {
          'dateTime': DateTime.now().toString(),
          'location': _localityController.text.toString(),
          'submittedBy': emailid,
          'userType': 'citizen',
          'url': imageUrl,
        },
        'latitude': lat.toString(),
        'longitude': long.toString(),
        'location': _localityController.text.toString(),
        'resolutionDateTime': null,
        'status': 'Pending',
        'supervisorId': supervisorId,
        'supervisorEmail': supervisorEmail,
        'supervisorName': supervisorName,
        'supervisorDocRef': supervisorDocRef,
        'upvoteCount': 0,
        "ward":ward,
        "wardId":wardId,
      });
      return "Success";
    } catch (e) {
      print("Error: " + e.toString());
      return "Error";
    }
  }

  Future<String> mixtureofcalls(BuildContext context) async {
    print("mixtureofcalls Function Call!!!!!!!!!!!!!!!!!");
    String status = await store(file);
    return status;
  }

  Future<bool> checkForPotholes() async {
    if (isModelLoaded && file != null) {
      final output = await PredictionServices.classifyImage(file);
      print(output.toString());
      return !output.isEmpty;
    }
    return false;
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
              child: Text("Registering Complaint...")),
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

bool validateAndSave(formKey) {
  final isValid = formKey.currentState.validate();
  if (isValid) {
    formKey.currentState.save();
    return true;
  }
  return false;
}
