// import 'package:InstiComplaints/feedCard.dart';
// import 'loading.dart';
// import 'UpdateNotification.dart';
// import 'package:InstiComplaints/search.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ly_project/Pages/Feed/BookmarksTab.dart';

import 'package:ly_project/Pages/Feed/FeedTab.dart';
import 'package:ly_project/Pages/RaiseComplaint/raise_complaint.dart';
import 'package:ly_project/Services/auth.dart';
import 'package:ly_project/Widgets/CurveClipper.dart';

class Feed extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  Feed({Key key, this.auth, this.onSignedOut}) : super(key: key);

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  TabController _tabController;
  int selectedIndex = 0;
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);
    // ..addListener(() {
    // setState(() {
    // _tabController.index = 0;
    // });
    // });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldState,
      // drawer: NavDrawer(auth: widget.auth, onSignedOut: widget.onSignedOut),
      body: Stack(
        children: [
          //TabBarViews
          Container(
            child: TabBarView(
              controller: _tabController,
              children: [
                FeedTab(),
                BookmarksTab(),
              ],
            ),
          ),

          Container(
            child: Stack(
              children: <Widget>[
                //Shape
                Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.035,
                      color: Color(0xFF181D3D),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: ClipPath(
                          clipper: CurveClipper(),
                          child: Container(
                            color: Color(0xFF181D3D),
                          )),
                    ),
                  ],
                ),

                Column(
                  children: [
                    SizedBox(height: size.height * 0.03),
                    appBar(),
                    SizedBox(height: 10.0),

                    // Implementation of tabbar
                    Center(
                      child: Container(
                        width: 300.0,
                        height: 60,
                        child: TabBar(
                          controller: _tabController,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicator: BoxDecoration(
                            color: Color(0xFF606fad),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                            ),
                          ),
                          tabs: [
                            Tab(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(42.0, 0, 42.0, 0),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.mode_comment,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                    Text(
                                      'Feed',
                                      style: TextStyle(
                                          fontSize: 11, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Tab(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.bookmark,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                    Text(
                                      'Bookmarks',
                                      style: TextStyle(
                                          fontSize: 11, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RaiseComplaint(),
                        ),
                      );
                    },
                    backgroundColor: Color(0xFF606fad),
                    child: const Icon(Icons.add),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Row appBar() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(width: 30),
        Text(
          'PGMS',
          style: TextStyle(
            fontSize: 25.0,
            color: Colors.white,
            fontFamily: 'Amaranth',
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.search,
            color: Colors.white,
            size: 30.0,
          ),
          onPressed: () {
            // Navigator.of(context).push(MaterialPageRoute(
            //     builder: (context) => Search()));
          },
        ),
      ],
    );
  }
}

//         } else {
//           return Loading();
//         }
//       },
//     );
//   }
// }

// class Bookmarks extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection('users')
//             .doc(FirebaseAuth.instance.currentUser.uid)
//             .snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> user) {
//           if (user.connectionState == ConnectionState.waiting)
//             return Center(child: CircularProgressIndicator());

//           final List<String> bookmarks =
//               List<String>.from(user.data.data()['bookmarked']);
//           print(bookmarks.runtimeType);
//           print('\n\n\n${user.data.data()['bookmarked']}\n');
//           return StreamBuilder(
//               stream: FirebaseFirestore.instance
//                   .collection('complaints')
//                   .snapshots(),
//               builder: (BuildContext context,
//                   AsyncSnapshot<QuerySnapshot> snapshots) {
//                 if (snapshots.connectionState == ConnectionState.waiting)
//                   return Center(child: CircularProgressIndicator());

//                 List<Widget> currentBookmarks = [];
//                 snapshots.data.docs.forEach((doc) {
//                   if (bookmarks.contains(doc.id)) {
//                     currentBookmarks.add(ComplaintOverviewCard(
//                       title: doc.data()["title"],
//                       onTap: ComplaintDialog(doc.id),
//                       email: doc.data()['email'],
//                       filingTime: doc.data()['filing time'],
//                       category: doc.data()["category"],
//                       description: doc.data()["description"],
//                       status: doc.data()["status"],
//                       upvotes: doc.data()['upvotes'],
//                       id: doc.id,
//                     ));
//                   }
//                 });
//                 currentBookmarks.add(Container(
//                     padding: EdgeInsets.all(10),
//                     child: Column(
//                       children: [
//                         Icon(
//                           Icons.check_circle,
//                           size: 40,
//                           color: Color(0xFF36497E),
//                         ),
//                         Text(
//                           "You're All Caught Up",
//                           style: Theme.of(context).textTheme.headline6,
//                         )
//                       ],
//                     )));
//                 return ListView(
//                   children: currentBookmarks,
//                 );
//               });
//         });
//   }
// }
