import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ly_project/Pages/DetailedComplaint/detailed_complaint.dart';
import 'package:ly_project/Services/auth.dart';
import 'package:ly_project/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class ComplaintOverviewCard extends StatefulWidget {
  final id;
  final BaseAuth auth;
  final complaint;
  final status;
  final date;
  final image;
  final location;
  final supervisor;
  final lat;
  final long;
  final description;
  final citizenEmail;
  final docId;
  final upvoteCount;
  final supervisorDocRef;
  final supervisorImageUrl;

  ComplaintOverviewCard({
    @required this.id,
    @required this.docId,
    @required this.auth,
    @required this.complaint,
    @required this.description,
    @required this.date,
    @required this.status,
    @required this.image,
    @required this.location,
    @required this.supervisor,
    @required this.lat,
    @required this.long,
    @required this.citizenEmail,
    @required this.upvoteCount,
    @required this.supervisorDocRef,
    @required this.supervisorImageUrl,
  });
  @override
  _ComplaintOverviewCardState createState() => _ComplaintOverviewCardState();
}

class _ComplaintOverviewCardState extends State<ComplaintOverviewCard> {
  bool isUpvoted = false;
  String complaintId;
  String userEmail;
  int upvoteCount;

  Future<void> updateUpvoteCount(DocumentReference upvoteDoc,
      DocumentReference complaintDoc, int updateValue) async {
    try {
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        //Get upvote count from the complaint doc
        DocumentSnapshot snapshot = await transaction.get(complaintDoc);
        int newUpvoteCount = snapshot.data()['upvoteCount'] + updateValue;

        //Update the upvote count as newUpvoteCount in the complaint doc
        transaction.update(complaintDoc, {"upvoteCount": (newUpvoteCount)});

        //Update upvoteCount on screen
        setState(() => upvoteCount = newUpvoteCount);
      });
    } catch (e) {
      print("Failed to update upvote counter!");
    }
  }

  /// Returns true if complaint is upvoted successfully
  Future<bool> markAsUpvoted({bool init = false}) async {
    try {
      if (init) {
        /// It is an error to call [setState] unless [mounted] is true.
        if (this.mounted) setState(() => isUpvoted = true);
        return true;
      }

      var upvoteDoc = FirebaseFirestore.instance
          .collection("complaints")
          .doc(complaintId)
          .collection("upvotes")
          .doc(userEmail);
      var complaintDoc =
          FirebaseFirestore.instance.collection("complaints").doc(complaintId);
      setState(() => isUpvoted = true);

      await upvoteDoc.set(
          {"upvotedAt": DateTime.now().toString(), "upvotedBy": userEmail});
      await updateUpvoteCount(upvoteDoc, complaintDoc, 1);
      return true;
    } catch (e) {
      print("Failed to upvote");
      setState(() => isUpvoted = false);
      return false;
    }
  }

  /// Returns true if the upvote is removed successfully
  Future<bool> removeUpvote() async {
    try {
      setState(() => isUpvoted = false);
      var upvoteDoc = FirebaseFirestore.instance
          .collection("complaints")
          .doc(complaintId)
          .collection("upvotes")
          .doc(userEmail);
      var complaintDoc =
          FirebaseFirestore.instance.collection("complaints").doc(complaintId);
      await upvoteDoc.delete();
      await updateUpvoteCount(upvoteDoc, complaintDoc, -1);

      return true;
    } catch (e) {
      print("Failed to remove upvote!");
      setState(() => isUpvoted = true);
      return false;
    }
  }

  Future<bool> checkIfUpvoted() async {
    try {
      // Get reference to Firestore collection
      var collectionRef = FirebaseFirestore.instance
          .collection("complaints")
          .doc(complaintId)
          .collection("upvotes");
      var upvoteDoc = await collectionRef.doc(userEmail).get();
      if (upvoteDoc.exists) markAsUpvoted(init: true);

      return upvoteDoc.exists;
    } catch (e) {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    userEmail = widget.auth.currentUserEmail();
    complaintId = widget.docId;
    upvoteCount = widget.upvoteCount;
    checkIfUpvoted();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: InkWell(
          onTap: () {
            print("Tap!");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => (DetailComplaint(
                  auth: widget.auth,
                  id: widget.id,
                  docId: widget.docId,
                  complaint: widget.complaint,
                  description: widget.description,
                  date: widget.date,
                  status: widget.status,
                  image: widget.image,
                  supervisor: widget.supervisor,
                  supervisorDocRef: widget.supervisorDocRef,
                  location: widget.location,
                  lat: widget.lat,
                  long: widget.long,
                  citizenEmail: widget.citizenEmail,
                  supervisorImageUrl:widget.supervisorImageUrl
                )),
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(size.width * 0.01, size.height * 0.01,
                size.width * 0.01, size.height * 0.005),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: size.width * 0.45,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.complaint.toString().length > 50
                            ? widget.complaint.toString().substring(0, 51) +
                                " ..."
                            : widget.complaint.toString(),
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: size.height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.contacts, size: 12, color: Colors.black),
                          SizedBox(width: 5),
                          Flexible(
                            child: Text(
                              "Posted by " + widget.citizenEmail,
                              overflow: TextOverflow.visible,
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.calendar_today,
                              size: 12, color: Colors.grey),
                          SizedBox(width: 5),
                          Text(
                            DateFormat.yMMMMd()
                                .format(DateTime.parse(widget.date)),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(height: size.height * 0.005),
                              Text(
                                widget.status,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: COMPLAINT_STATUS_COLOR_MAP[
                                              widget.status] !=
                                          null
                                      ? COMPLAINT_STATUS_COLOR_MAP[
                                          widget.status]
                                      : Colors.deepOrange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: size.height * 0.008),
                              Text(
                                "Status",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 10),
                              ),
                            ],
                          ),
                          SizedBox(width: size.width * 0.03),
                          widget.status == "In Progress" || widget.status == "Pending"
                          ?  
                          Column(
                            children: [
                              Container(
                                width: size.width * 0.08,
                                height: size.height * 0.035,
                                child: InkWell(
                                  onTap: () async {
                                    //Check if upvoted already
                                    if (isUpvoted) {
                                      //Remove upvote
                                      await removeUpvote();
                                      print("Upvote Removed!");
                                    } else {
                                      //Add upvote
                                      await markAsUpvoted();
                                      await HapticFeedback.vibrate();
                                      print("Upvoted!");
                                    }
                                  },
                                  borderRadius: BorderRadius.circular(29),
                                  child: Icon(Icons.arrow_upward_outlined,
                                      color: isUpvoted
                                          ? Colors.orange
                                          : Colors.grey),
                                ),
                              ),
                              SizedBox(height: size.height * 0.00),
                              Text(
                                "Upvote $upvoteCount",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 10),
                              ),
                            ],
                          )
                          :
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children:[
                              Text(
                                upvoteCount.toString(),
                                style:
                                    TextStyle(color: Colors.grey[700], fontSize: 11),
                                ),
                              SizedBox(height: size.height * 0.008),

                              Text(
                                "Upvotes",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 10),
                              ),
                            ],
                          ),

                          SizedBox(width: size.width * 0.03),
                          if(widget.status == "In Progress" || widget.status == "Pending")
                          InkWell(
                            onTap: () => print("Bookmarked!"),
                            borderRadius: BorderRadius.circular(20),
                            child: Icon(Icons.bookmark_border_rounded,
                                size: size.height * 0.03, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: size.width * 0.35,
                  height: size.height * 0.15,
                  child: CachedNetworkImage(
                    imageUrl: widget.image,
                    placeholder: (context, url) => Center(
                      child: Container(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator(strokeWidth: 2.0),
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
