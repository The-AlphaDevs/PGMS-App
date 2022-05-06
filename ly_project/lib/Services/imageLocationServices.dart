import 'dart:io';

import 'package:exif/exif.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class ImageLocationServices {
  static Future<GeoFirePoint> getImageLocation({
    @required File file,
    @required Function setImageMetadata,
    @required Function errorCallback,
  }) async {
    if (file == null) return null;
    try {
      Map<String, IfdTag> imgTags =
          await readExifFromBytes(file.readAsBytesSync());
      setImageMetadata(imgTags);

      if (imgTags.containsKey('GPS GPSLongitude')) {
        return exifGPSToGeoFirePoint(imgTags);
      }
      return null;
    } catch (e) {
      if (e is FileSystemException) {
        errorCallback("Error reading the image!");
      }
      errorCallback("Something went wrong, please retry.");
      return null;
    }
  }

  static GeoFirePoint exifGPSToGeoFirePoint(Map<String, IfdTag> tags) {
    if (tags.isEmpty) return null;

    final latitudeValue = tags['GPS GPSLatitude']
        .values
        .map<double>(
            (item) => (item.numerator.toDouble() / item.denominator.toDouble()))
        .toList();
    final latitudeSignal = tags['GPS GPSLatitudeRef'].printable;

    final longitudeValue = tags['GPS GPSLongitude']
        .values
        .map<double>(
            (item) => (item.numerator.toDouble() / item.denominator.toDouble()))
        .toList();
    final longitudeSignal = tags['GPS GPSLongitudeRef'].printable;

    double latitude =
        latitudeValue[0] + (latitudeValue[1] / 60) + (latitudeValue[2] / 3600);

    double longitude = longitudeValue[0] +
        (longitudeValue[1] / 60) +
        (longitudeValue[2] / 3600);

    if (latitudeSignal == 'S') latitude = -latitude;
    if (longitudeSignal == 'W') longitude = -longitude;
    print("latitude, longitude\n$latitude, $longitude");

    return GeoFirePoint(latitude, longitude);
  }
}