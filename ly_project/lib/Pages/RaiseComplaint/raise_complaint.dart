// import 'package:cached_network_image/cached_network_image.dart';
// import 'dart:html';

import 'dart:io';
import 'dart:async';
import "package:latlong/latlong.dart";
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
// import 'package:ly_project/utils/DashedRect.dart';
import 'package:file_picker/file_picker.dart';
import 'package:location/location.dart';
// import 'package:image_picker/image_picker.dart';
// import 'image_storer.dart';

class RaiseComplaint extends StatefulWidget {
  const RaiseComplaint({Key key}) : super(key: key);

  @override
  _RaiseComplaintState createState() => _RaiseComplaintState();
}

class _RaiseComplaintState extends State<RaiseComplaint> {

  double lat, long;
  bool gotLocation = false;
  // final object = ImageStorer();
  // // final picker = ImagePicker();
  File file;

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
    print("Apna Latitude: "+_locationData.latitude.toString());
    print("longitude: " + _locationData.longitude.toString());

    lat = _locationData.latitude;
    long = _locationData.longitude;
    return _locationData;
  }

  final _localityController = TextEditingController();
  final _grievanceController = TextEditingController();
  // final _nController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    // getLocation();
    super.initState();
  }

  //  Future getImage() async {
  //   // final pickedFile = await picker.getImage(source: ImageSource.camera);

  //   setState(() {
  //     // _image = File(pickedFile.path);
  //     // object.setImage(_image);
  //   });
  // }

   _upload() async{
      FilePickerResult result = await FilePicker.platform.pickFiles();
      setState(() {
        if(result != null) {
          file = File(result.files.single.path);
          print("File path from upload func: "+file.path);
          final snackBar = SnackBar(
            content: Text('File Uploaded!'),
            action: SnackBarAction(
              label: 'OK',
              onPressed: () {},
            ),
          );

          // Find the Scaffold in the widget tree and use
          // it to show a SnackBar.
         Scaffold.of(context).showSnackBar(snackBar);
          
        } else {
          // User canceled the picker
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Raise a Complaint"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          // padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  height: MediaQuery.of(context).size.height / 3,
                  child: FutureBuilder<LocationData>(
                      future: getLocation(),
                      builder: (context, snapshot) {
                        // snapshot.connectionState =
                        if (!snapshot.hasData) {
                          return Center(
                            child: Container(
                              height: screenSize.height * 0.04,
                              child: CircularProgressIndicator(),
                              ),
                            );
                              
                        } else if(!snapshot.hasError) {
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
                        return   Center(
                            child: Container(
                              height: screenSize.height * 0.02,
                              child:
                              CircularProgressIndicator(),),);
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
                  labelText: 'Grievance',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: Colors.black)),
                ),
              ),
              SizedBox(height: 20),
          
              MaterialButton(
                onPressed: (){
                  _upload();
                  },
                color: Colors.blue,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: Colors.white),
                      SizedBox(width: 10),
                      Text("Add Photo",
                          style: TextStyle(color: Colors.white))
                    ])),
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                    height: 250,
                    width: 250,
                    color: Colors.black12,
                    child: GestureDetector(
                      onTap: (){
                        _upload();
                        },
                    ),
                    
                    
              //       // DashedRect(
              //       //   color: Colors.red,
              //       //   strokeWidth: 2.0,
              //       //   gap: 3.0,
              //       // ),
              //       // child: IconButton(
              //       //     icon: Icon(Icons.image),
              //       //     onPressed: () => {print("Trying to upload the image...")})
              //     ),
              //     Column(
              //       children:[
              //         IconButton(
              //         icon: Icon(Icons.image),
              //         onPressed: () => {print("Trying to upload the image...")}),
              //         Text(
              //           "Add Photo",style: TextStyle(color: Colors.white)
              //         )
                    // ]
                  )
                  
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(35.0, 20.0, 35.0, 10.0),
                child: Material(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.0)),
                  elevation: 5.0,
                  color: Colors.blue,
                  clipBehavior: Clip.antiAlias,
                  child: MaterialButton(
                      onPressed: null,
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
    );
  }
}
