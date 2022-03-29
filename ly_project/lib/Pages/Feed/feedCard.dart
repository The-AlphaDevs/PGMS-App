import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ly_project/Pages/DetailedComplaint/detailed_complaint.dart';
import 'package:ly_project/Services/auth.dart';
import 'package:ly_project/utils/colors.dart';

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
  final overdue;
  final supervisorDocRef;
  final supervisorEmail;
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
    @required this.overdue,
    @required this.supervisorDocRef,
    @required this.supervisorEmail,
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

  @override
  void initState() {
    super.initState();
    userEmail = widget.auth.currentUserEmail();
    complaintId = widget.docId;
    upvoteCount = widget.upvoteCount;
  }

  @override
  Widget build(BuildContext context) {
    print("upvoteCount :- " + upvoteCount.toString());
    Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: widget.overdue ? Colors.red[100] : Colors.white,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailComplaint(
                  auth: widget.auth,
                  id: widget.id,
                  docId: widget.docId,
                  complaint: widget.complaint,
                  description: widget.description,
                  date: widget.date,
                  status: widget.status,
                  image: widget.image,
                  supervisor: widget.supervisor,
                  location: widget.location,
                  lat: widget.lat,
                  long: widget.long,
                  citizenEmail: widget.citizenEmail,
                  supervisorDocRef: widget.supervisorDocRef,
                  supervisorEmail: widget.supervisorEmail,
                  supervisorImageUrl: widget.supervisorImageUrl,
                ),
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
                              overflow: TextOverflow.ellipsis,
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
                                color: Colors.grey[700]),
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
                                widget.overdue ? "Overdue" : widget.status,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: widget.overdue ? Colors.red :COMPLAINT_STATUS_COLOR_MAP[
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
                                    TextStyle(color: Colors.grey, fontSize: widget.overdue? 14 :10),
                              ),
                            ],
                          ),
                          SizedBox(width: size.width * 0.04),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // width: size.width*0.08,
                                height: size.height * 0.035,
                                child: Text(
                                  upvoteCount.toString(),
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              // SizedBox(height: size.height*0.00),
                              Text(
                                "Upvotes",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 10),
                              ),
                            ],
                          ),
                          SizedBox(width: size.width * 0.03),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
