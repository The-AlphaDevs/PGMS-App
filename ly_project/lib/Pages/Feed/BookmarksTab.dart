import 'package:flutter/material.dart';

class BookmarksTab extends StatefulWidget {
  const BookmarksTab({
    Key key,
  }) : super(key: key);

  @override
  _BookmarksTabState createState() => _BookmarksTabState();
}

class _BookmarksTabState extends State<BookmarksTab>
    with AutomaticKeepAliveClientMixin<BookmarksTab> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20, top: 150, bottom: 0),
      child: Container(
        child: Center(
          child: Text("Bookmarks"),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
