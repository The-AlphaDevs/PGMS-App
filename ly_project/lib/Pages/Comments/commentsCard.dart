import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ly_project/utils/colors.dart';

class CommentsCard extends StatefulWidget {
  final photo;
  final name;
  final comment;

  CommentsCard({this.photo, this.name, this.comment});
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
        title: Text(
          widget.name,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        subtitle: InkWell(
          onTap: () {
            print("Tap");
            setState(() => isExpanded = !isExpanded);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isExpanded
                    ? widget.comment 
                    : widget.comment.toString().substring(0, 100) + (showOrHideReadMore ? "..." : ""),
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height:3),
              Text(
                isExpanded
                    ? (showOrHideReadMore ? "collapse" : "")
                    : 
                        (showOrHideReadMore ? "read more" : ""),
                style: TextStyle(fontSize: 13, color: Colors.blue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
