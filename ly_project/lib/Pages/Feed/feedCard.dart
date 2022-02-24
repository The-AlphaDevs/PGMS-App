import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ly_project/Pages/DetailedComplaint/detailed_complaint.dart';
import 'package:ly_project/utils/colors.dart';

class ComplaintOverviewCard extends StatefulWidget {
  final id;
  final complaint;
  final status;
  final date;
  final image;
  final location;
  final supervisor;
  final lat;
  final long;
  ComplaintOverviewCard({this.id, this.complaint, this.date, this.status, this.image, this.location, this.supervisor, this.lat, this.long});
  @override
  _ComplaintOverviewCardState createState() => _ComplaintOverviewCardState();
}

class _ComplaintOverviewCardState extends State<ComplaintOverviewCard> {
  
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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => (DetailComplaint(
                  id: widget.id,
                  complaint: widget.complaint,
                  // name: widget.name,
                  date: widget.date,
                  status: widget.status,
                  image: widget.image,
                  supervisor: widget.supervisor,
                  location: widget.location,
                  lat: widget.lat,
                  long: widget.long
                ))));
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.03, vertical: size.height * 0.01),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // crossAxisAlignment: CrossAxisAlignment.center,
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
                          size: 12,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          DateFormat.yMMMMd().format(DateTime.parse(widget.date)),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                      ],
                    ),

                    SizedBox(height: size.height*0.03),

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   // crossAxisAlignment: CrossAxisAlignment.end,
                    //   children: <Widget>[
                        
                    //   ],
                    // ),

                    // SizedBox(height: 4),
                    // Container(
                    //   height: size.height * 0.04,
                      
                    //   child: ClipRRect(
                    //     borderRadius: BorderRadius.circular(29),
                    //     child: FlatButton(
                    //       color: Colors.amber[500],
                    //       onPressed: () {
                    //         // Navigator.push(context, MaterialPageRoute(builder: (context)=> InDetail(auth: widget.auth, helper_data_new: helper_data_new[index])));
                    //       },
                    //       child: Text('Comment',
                    //           style: TextStyle(
                    //             fontSize: 12,
                    //             color: Colors.white,
                    //             fontWeight: FontWeight.bold,
                    //           )),
                    //     ),
                    //   ),
                    // )
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                          Text(
                          widget.status,
                          style: TextStyle(
                            fontSize: 13,
                            color: COMPLAINT_STATUS_COLOR_MAP[
                                        widget.status] !=
                                    null
                                ? COMPLAINT_STATUS_COLOR_MAP[
                                    widget.status]
                                : Colors.deepOrange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: size.height*0.012),
                        Text(
                              "Status",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(width: size.width*0.09),

                        Column(
                          children: [
                            GestureDetector(
                              onTap:(){
                                print("Upvote!");
                              },
                              child: Icon(
                                Icons.arrow_upward_outlined,
                              ),
                            ),
                            SizedBox(height: size.height*0.01),
                            Text(
                              "Upvote",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  width: size.width * 0.35,
                  height: size.height * 0.15,
                  child: Image(
                    image: NetworkImage(widget.image),
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
