import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import "package:latlong/latlong.dart";

class ComplaintCard extends StatefulWidget {
  final complaint;
  final date;
  final location;
  final latitude;
  final longitude;

  ComplaintCard({this.complaint, this.date, this.location, this.latitude, this.longitude});

  @override
  State<ComplaintCard> createState() => _ComplaintCardState();
}

class _ComplaintCardState extends State<ComplaintCard> {
  int difference;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.date.runtimeType);
    print("track ka lat: " + widget.latitude.toString());
    print("track ka long: " + widget.longitude.toString());
    final date = DateTime.parse(widget.date);
    final start_date = DateTime(date.year, date.month, date.day);
    final date2 = DateTime.now();
    difference = date2.difference(start_date).inDays;
  }
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(25.0),
      child: Card(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.03,
              vertical: size.height * 0.02,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: size.width * 0.42,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.complaint,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: Colors.grey
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            DateFormat.yMMMMd().format(DateTime.parse(widget.date)),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey),
                          ),
                        ],
                      ),

                      SizedBox(height: 10),
                      
                      Flexible(
                        flex: 10,
                        // fit: FlexFit.tight,
                        child: Text(
                          widget.location,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),

                      SizedBox(
                        height: 5,
                      ),

                      Text(
                        "Posted "+ difference.toString() +" days ago",
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                // Container(
                //   width: size.width * 0.42,
                //   child: Image(
                //     image: AssetImage('assets/loc.jpg'),
                //     fit: BoxFit.cover,
                //   ),
                // ),
                Container(
                  height: 100,
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(6.0),
                    //   image: DecorationImage(
                    //     image: AssetImage('assets/loc.jpg'),
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                  // width: size.width * 0.42,
                  child: FlutterMap(
                    options: MapOptions(
                      center: LatLng(widget.latitude,
                          widget.longitude),
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
                            width: 40,
                            height: 40.0,
                            point: LatLng(widget.latitude,
                            widget.longitude),
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
            ),
          )),
    );
  }
}

