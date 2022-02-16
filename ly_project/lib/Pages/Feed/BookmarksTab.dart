import 'package:flutter/material.dart';

class BookmarksTab extends StatelessWidget {
  const BookmarksTab({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          right: 20, left: 20, top: 150, bottom: 0),
      child: Container(
        child: Center(
          child: Text("Bookmarks"),
        ),
      ),
    );
  }
}