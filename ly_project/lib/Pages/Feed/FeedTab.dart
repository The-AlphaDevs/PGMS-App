import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ly_project/Pages/Feed/cardListContainer.dart';
// import 'package:ly_project/Pages/Feed/feedCard.dart';
import 'package:ly_project/Pages/Feed/feedCardShimmer.dart';
import 'package:ly_project/Services/FeedServices.dart';
import 'package:ly_project/Services/auth.dart';
import 'package:uuid/uuid.dart';

class FeedTab extends StatefulWidget {
  final BaseAuth auth;
  final Stream<QuerySnapshot> complaintStream;

  FeedTab({this.auth, this.complaintStream});

  @override
  State<FeedTab> createState() => _FeedTabState();
}

class _FeedTabState extends State<FeedTab>
    with AutomaticKeepAliveClientMixin<FeedTab> {
  Stream<QuerySnapshot> complaintStream;
  final uuid = Uuid();

  @override
  void initState() {
    complaintStream = widget.complaintStream;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.fromLTRB(10, size.height * 0.2, 10, 20),
      child: StreamBuilder(
        stream: complaintStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView.builder(
                itemCount: 5,
                padding: EdgeInsets.only(left: 10, right: 10),
                shrinkWrap: true,
                key: new Key(uuid.v4()),
                itemBuilder: (context, index) =>
                    ComplaintOverviewCardShimmer(size));
          }

          if (snapshot.hasError) {
            return Card(child: Center(child: Text("Something went wrong!")));
          }
          if (!snapshot.hasData) {
            print("Connection state: has no data");
            return Column(
              children: [
                SizedBox(
                  height: size.height * 0.2,
                ),
                CircularProgressIndicator(),
              ],
            );
          } else {
            if (snapshot.data.docs.length == 0)
              return Center(child: Text("No Past Feeds"));

            return CardListContainer(auth: widget.auth, snapshot: snapshot);
          }
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
