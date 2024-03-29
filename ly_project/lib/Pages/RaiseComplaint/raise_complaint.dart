import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:exif/exif.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ly_project/Services/ImageLocationServices.dart';
import 'package:ly_project/Services/StorageServices.dart';
import 'package:ly_project/Utils/constants.dart';
import 'package:ly_project/Widgets/Map.dart';
import 'package:ly_project/Services/PredictionServices.dart';
import 'package:ly_project/Utils/colors.dart';
import 'package:uuid/uuid.dart';
import 'package:ly_project/Services/auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as Im;
import 'package:path_provider/path_provider.dart';
import 'dart:math' as Math;

class RaiseComplaint extends StatefulWidget {
  final BaseAuth auth;
  const RaiseComplaint({this.auth});

  @override
  _RaiseComplaintState createState() => _RaiseComplaintState();
}

class _RaiseComplaintState extends State<RaiseComplaint> {
  var uuid = Uuid();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();

  final _localityController = TextEditingController();
  final _grievanceController = TextEditingController();
  final _descriptionController = TextEditingController();

  String fileUrl,
      imageUrl =
          "https://www.winhelponline.com/blog/wp-content/uploads/2017/12/user.png",
      docname = "",
      result = "";

  bool isModelLoaded = false,
      isProcessingImage = false,
      isSubmittingComplaint = false,
      _serviceEnabled;

  PermissionStatus _permissionStatus;
  double lat, long;
  File file;
  Map<String, IfdTag> imgTags = {};

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

  Future<LocationData> getLocation() async {
    Location location = new Location();
    LocationData _locationData;

    _permissionStatus = await location.hasPermission();
    print(_permissionStatus.toString());
    if (_permissionStatus == PermissionStatus.deniedForever) {
      showSnackbar("Please grant location permission from app setting", 3);
      return null;
    }
    if (_permissionStatus == PermissionStatus.denied) {
      showSnackbar(
          "Please grant location permission to register the complaint", 3);
      _permissionStatus = await location.requestPermission();
      return null;
    }
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
    }
    _locationData = await location.getLocation();

    lat = _locationData.latitude;
    long = _locationData.longitude;
    print("Device Location:\nlat: $lat, long:$long");

