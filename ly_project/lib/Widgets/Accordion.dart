import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Accordion extends StatefulWidget {
  final String title;
  final String image;

  const Accordion({Key key, @required this.title, @required this.image})
      : super(key: key);
  @override
  _AccordionState createState() => _AccordionState();
}

class _AccordionState extends State<Accordion> {
  bool _showImage = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0),
      decoration: BoxDecoration(border: Border.all()),
        margin: const EdgeInsets.only(right:15),
      child: Column(children: [
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.symmetric(horizontal:8, vertical:0),
          title: Text(widget.title, style: TextStyle(fontSize: 15, color: Colors.black54),),
          trailing: IconButton(
            icon: Icon(
                _showImage ? Icons.arrow_drop_up : Icons.arrow_drop_down),
            onPressed: () {
              setState(() {
                _showImage = !_showImage;
              });
            },
          ),
        ),
        _showImage
            ? Container(
              padding: EdgeInsets.only(bottom:6, right:6, left: 6),
              child: CachedNetworkImage(
                            imageUrl: widget.image,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                          ),
            )
            : Container()
      ]),
    );
  }
}