import 'package:flutter/material.dart';


class CommentsCard extends StatefulWidget {
  final photo;
  final name;
  final comment;

  
  CommentsCard({this.photo, this.name, this.comment});
  @override
  _CommentsCardState createState() => _CommentsCardState();
}

class _CommentsCardState extends State<CommentsCard> {
  
  @override
  Widget build(BuildContext context) {
    
    Size size = MediaQuery.of(context).size;
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          radius: size.width * 0.03,
          // backgroundImage:NetworkImage(widget.photo),
        ),
        title: Text(widget.name),
        subtitle: Text(
          widget.comment,
        ),
        isThreeLine: true,
      ),
    );
  }
}
