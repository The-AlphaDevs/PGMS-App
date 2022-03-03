import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
          radius: size.width * 0.04,
          // backgroundImage: 
          child: CachedNetworkImage(
                imageUrl: widget.photo,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
        title: Text(widget.name, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        subtitle: Text(
          widget.comment,
          style: TextStyle(fontSize:15)
        ),
      ),
    );
  }
}
