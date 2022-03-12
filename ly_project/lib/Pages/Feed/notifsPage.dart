import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ly_project/Services/auth.dart';
import 'package:ly_project/utils/colors.dart';
import 'package:uuid/uuid.dart';
import 'package:ly_project/Pages/Feed/notifsCard.dart';


class Notifications extends StatefulWidget {
  final BaseAuth auth;
  Notifications({this.auth});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  var uuid = Uuid();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final user = widget.auth.currentUserEmail();
    return Scaffold(
          appBar: AppBar(
          // automaticallyImplyLeading: false,
          backgroundColor: DARK_BLUE,
          title: Text(
            "Notifications",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
          body: Padding(
        padding: EdgeInsets.fromLTRB(size.width*0.03, size.height*0.03, size.width*0.03, size.height*0.06),
        child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(user)
                    .collection('notifications')
                    .snapshots(),
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
                                      child: Text("No Notifications"),
                                    );
                                  } 
                                  else{
                                    print("List built !!");
                                    return ListView.builder(
                                    // scrollDirection: Axis.vertical,
                                    itemCount: snapshot.data.docs.length,
                                    padding: EdgeInsets.only(
                                        left: 10, right: 10),
                                    shrinkWrap: true,
                                    key: new Key(uuid.v4()),
                                    itemBuilder: (context, index) {
                                      
                                      return NotifsCard
                                      (// 
                                        id: snapshot.data.docs[index]["id"],
                                        auth: widget.auth,
                                        complaint: snapshot.data.docs[index]["complaint"],
                                        date: snapshot.data.docs[index]["date"],
                                        status: snapshot.data.docs[index]["status"],
                                        location: snapshot.data.docs[index]["location"],
                                        latitude: snapshot.data.docs[index]["latitude"],
                                        longitude: snapshot.data.docs[index]["longitude"],
                                      );                        
                                    },
                                  );
                                }
                              }
                            }
                          ),
      ),
    );
  }
}