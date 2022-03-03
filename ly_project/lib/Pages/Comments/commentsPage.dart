// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:ly_project/Pages/Comments/commentsCard.dart';

// class Comments extends StatefulWidget {
//   final String id;
//   Comments({Key key, this.id}) : super(key: key);
//   @override
//   State<Comments> createState() => _CommentsState();
// }

// class _CommentsState extends State<Comments> {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     return Padding(
//       padding: EdgeInsets.only(right: size.width*0.01, left: size.width*0.01, top: size.height*0.2, bottom: size.height*0.03),
//       child: StreamBuilder(
//           stream: FirebaseFirestore.instance
//                   .collection("complaints")
//                   .doc(widget.id)
//                   .collection("comments")
//                   .snapshots()
//                   ,
//           builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
//             if(!snapshot.hasData){
//               print("Connection state: has no data");            
//               return Column(children: [
//                   SizedBox(
//                     height:size.height*0.2,
//                   ),
//                   CircularProgressIndicator(),
//                 ],
//               );

//             }
//             else if(snapshot.connectionState == ConnectionState.waiting){
//               print("Connection state: waiting");
//               return Column(children: [   
//                     SizedBox(
//                       height:size.height*0.2,
//                     ),
//                     CircularProgressIndicator(),
//                 ],
//               );
//             }          
            
//             else{
//               // return ListView(
//                 // children: snapshot.data.docs.map((document) {
//                 print("Connection state: hasdata");
//                   if(snapshot.data.docs.length == 0){
//                     return Center(
//                       child: Text("No Comments"),
//                     );
//                   } 
//                   else{
//                     return ListView.builder(
//                     // scrollDirection: Axis.vertical,
//                     itemCount: snapshot.data.docs.length,
//                     padding: EdgeInsets.only(
//                         left: 10, right: 10),
//                     shrinkWrap: true,
//                     itemBuilder: (context, index) {
//                       return CommentsCard
//                       (
//                         photo: snapshot.data.docs[index]["photo"],
//                         name: snapshot.data.docs[index]["name"],
//                         comment: snapshot.data.docs[index]["comment"],
//                       );                        
//                     },
//                   );
//                 }
//               }
//             }
//           ),
//     );
//   }
// }


