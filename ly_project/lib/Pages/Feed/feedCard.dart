import 'package:flutter/material.dart';
import 'package:ly_project/Pages/DetailedComplaint/detailed_complaint.dart';
import 'package:ly_project/utils/colors.dart';

class ComplaintOverviewCard extends StatefulWidget {
  @override
  _ComplaintOverviewCardState createState() => _ComplaintOverviewCardState();
}

class _ComplaintOverviewCardState extends State<ComplaintOverviewCard> {
  List upvoteArray;
  final String complaintStatus = "In Progress";

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
                MaterialPageRoute(builder: (context) => (DetailComplaint())));
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
                      "Potholes on Road",
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
                          "10/12/2021",
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
                                complaintStatus,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: COMPLAINT_STATUS_COLOR_MAP[
                                              complaintStatus] !=
                                          null
                                      ? COMPLAINT_STATUS_COLOR_MAP[
                                          complaintStatus]
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
                  width: size.width * 0.42,
                  child: Image(
                    image: AssetImage('assets/47.jpg'),
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
