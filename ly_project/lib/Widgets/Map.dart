import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong/latlong.dart";
import 'package:cached_network_image/cached_network_image.dart';

class CachedTileProvider extends TileProvider {
  const CachedTileProvider();
  @override
  ImageProvider getImage(Coords<num> coords, TileLayerOptions options) {
    //Now you can set options that determine how the image gets cached via whichever plugin you use.
    return CachedNetworkImageProvider(getTileUrl(coords, options));
  }
}

class ComplaintMap extends StatelessWidget {
  double _longitude = 0, _latitude = 0;
  LatLng centerPosition;
  double zoomLevel = 14.0;
  MapController _mapController;

  ComplaintMap({Key key, double longitude, double latitude}) {
    _longitude = longitude;
    _latitude = latitude;
    _mapController = new MapController();
    centerPosition = LatLng(latitude, longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(center: centerPosition, zoom: zoomLevel),
          layers: [
            TileLayerOptions(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
                tileProvider: const CachedTileProvider()),
            MarkerLayerOptions(
              markers: [
                Marker(
                  point: centerPosition,
                  builder: (ctx) => Container(
                    child: Icon(Icons.location_on,
                        size: 30,
                        color: Colors.red[900],
                        semanticLabel: "Location of the pothole"),
                  ),
                ),
              ],
            ),
          ],
        ),
        Positioned(
            bottom: 15,
            right: 3,
            child: IconButton(
                tooltip: "Recenter",
                color: Colors.white,
                padding: EdgeInsets.all(3),
                icon: Icon(Icons.my_location, color: Colors.black, size: 22),
                onPressed: () => _mapController.moveAndRotate(
                    LatLng(_latitude, _longitude), 14.0, 0.0))),
        Positioned(
          bottom: 3,
          right: 3,
          child: Text(
            "© OpenStreetMap Contributors",
            style: TextStyle(fontSize: 8, backgroundColor: Colors.white30),
          ),
        ),
      ],
    );
  }
}
