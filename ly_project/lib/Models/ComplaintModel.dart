import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Complaint{
        String citizenEmail, complaint, description, dateTime, feedback, id;
        ImageData imageData;
        String latitude, longitude, location, resolutionDateTime, issueReportedDateTime, closedDateTime, issueReassignedDateTime;
        bool overdue;
        String status, supervisorId, supervisorEmail, supervisorName;
        DocumentReference supervisorDocRef;
        ImageData supervisorImageData;
        int upvoteCount;
        String ward, wardId;

        String get getId => this.id;
        // set setId(String id) => this.id = id;

        ImageData get getImageData => this.imageData;
        // set setImageData( imageData) => this.imageData = imageData;

        String get getIssueReassignedDateTime => this.issueReassignedDateTime;
        // set setIssueReassignedDateTime( issueReassignedDateTime) => this.issueReassignedDateTime = issueReassignedDateTime;

        bool get getOverdue => this.overdue;

        String get getSupervisorName => this.supervisorName;
        // set setSupervisorName( supervisorName) => this.supervisorName = supervisorName;

        DocumentReference get getSupervisorDocRef => this.supervisorDocRef;
        // set setSupervisorDocRef( supervisorDocRef) => this.supervisorDocRef = supervisorDocRef;

        ImageData get getSupervisorImageData => this.supervisorImageData;
        // set setSupervisorImageData( supervisorImageData) => this.supervisorImageData = supervisorImageData;

        int get getUpvoteCount => this.upvoteCount;
        // set setUpvoteCount( upvoteCount) => this.upvoteCount = upvoteCount;

        String get getWardId => this.wardId;
        // set setWardId( wardId) => this.wardId = wardId;
        

        Complaint({
          @required this.citizenEmail, 
          @required this.complaint,  
          @required this.description, 
          @required this.dateTime, 
          @required this.feedback, 
          @required this.id,
          @required this.imageData,
          @required this.latitude, 
          @required this.longitude, 
          @required this.location, 
          @required this.resolutionDateTime, 
          @required this.issueReportedDateTime, 
          @required this.closedDateTime, 
          @required this.issueReassignedDateTime,
          @required this.overdue, 
          @required this.status, 
          @required this.supervisorId, 
          @required this.supervisorEmail, 
          @required this.supervisorName,
          @required this.supervisorDocRef,
          @required this.supervisorImageData,
          @required this.upvoteCount,
          @required this.ward, 
          @required this.wardId,
        });

        factory Complaint.fromJSON(Map<String, dynamic> json){
          ImageData supervisorImageData;
          if(json["supervisorImageData"] == null){
            supervisorImageData = ImageData(
                dateTime: null, 
                location: null, 
                submittedBy: null, 
                lat:  null, 
                long: null, 
                userType: null, 
                url: null,
            );
          }else{
            double lat = json["supervisorImageData"]["lat"] != null ? double.parse(json["supervisorImageData"]["lat"]): null ;
            double long = json["supervisorImageData"]["long"] != null ? double.parse(json["supervisorImageData"]["long"]) : null;
            supervisorImageData = ImageData(
              dateTime:  json["supervisorImageData"]["dateTime"], 
              location: json["supervisorImageData"]["location"], 
              submittedBy: json["supervisorImageData"]["submittedBy"], 
              lat: lat, 
              long: long, 
              userType:  json["supervisorImageData"]["userType"], 
              url: json["supervisorImageData"]["url"],
          );
          }
          return new Complaint(
            citizenEmail: json["citizenEmail"],
            closedDateTime: json["closedDateTime"],
            complaint: json["complaint"],
            dateTime: json["dateTime"],
            description: json["description"],
            feedback: json["feedback"],
            id: json["id"],
            imageData: ImageData(
              dateTime: json["imageData"]["dateTime"], 
              location: json["imageData"]["location"], 
              submittedBy: json["imageData"]["submittedBy"], 
              lat: json["imageData"]["lat"], 
              long: json["imageData"]["long"], 
              userType: json["imageData"]["userType"], 
              url: json["imageData"]["url"],
            ),
            issueReassignedDateTime: json["issueReassignedDateTime"],
            issueReportedDateTime: json["issueReportedDateTime"],
            location: json["location"],
            latitude: json["latitude"],
            longitude: json["longitude"],
            overdue: json["overdue"],
            resolutionDateTime: json["resolutionDateTime"],
            status: json["status"],
            supervisorDocRef: json["supervisorDocRef"],
            supervisorEmail: json["supervisorEmail"],
            supervisorId: json["supervisorId"],
            supervisorImageData: supervisorImageData,
            supervisorName: json["supervisorName"],
            upvoteCount: json["upvoteCount"],
            ward: json["ward"],
            wardId: json["wardId"],
          );
        }

        Map<String, dynamic> toMap(){
          return {
            'citizenEmail': citizenEmail,
            'complaint': complaint,
            'description': description,
            'dateTime': dateTime,
            "feedback": feedback,
            'id': id,
            'imageData': imageData.toMap(),
            'latitude': latitude,
            'longitude': longitude,
            'location': location,
            'resolutionDateTime': resolutionDateTime,
            'issueReportedDateTime': issueReportedDateTime,
            'closedDateTime': closedDateTime,
            'issueReassignedDateTime': issueReassignedDateTime,
            'overdue': overdue,
            'status': status,
            'supervisorId': supervisorId,
            'supervisorEmail': supervisorEmail,
            'supervisorName': supervisorName,
            'supervisorDocRef': supervisorDocRef,
            "supervisorImageData": supervisorImageData.toMap(),
            'upvoteCount': upvoteCount,
            "ward": ward,
            "wardId": wardId
          };
        }
}

class ImageData{
    String dateTime;
    String location;
    String submittedBy;
    double lat;
    double long;
    String userType;
    String url;

    ImageData({
      @required this.dateTime,
      @required this.location,
      @required this.submittedBy,
      @required this.lat,
      @required this.long,
      @required this.userType,
      @required this.url,
    });

    Map<String, dynamic> toMap(){
      return {
        "dateTime": this.dateTime,
        "lat": lat,
        "long": long,
        "submittedBy": submittedBy,
        "url": url,
        "userType": userType,
      };
    }

    String get getDateTime => this.dateTime;
    // set setDateTime(String dateTime) => this.dateTime = dateTime;
    
    String get getLocation => this.location;
    // set setLocation(String location) => this.location = location;
    
    String get getSubmittedBy => this.submittedBy;
    // set setSubmittedBy(String submittedBy) => this.submittedBy = submittedBy;
    
    double get getLat => this.lat;
    // set setLat(String lat) => this.lat = lat;
    
    double get getLong => this.long;
    // set setLong(String long) => this.long = long;
    
    String get getUserType => this.userType;
    // set setUserType(String userType) => this.userType = userType;
    
    String get getUrl => this.url;
    // set setUrl(String url) => this.url = url;
}