    return _locationData;
  }

  void showSnackbar(String message, [int duration = 3]) {
    final snackBar =
        SnackBar(content: Text(message), duration: Duration(seconds: duration));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  Future<void> pickFile() async {
    try {
      FilePickerResult result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ["jpg", "jpeg", "png", "heif", "bmp"]);

      if (result != null) {
        setState(() {
          file = File(result.files.single.path);
          print("File path from upload func: " + file.path);
        });
      } else {
        showSnackbar("Please select an image"); // User canceled the picker
      }
    } catch (e) {
      if (e is PlatformException) {
        if (e.code == "read_external_storage_denied")
          showSnackbar("Please allow the app to acceess images on your device");
      }
      showSnackbar("Something went wrong while selecting the image");
    }
  }

  Future<File> testCompressAndGetFile(File file) async {
    var target = "C:/Projects/PGMS/PGMS-App/ly_project/assets/citizenComplaint.jpeg";
    print("file abolute path: " + file.absolute.path.toString());
    var result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        target,
        quality: 90,
      );

    print("IMAGE COMPRESSED");
    print(file.lengthSync());
    print(result.lengthSync());

    return result;
  }

  Future<File> compressImage() async {
  // File imageFile = await ImagePicker.pickImage();
  final tempDir = await getTemporaryDirectory();
  final path = tempDir.path;
  int rand = new Math.Random().nextInt(10000);

  Im.Image image = Im.decodeImage(file.readAsBytesSync());
  // Im.Image smallerImage = Im.copyResize(image, 500); // choose the size here, it will maintain aspect ratio
  
  var compressedImage = new File('$path/img_$rand.jpg')..writeAsBytesSync(Im.encodeJpg(image, quality: 80));
  print("IMAGE COMPRESSED");
  print(compressedImage.lengthSync());
  return compressedImage;
}

  void _scrollToTop() {
    _scrollController.animateTo(
      _scrollController.position.minScrollExtent,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      appBar:
          AppBar(title: Text("Raise a Complaint"), backgroundColor: DARK_BLUE),
      body: SingleChildScrollView(
        controller: _scrollController,
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
                        return Container(
                          height: size.height * 0.02,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.grey[100],
                                  Colors.grey[350],
                                  Colors.grey[100]
                                ]),
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.red),
                                  borderRadius: BorderRadius.circular(30)),
                              child: IconButton(
                                  icon: Icon(Icons.error),
                                  onPressed: () async => await getLocation()),
                            ),
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
                            width: size.height * 0.02,
                            child: CircularProgressIndicator()),
                      );
                    },
                  ),
                ),
                SizedBox(height: 40),
                TextFormField(
                  controller: _localityController,
                  validator: (value) {
                    if (value.isEmpty || value.trim().isEmpty) {
                      return "Please enter location";
                    }
                    if (value.length < 3) {
                      return "Please enter valid location";
                    }
                    return null;
                  },
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
                  validator: (value) {
                    if (value.isEmpty || value.trim().isEmpty) {
                      return "Please enter complaint";
                    }
                    if (value.length < 5) {
                      return "Please enter valid complaint title";
                    }
                    if (value.trim().length > 100) {
                      return "Complaint title must contain less than 100 characters";
                    }
                    return null;
                  },
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
                  validator: (value) {
                    if (value.isEmpty || value.trim().isEmpty) {
                      return "Please enter complaint description";
                    }
                    if (value.length < 5) {
                      return "Please enter valid complaint description";
                    }
                    if (value.trim().length > 1000) {
                      return "Complaint title must contain less than 1000 characters";
                    }
                    return null;
                  },
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
                  child: file == null
                      ? MaterialButton(
                          onPressed: () async => await pickFile(),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22.0),
                          ),
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
                        )
                      : SizedBox(),
                ),
                file != null
                    ? Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 6),
                            child: Image.file(File(file.path),
                                fit: BoxFit.cover, width: double.infinity),
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
                                icon: Icon(Icons.close,
                                    semanticLabel: "Clear selected image",
                                    size: 16),
                                focusColor: Colors.white,
                                onPressed: () => setState(() => file = null),
                              ),
                            ),
                          ),
                        ],
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
                                // setState(() => isSubmittingComplaint = true);
                                // return;
                                
                                FocusScope.of(context).unfocus();

                                if (lat == null && long == null) {
                                  showSnackbar(
                                      "Please grant location permission to register the complaint",
                                      5);
                                  return;
                                }
                                if (file == null) {
                                  showSnackbar(
                                      "Please add image of pothole to register the complaint",
                                      5);
                                  return;
                                }

                                GeoFirePoint imageLocation =
                                    await ImageLocationServices
                                        .getImageLocation(
                                  file: file,
                                  setImageMetadata: (tags) => imgTags = tags,
                                  errorCallback: (errorMessage) async {
                                    await _showErrorDialog(
                                        context, "Error", errorMessage);
                                    return;
                                  },
                                );
                                String ward = "Unassigned";
                                if (imageLocation == null) {
                                  await _showErrorDialog(context, "Error",
                                      "Unable to get image location. Please select an image containg location metadata.");
                                  return;
                                } else {
                                  print("image ka lat: " +
                                      imageLocation.latitude.toString());
                                  print("image ka long: " +
                                      imageLocation.longitude.toString());
                                  
                                  setState((){
                                    lat = imageLocation.latitude;
                                    long = imageLocation.longitude;
                                  });

                                  setState(() => isProcessingImage = true);

                                  ward =  await getWard(imageLocation.latitude.toString(), imageLocation.longitude.toString());
                                  print("Locality mila: " + ward??"Empty response");
                                  

                                  if(ward=='null'){
                                    Navigator.pop(context);
                                
                                    await _showErrorDialog(context, "Error",
                                      'Please upload an image of a pothole in the Mumbai Region.');
                                    return;
                                  }
                                  
                                  // if(ward.isEmpty || ward == "" || ward == "Mumbai Suburban district" || !ward.contains("Ward")){
                                  //   ward = "Unassigned";
                                  // }
                                  
                                  else{
                                    // ward = ward.trim();
                                    // ward = ward.replaceAll("Ward", "");
                                    // ward = ward.trim();

                                    if(ward.contains("/")){
                                      var split = ward.split("/");
                                      String wardName = split[0];
                                      String position = split[1];
                                      switch(position){
                                        case "E":
                                        ward = "$wardName East";
                                          break;
                                        case "W":
                                          ward ="$wardName West";
                                          break;
                                        case "N":
                                          ward ="$wardName North";
                                          break;
                                        case "S":
                                          ward ="$wardName South";
                                          break;
                                        case "C":
                                          ward ="$wardName Central";
                                          break;
                                      }
                                    }
                                    ward = "Ward " + ward;
                                  }
                                  print("Formatted Ward: $ward");
                                }

                                
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

                                String status = await mixtureofcalls(context, imageLocation, ward);
                                setState(() => isSubmittingComplaint = false);

                                Navigator.pop(context);
                                if (status == 'Success') {
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.SUCCES,
                                    animType: AnimType.BOTTOMSLIDE,
                                    title: 'Success',
                                    desc:
                                        'The Complaint has been successfully registered..',
                                    btnOkOnPress: () {
                                      Navigator.pop(context);
                                    },
                                  )..show();
                                } else {
                                  await _showErrorDialog(context, "Error",
                                      'Error occured while registering complaint..');
                                }
                              } else {
                                _scrollToTop();
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

  Future<String> getWard(String lat, String long) async{
    print("GET WARD");
    print("Latitude" + lat);
    print("Longitude" + long);
    
    try{
    String url =
          // "https://api.bigdatacloud.net/data/reverse-geocode-client?latitude=" +
          "https://pgms-admin.herokuapp.com/getWard?lat=" +
              lat.toString() +
              // "&longitude=" +
              "&long=" +
              long.toString();
              // "&localityLanguage=en";
      final response = await http.get(url);
      var responseData = json.decode(response.body);
      print("Response Data: ");
      print(responseData);
      // String ward =  responseData['locality'].toString();
      String ward =  responseData['ward'].toString();
      print("Ward mila: " + ward??"Empty response");
      return ward;
    }catch(e){
      print("Error: " + e.toString());
      print("ImageData:");
      print("Lat: ${lat.toString()}, Long: ${long.toString()}");
      return "";
  }  
}

  Future<String> store(File _image, GeoFirePoint imageLocation, String ward) async {
    // print("Inside store function");
    // print("Upload docs wala user\n");
    // print(user);
    // String imageRef = user + '/' + _image.path.split('/').last;
    // print(imageRef);
    // imageUrl =
    //     await (await FirebaseStorage.instance.ref(imageRef).putFile(_image))
    //         .ref
    //         .getDownloadURL();
    // print(imageUrl);

    String userId = await widget.auth.currentUser();

    //image Compression
    // File result = await testCompressAndGetFile(file);
    File result = await compressImage();

    imageUrl = await StorageServices.uploadImage(userId, result);
    double imageLat = imageLocation.latitude;
    double imageLong = imageLocation.longitude;
    try {
      String wardId = wardIdMap[ward];
      final emailid = widget.auth.currentUserEmail();
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection("supervisors")
          .where("ward", isEqualTo: ward)
          .get();

      QueryDocumentSnapshot supervisorDoc = snapshot.docs.first;
      String supervisorName = supervisorDoc["name"];
      String supervisorEmail = supervisorDoc["email"];
      String supervisorId = supervisorDoc["id"];
      DocumentReference supervisorDocRef = FirebaseFirestore.instance
          .collection("supervisors")
          .doc(supervisorDoc.id);
      String dateTime = DateTime.now().toString();
      String location = _localityController.text.toString();
      String description = _descriptionController.text.toString().trim();

      docname = uuid.v4();
      await FirebaseFirestore.instance
          .collection('complaints')
          .doc(docname)
          .set({
        'citizenEmail': emailid,
        'complaint': _grievanceController.text.toString().trim(),
        'description': description,
        'dateTime': dateTime,
        "feedback":null,
        'id': docname,
        'imageData': {
          'dateTime': dateTime,
        'location': location.trim(),
          'submittedBy': emailid,
          'lat': imageLat,
          'long': imageLong,
          'userType': 'citizen',
          'url': imageUrl,
        },
        'latitude': lat.toString(),
        'longitude': long.toString(),
        'location': location.trim(),
        'resolutionDateTime': null,
        'issueReportedDateTime':null,
        'closedDateTime':null,
        'issueReassignedDateTime':null,
        'overdue': false,
        'status': 'Pending',
        'supervisorId': supervisorId,
        'supervisorEmail': supervisorEmail,
        'supervisorName': supervisorName,
        'supervisorDocRef': supervisorDocRef,
        "supervisorImageData": {
          'dateTime': null,
          'location': null,
          'submittedBy': null,
          'lat': null,
          'long': null,
          'userType': null,
          'url': null,
        },
        'upvoteCount': 0,
        "ward": ward,
        "wardId": wardId,
      });

      // set complaint in notif collection of supervisor
      await FirebaseFirestore.instance
          .collection('supervisors')
          .doc(supervisorEmail)
          .collection('notifications')
          .doc(docname)
          .set({
        'supervisorDocRef': supervisorDocRef,
        'docId': docname,
        'id': docname,
        'ward': ward,
        'complaint': _grievanceController.text.toString().trim(),
        'dateTime': dateTime,
        'status': 'Pending',
        'imageurl': imageUrl,
        'location': location.trim(),
        'supervisorName': supervisorName,
        'supervisorEmail': supervisorEmail,
        'latitude': lat,
        'longitude': long,
        'description': description,
        'citizenEmail': emailid,
        'supervisorImageUrl': null
      });
      return "Success";
    } catch (e) {
      print("Error: " + e.toString());
      return "Error";
    }
  }

  Future<String> mixtureofcalls(
    BuildContext context, GeoFirePoint imageLocation, String ward) async {
    print("mixtureofcalls Function Call!!!!!!!!!!!!!!!!!");
    String status = await store(file, imageLocation, ward);
    return status;
  }

  Future<bool> checkForPotholes() async {
    if (isModelLoaded && file != null) {
      final output = await PredictionServices.classifyImage(file);
      print(output.toString());
      //Output is empty when no pothole is detected
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
