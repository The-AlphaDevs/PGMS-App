import 'package:flutter/material.dart';
import 'package:ly_project/Pages/DetailedComplaint/detailed_complaint.dart';
import 'package:ly_project/utils/colors.dart';

class ComplaintOverviewCard extends StatefulWidget {
  final complaint;
  final status;
  final date;
  final image;
  final location;
  final supervisor;
  ComplaintOverviewCard({this.complaint, this.date, this.status, this.image, this.location, this.supervisor});
  @override
  _ComplaintOverviewCardState createState() => _ComplaintOverviewCardState();
}

class _ComplaintOverviewCardState extends State<ComplaintOverviewCard> {
  List upvoteArray;
  // final String complaintStatus = "In Progress";

  @override
  Widget build(BuildContext context) {
    // upvoteArray = widget.upvotes;
    Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: InkWell(
          onTap: () {
            print("Tap!");
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => (DetailComplaint(
                  complaint: widget.complaint,
                  date: widget.date,
                  status: widget.date,
                  image: widget.image,
                ))));
          },
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.03, vertical: size.height * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.complaint,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 16,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.date,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                widget.status,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: COMPLAINT_STATUS_COLOR_MAP[
                                              widget.status] !=
                                          null
                                      ? COMPLAINT_STATUS_COLOR_MAP[
                                          widget.status]
                                      : Colors.deepOrange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Container(
                      height: size.height * 0.04,
                      child: FlatButton(
                        color: Colors.amber[500],
                        onPressed: () {
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=> InDetail(auth: widget.auth, helper_data_new: helper_data_new[index])));
                        },
                        child: Text('Comment',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    )
                  ],
                ),
                Container(
                  width: size.width * 0.3,
                  child: Image(
                    image: NetworkImage(widget.image),
                    fit: BoxFit.cover,
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
