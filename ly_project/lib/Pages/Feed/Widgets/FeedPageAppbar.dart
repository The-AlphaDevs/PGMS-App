import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ly_project/Pages/Feed/notifsPage.dart';
import 'package:ly_project/Services/auth.dart';

class FeedPageAppbar extends StatefulWidget {
  FeedPageAppbar({
    Key key,
    @required this.size,
    @required this.auth,
    @required this.notificationStream,
  }) : super(key: key);
  final Size size;
  final BaseAuth auth;
  final Stream<QuerySnapshot> notificationStream;

  @override
  _FeedPageAppbarState createState() => _FeedPageAppbarState();
}

class _FeedPageAppbarState extends State<FeedPageAppbar> {
  String user;
  Stream<QuerySnapshot> notificationStream;

  @override
  void initState() {
    super.initState();
    notificationStream = widget.notificationStream;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(width: 30),
        Text('PGMS',
            style: TextStyle(
                fontSize: 25.0, color: Colors.white, fontFamily: 'Amaranth')),
        StreamBuilder(
          stream: notificationStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                  height: 30, width: 30, child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Icon(Icons.error, color: Colors.white, size: 30.0);
            }
            if (snapshot.hasData) {
              return Stack(
                children: <Widget>[
                  Positioned(
                    child: IconButton(
                      icon: Icon(Icons.notifications,
                          color: Colors.white, size: 30.0),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Notifications(auth: widget.auth),
                          ),
                        );
                      },
                    ),
                  ),
                  snapshot.data.docs.length > 0
                      ? Positioned(
                          right: widget.size.width * 0.013,
                          top: widget.size.width * 0.013,
                          child: CircleAvatar(
                            radius: widget.size.width * 0.025,
                            backgroundColor: Colors.green,
                            child: Center(
                              child: Text(
                                snapshot.data.docs.length.toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      : Text('')
                ],
              );
            }
            return Container(
                height: 30, width: 30, child: CircularProgressIndicator());
          },
        ),
      ],
    );
  }
}
