import 'package:cached_network_image/cached_network_image.dart';
import "package:latlong/latlong.dart";
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:ly_project/utils/DashedRect.dart';
import 'package:location/location.dart';

class RaiseComplaint extends StatefulWidget {
  const RaiseComplaint({Key key}) : super(key: key);

  @override
  _RaiseComplaintState createState() => _RaiseComplaintState();
}

class _RaiseComplaintState extends State<RaiseComplaint> {
  double lat, long;
  // bool gotLocation = false;
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
    // print(_locationData.latitude);
    // print(_locationData.longitude);
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

  @override
  Widget build(BuildContext context) {
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
                          return CircularProgressIndicator();
                        } else {
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
                          child: CircularProgressIndicator(),
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
                  labelText: 'Grievance',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: Colors.black)),
                ),
              ),
              SizedBox(height: 20),
              // TextFormField(
              //   // controller: _nameController,
              //   decoration: InputDecoration(
              //     labelStyle: TextStyle(
              //       color: Colors.black,
              //     ),
              //     labelText: 'Photo',
              //     border: OutlineInputBorder(
              //         borderRadius: BorderRadius.all(Radius.circular(20)),
              //         borderSide: BorderSide(color: Colors.black)),
              //   ),
              // ),
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                    height: 250,
                    width: 250,
                    color: Colors.black12,
                    child: DashedRect(
                      color: Colors.red,
                      strokeWidth: 2.0,
                      gap: 3.0,
                    ),
                    // child: IconButton(
                    //     icon: Icon(Icons.image),
                    //     onPressed: () => {print("Trying to upload the image...")})
                  ),
                  IconButton(
                      icon: Icon(Icons.image),
                      onPressed: () => {print("Trying to upload the image...")})
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
