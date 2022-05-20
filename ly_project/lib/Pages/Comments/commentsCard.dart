import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ly_project/utils/colors.dart';
import 'package:intl/intl.dart';

class CommentsCard extends StatefulWidget {
  final photo;
  final name;
  final comment;
  final timestamp;

  CommentsCard({this.photo, this.name, this.comment, this.timestamp});
  @override
  _CommentsCardState createState() => _CommentsCardState();
}

class _CommentsCardState extends State<CommentsCard> {
  bool isExpanded;
  bool showOrHideReadMore;

  @override
  void initState() {
    super.initState();
    isExpanded = widget.comment.length < 100;
    showOrHideReadMore = widget.comment.length >= 100;
    print("isExpanded: " + isExpanded.toString());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Card(
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
              border: Border.all(color: DARK_BLUE),
              borderRadius: BorderRadius.circular(60.0)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(60.0),
            child: CachedNetworkImage(
              imageUrl: widget.photo,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
              width: size.width * 0.12,
              height: size.width * 0.12,
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.name,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Text(
                DateFormat.yMMMMd().format(DateTime.parse(widget.timestamp)),
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: Colors.grey),
              ),
          ],
        ),
        subtitle: InkWell(
          onTap: () {
            print("Tap");
            setState(() => isExpanded = !isExpanded);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height:size.height*0.001),
              Text(
                // isExpanded
                widget.comment,
                    // : widget.comment.toString().substring(0, 100) + (showOrHideReadMore ? "..." : ""),
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              SizedBox(height:size.height*0.001),
              Text(
                isExpanded
                    ? (showOrHideReadMore ? "collapse" : "")
                    : 
                        (showOrHideReadMore ? "read more" : ""),
                style: TextStyle(fontSize: 13, color: Colors.blue),
              ),
              SizedBox(height:size.height*0.0005),
              // Text(
                
              //   DateFormat.yMMMMd().format(DateTime.parse(widget.timestamp)),
              //   style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: Colors.grey),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
