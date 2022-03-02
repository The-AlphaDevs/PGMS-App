import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ly_project/Pages/Comments/commentsPage.dart';
import 'package:ly_project/Pages/TrackComplaint/track_complaint.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:location/location.dart';
import "package:latlong/latlong.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ly_project/Pages/Comments/commentsCard.dart';

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
  final description;

  DetailComplaint(
      {this.id,
      this.complaint,
      this.description,
      this.location,
      this.status,
      this.image,
      this.date,
      this.supervisor,
      this.lat,
      this.long});
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

  @override
  void initState() {
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
          widget.id ?? "Ye null hai 1",
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
                    ),
                    child: CachedNetworkImage(
                      imageUrl: widget.image,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.fitHeight,
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
                        center: LatLng(latitude, longitude),
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
                              point: LatLng(latitude, longitude),
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
              trackComplaintButton(context, screenSize),
              SizedBox(
                height: screenSize.height * 0.06,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => Comments(
              //               id: widget.id,
              //             )));
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.white,
                //elevates modal bottom screen
                elevation: 40,
                // gives rounded corner to modal bottom screen
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                builder: (BuildContext context) {
                  return Container(
                    height: size.height*0.4,
                    child: Padding(
                      padding: EdgeInsets.only(right: size.width*0.01, left: size.width*0.01, top: size.height*0.2, bottom: size.height*0.03),
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                                  .collection("complaints")
                                  .doc(widget.id)
                                  .collection("comments")
                                  .snapshots()
                                  ,
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                            if(!snapshot.hasData){
                              print("Connection state: has no data");            
                              return Column(children: [
                                  SizedBox(
                                    height:size.height*0.2,
                                  ),
                                  CircularProgressIndicator(),
                                ],
                              );

                            }
                            else if(snapshot.connectionState == ConnectionState.waiting){
                              print("Connection state: waiting");
                              return Column(children: [   
                                    SizedBox(
                                      height:size.height*0.2,
                                    ),
                                    CircularProgressIndicator(),
                                ],
                              );
                            }          
                            
                            else{
                              // return ListView(
                                // children: snapshot.data.docs.map((document) {
                                print("Connection state: hasdata");
                                  if(snapshot.data.docs.length == 0){
                                    return Center(
                                      child: Text("No Comments"),
                                    );
                                  } 
                                  else{
                                    return ListView.builder(
                                    // scrollDirection: Axis.vertical,
                                    itemCount: snapshot.data.docs.length,
                                    padding: EdgeInsets.only(
                                        left: 10, right: 10),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return CommentsCard
                                      (
                                        photo: snapshot.data.docs[index]["photo"],
                                        name: snapshot.data.docs[index]["name"],
                                        comment: snapshot.data.docs[index]["comment"],
                                      );                        
                                    },
                                  );
                                }
                              }
                            }
                          ),
                    ),
                  );
            },
              );
            },
            child: Row(
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
                              id: widget.id,
                              complaint: widget.complaint,
                              date: widget.date,
                              location: widget.location,
                              latitude: latitude,
                              longitude: longitude,
                              status: widget.status
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
          ),
        ),
      ],
    );
  }
}
