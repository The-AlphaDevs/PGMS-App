import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ly_project/Pages/Feed/feedCard.dart';

class FeedTab extends StatelessWidget {
  // const FeedTab({Key key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(
          right: 20, left: 20, top: 140, bottom: 5),
      child: 
      // ListView.builder(
      //   shrinkWrap: true,
      //   itemCount: 6,
      //   itemBuilder: (context, index) {
      //     return ComplaintOverviewCard();
      //   },
      // ),
      SingleChildScrollView(
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
                      scrollDirection: Axis.vertical,
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
                        //// // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: <Widget>[
                        //     index == 0 ?
                        //     Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children:[
                        //         text(
                        //       snapshot.data.docs[index]["transaction date"],
                        //       fontSize: textSizeMedium,
                        //       textColor: TextColorSecondary,
                        //       fontFamily: fontMedium,
                        //       )
                        //         .paddingOnly(top: 12, bottom: spacing_standard_new)
                        //         .visible(snapshot.data.docs[index]["transaction date"].toString().isNotEmpty),
                              
                        //       InkWell(
                        //         focusColor: app_Background,
                              
                        //         child: Container(
                        //           decoration: boxDecoration(
                        //             bgColor: white,
                        //             showShadow: false,
                        //             color: app_Background,
                        //             radius: spacing_standard,
                        //           ),
                        //           padding: EdgeInsets.all(spacing_standard),
                        //           margin: EdgeInsets.only(bottom: spacing_standard),
                        //           child: Row(
                        //             children: <Widget>[
                        //               Expanded(
                        //                 child: Column(
                        //                   mainAxisSize: MainAxisSize.max,
                        //                   crossAxisAlignment: CrossAxisAlignment.start,
                        //                   children: <Widget>[
                        //                     text(snapshot.data.docs[index]["type"],
                        //                         fontSize: textSizeMedium,
                        //                         textColor: appStore.textPrimaryColor,
                        //                         fontFamily: fontMedium),
                        //                     text("Status: ${status}",
                        //                             fontSize: textSizeMedium,
                        //                             textColor: appStore.textSecondaryColor)
                        //                         .paddingTop(spacing_control_half),
                        //                   ],
                        //                 ),
                        //               ),
                        //               Column(
                        //                 children: <Widget>[
                        //                   snapshot.data.docs[index]["type"] == "Money Added" ? text("+ $rupees" + snapshot.data.docs[index]["amount"].toString(),
                        //                       fontSize: textSizeMedium,
                        //                       textColor: Colors.green,
                        //                       fontFamily: fontBold) : text("- $rupees" + snapshot.data.docs[index]["amount"].toString(),
                        //                       fontSize: textSizeMedium,
                        //                       textColor: Colors.red,
                        //                       fontFamily: fontBold),
                                          
                        //                   text(snapshot.data.docs[index]["time"],
                        //                           fontSize: textSizeMedium,
                        //                           textColor: appStore.textSecondaryColor)
                        //                       .paddingTop(spacing_control)
                        //                 ],
                        //               )
                        //             ],
                        //           ),
                        //         ),
                        //       )

                        //       ]
                        //     ):

                        //     snapshot.data.docs[index]["transaction date"] != snapshot.data.docs[index-1]["transaction date"] ? 
                        //     Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children:[
                        //         text(
                        //       snapshot.data.docs[index]["transaction date"],
                        //       // list[index].transactionDate,
                        //       fontSize: textSizeMedium,
                        //       textColor: TextColorSecondary,
                        //       fontFamily: fontMedium,
                        //       )
                        //         .paddingOnly(top: 12, bottom: spacing_standard_new)
                        //         .visible(snapshot.data.docs[index]["transaction date"].toString().isNotEmpty),
                        //       // OrderWidget(snapshot.data.docs[index], categoryWidth),
                        //       InkWell(
                        //         focusColor: app_Background,
                              
                        //         child: Container(
                        //           decoration: boxDecoration(
                        //             bgColor: white,
                        //             showShadow: false,
                        //             color: app_Background,
                        //             radius: spacing_standard,
                        //           ),
                        //           padding: EdgeInsets.all(spacing_standard),
                        //           margin: EdgeInsets.only(bottom: spacing_standard),
                        //           child: Row(
                        //             children: <Widget>[
                        //               Expanded(
                        //                 child: Column(
                        //                   mainAxisSize: MainAxisSize.max,
                        //                   crossAxisAlignment: CrossAxisAlignment.start,
                        //                   children: <Widget>[
                        //                     text(snapshot.data.docs[index]["type"],
                        //                         fontSize: textSizeMedium,
                        //                         textColor: appStore.textPrimaryColor,
                        //                         fontFamily: fontMedium),
                        //                     text("Status: ${status}",
                        //                             fontSize: textSizeMedium,
                        //                             textColor: appStore.textSecondaryColor)
                        //                         .paddingTop(spacing_control_half),
                        //                   ],
                        //                 ),
                        //               ),
                        //               Column(
                        //                 children: <Widget>[
                        //                   snapshot.data.docs[index]["type"] == "Money Added" ? text("+ $rupees" + snapshot.data.docs[index]["amount"].toString(),
                        //                       fontSize: textSizeMedium,
                        //                       textColor: Colors.green,
                        //                       fontFamily: fontBold) : text("- $rupees" + snapshot.data.docs[index]["amount"].toString(),
                        //                       fontSize: textSizeMedium,
                        //                       textColor: Colors.red,
                        //                       fontFamily: fontBold),
                                          
                        //                   text(snapshot.data.docs[index]["time"],
                        //                           fontSize: textSizeMedium,
                        //                           textColor: appStore.textSecondaryColor)
                        //                       .paddingTop(spacing_control)
                        //                 ],
                        //               )
                        //             ],
                        //           ),
                        //         ),
                        //       )

                        //       ]
                        //     ):
                        //     Column(
                        //       children:[
                        //       InkWell(
                        //         focusColor: app_Background,
                              
                        //         child: Container(
                        //           decoration: boxDecoration(
                        //             bgColor: white,
                        //             showShadow: false,
                        //             color: app_Background,
                        //             radius: spacing_standard,
                        //           ),
                        //           padding: EdgeInsets.all(spacing_standard),
                        //           margin: EdgeInsets.only(bottom: spacing_standard),
                        //           child: Row(
                        //             children: <Widget>[
                        //               Expanded(
                        //                 child: Column(
                        //                   mainAxisSize: MainAxisSize.max,
                        //                   crossAxisAlignment: CrossAxisAlignment.start,
                        //                   children: <Widget>[
                        //                     text(snapshot.data.docs[index]["type"],
                        //                         fontSize: textSizeMedium,
                        //                         textColor: appStore.textPrimaryColor,
                        //                         fontFamily: fontMedium),
                        //                     text("Status: ${status}",
                        //                             fontSize: textSizeMedium,
                        //                             textColor: appStore.textSecondaryColor)
                        //                         .paddingTop(spacing_control_half),
                        //                   ],
                        //                 ),
                        //               ),
                        //               Column(
                        //                 children: <Widget>[
                        //                   snapshot.data.docs[index]["type"] == "Money Added" ? text("+ $rupees" + snapshot.data.docs[index]["amount"].toString(),
                        //                       fontSize: textSizeMedium,
                        //                       textColor: Colors.green,
                        //                       fontFamily: fontBold) : text("- $rupees" + snapshot.data.docs[index]["amount"].toString(),
                        //                       fontSize: textSizeMedium,
                        //                       textColor: Colors.red,
                        //                       fontFamily: fontBold),
                                          
                        //                   text(snapshot.data.docs[index]["time"],
                        //                           fontSize: textSizeMedium,
                        //                           textColor: appStore.textSecondaryColor)
                        //                       .paddingTop(spacing_control)
                        //                 ],
                        //               )
                        //             ],
                        //           ),
                        //         ),
                        //       )

                        //       ]
                        //     )
                          // ],
                        // )
                        
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
