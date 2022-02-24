import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ly_project/Pages/Feed/feedCard.dart';

class FeedTab extends StatefulWidget {

  @override
  State<FeedTab> createState() => _FeedTabState();
}

class _FeedTabState extends State<FeedTab> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(right: size.width*0.01, left: size.width*0.01, top: size.height*0.2, bottom: size.height*0.03),
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
                  .collection("complaints")
                  .orderBy("dateTime", descending: true)
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
                      child: Text("No Past Feeds"),
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
                      
                      return ComplaintOverviewCard
                      (
                        id: snapshot.data.docs[index]["id"],
                        complaint: snapshot.data.docs[index]["complaint"],
                        date: snapshot.data.docs[index]["dateTime"],
                        status: snapshot.data.docs[index]["status"],
                        image: snapshot.data.docs[index]["imageData"]["url"],
                        location: snapshot.data.docs[index]["imageData"]["location"],
                        supervisor: snapshot.data.docs[index]["supervisorName"],
                        lat: snapshot.data.docs[index]["latitude"],
                        long: snapshot.data.docs[index]["longitude"],
                      );                        
                    },
                  );
                }
              }
            }
          ),
    );
  }
}


