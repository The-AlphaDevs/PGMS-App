import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ly_project/Pages/Feed/feedCard.dart';
import 'package:ly_project/Services/auth.dart';

class ComplaintsHistoryTab extends StatefulWidget {
  final userEmail;
  final BaseAuth auth;
  ComplaintsHistoryTab({this.userEmail, this.auth});

  @override
  State<ComplaintsHistoryTab> createState() => _ComplaintsHistoryTabState();
}

class _ComplaintsHistoryTabState extends State<ComplaintsHistoryTab> {
  
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(
          right: 20, left: 20, top: 0, bottom: 0),
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
                  .collection("complaints")
                  .where("citizenEmail", isEqualTo: widget.userEmail)
                  .where("status", whereIn: ["Resolved", "Closed"])
                  // .orderBy("dateTime", descending: true)
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
                    print(snapshot.data.docs.length);
                    return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    padding: EdgeInsets.only(
                        left: 10, right: 10),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      
                      return ComplaintOverviewCard
                      (
                        auth: widget.auth,
                        id: snapshot.data.docs[index]["id"],
                        complaint: snapshot.data.docs[index]["complaint"],
                        date: snapshot.data.docs[index]["dateTime"],
                        status: snapshot.data.docs[index]["status"],
                        image: snapshot.data.docs[index]["imageData"]["url"],
                        location: snapshot.data.docs[index]["imageData"]["location"],
                        supervisor: snapshot.data.docs[index]["supervisorName"],
                        lat: snapshot.data.docs[index]["latitude"],
                        long: snapshot.data.docs[index]["longitude"],
                        description: snapshot.data.docs[index]["description"],
                        citizenEmail: snapshot.data.docs[index]["citizenEmail"],
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