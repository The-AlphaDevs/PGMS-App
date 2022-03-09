import 'dart:io';
import 'dart:async';
import "package:latlong/latlong.dart";
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:file_picker/file_picker.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ly_project/Utils/colors.dart';
import 'package:uuid/uuid.dart';
import 'package:ly_project/Services/auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:awesome_dialog/awesome_dialog.dart';


//TODO: Upload image after users clicks add complaint button, 
//TODO: Navigate to feed page once data uploaded

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

  @override
  void initState() {
    // TODO: implement initState
    // getLocation();
    super.initState();
  }

  _upload() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(type: FileType.custom,allowedExtensions: ["jpg", "jpeg", "png", "heif", "bmp"]);
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
      appBar: AppBar(
        title: Text("Raise a Complaint"),
        backgroundColor: DARK_BLUE,
      ),
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
                            return FlutterMap(
                              options: MapOptions(
                                center: LatLng(snapshot.data.latitude,
                                    snapshot.data.longitude),
                                zoom: 13.0,
                              ),
                              layers: [
                                TileLayerOptions(
                                  urlTemplate:
                                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                  subdomains: ['a', 'b', 'c'],
                                  // attributionBuilder: (_) {
                                  //   return Text("© OpenStreetMap contributors");
                                  // },
                                ),
                                MarkerLayerOptions(
                                  markers: [
                                    Marker(
                                      width: 40.0,
                                      height: 40.0,
                                      point: LatLng(snapshot.data.latitude,
                                          snapshot.data.longitude),
                                      builder: (ctx) => Container(
                                        child: FlutterLogo(size: 0),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }
                          return Center(
                            child: Container(
                              height: size.height * 0.02,
                              child: CircularProgressIndicator(),
                            ),
                          );
                        })),
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
                  padding: EdgeInsets.fromLTRB(80.0, size.height*0.01, 70.0, size.height*0.01),
                  child: MaterialButton(
                      onPressed: () async{
                       await  _upload();
                      },
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
                          ])),
                ),        
                file != null?
                Image.file(
                  File(file.path),
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
                :
                SizedBox(),
                // Stack(
                //   alignment: AlignmentDirectional.center,
                //   children: [
                //     Container(
                //       height: 250,
                //       width: 250,
                //       color: Colors.black12,
                //       child: GestureDetector(
                //         onTap: () {
                //           _upload();
                //         },
                //       ),
                //     )
                //   ],
                // ),
                Padding(
                  padding: EdgeInsets.fromLTRB(80.0, 20.0, 70.0, 10.0),
                  child: Material(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22.0)),
                    elevation: 5.0,
                    color: DARK_BLUE,
                    clipBehavior: Clip.antiAlias,
                    child: MaterialButton(
                        color: DARK_BLUE,
                        onPressed: () async {
                          if (validateAndSave(_formKey)) {
                            // Scaffold.of(context).showSnackBar(SnackBar(
                            //     content: Text(
                            //         'Establishing Contact with the Server')));
                            _showDialog(context);
                            String status = await mixtureofcalls(context);
                            print("mixture of calls ho gaya");
                            Navigator.pop(context);
                            print("context pop hua");
                            if(status=='Success'){
                              print("success k andar aaya");
                                AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.SUCCES,
                                    animType: AnimType.BOTTOMSLIDE,
                                    title: 'Success',
                                    desc: 'The Complaint has been successfully registered..',
                                    btnCancelOnPress: () {
                                    Navigator.pop(context);
                                    },
                                    btnOkOnPress: () {
                                      Navigator.pop(context);},
                                    )..show();
                            }else{
                              print("else k andar aaya");
                              
                                AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.ERROR,
                                    animType: AnimType.BOTTOMSLIDE,
                                    title: 'Error',
                                    desc: 'Error occured while registering complaint..',
                                    btnCancelOnPress: () {
                                      Navigator.pop(context);},
                                    btnOkOnPress: () {
                                      Navigator.pop(context);
                                      },
                                    )..show();
                            }
                            // loadingScreen();
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
                          ])),
                  ),
                )
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
      final emailid = widget.auth.currentUserEmail();
      docname = uuid.v4();
      await FirebaseFirestore.instance.collection('complaints').doc(docname).set({
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
        'supervisorEmail': null,
        'supervisorId': null,
        'supervisorName': null,
        'upvoteCount':0
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
            child: Text("Registering Complaint...")),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      // Doesn't allow the dialog box to pop
      return WillPopScope(
          onWillPop: () {
            return;
          },
          child: alert);
    },
  );
}
