import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ly_project/Pages/TrackComplaint/track_complaint.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:location/location.dart';
import "package:latlong/latlong.dart";

class DetailComplaint extends StatefulWidget {
  final id;
  final status;
  final image;
  final date;
  final supervisor;
  final lat;
  final long;
  final complaint;
  final location;

  DetailComplaint({this.id, this.complaint, this.location, this.status,this.image, this.date, this.supervisor, this.lat, this.long});
  @override
  _DetailComplaintState createState() => _DetailComplaintState();
}

class _DetailComplaintState extends State<DetailComplaint> {
  String id;
  String status;
  String image;
  String date;
  String supervisor;
  double lat;
  double long;
  String complaint;
  String location;
  double latitude;
  double longitude;


  @override
  void initState(){
  super.initState();
  latitude = double.parse(widget.lat);
  longitude = double.parse(widget.long);
  print("detail ka latitude - " + latitude.toString());
  print("detail ka longitude - " + longitude.toString());
  }
  
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.id??"Ye null hai 1",
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
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
                      image: DecorationImage(
                        image: NetworkImage(widget.image),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  Container(
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(6.0),
                    //   image: DecorationImage(
                    //     image: AssetImage('assets/loc.jpg'),
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                    child: FlutterMap(
                      options: MapOptions(
                        center: LatLng(latitude,
                            longitude),
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
                              point: LatLng(latitude,
                                  longitude),
                              builder: (ctx) => Container(
                                child: FlutterLogo(size: 0),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
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
                        widget.location??"Location null hai 1",
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
                height: screenSize.height * 0.02,
              ),
              trackComplaintButton(context, screenSize),
              SizedBox(
                height: screenSize.height * 0.06,
              ),
              commentBar(screenSize),
            ],
          ),
        ),
      ),
    );
  }

  Container commentBar(Size screenSize) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: screenSize.height * 0.003,
          horizontal: screenSize.width * 0.02),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.grey[200]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.insert_comment_outlined,
                size: 25,
                color: Colors.black,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                '50 Comments',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          IconButton(
            splashColor: Colors.transparent,
            icon: Icon(
              Icons.bookmark_border_rounded,
              size: 25,
              color: Colors.black,
            ),
            onPressed: () {
              print("Bookmark");
            },
          ),
        ],
      ),
    );
  }

  Column complaintDetails(Size screenSize) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                widget.complaint??"Complaint null hai",
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
              widget.supervisor??"Supervisor null hai 1",
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
              widget.date,
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
        FlatButton(
          onPressed: () => {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TrackComplaints(

                )))
          },
          color: Colors.blue[400],
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
      ],
    );
  }
}
