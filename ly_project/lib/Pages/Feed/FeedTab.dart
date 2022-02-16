import 'package:flutter/material.dart';
import 'package:ly_project/Pages/Feed/feedCard.dart';

class FeedTab extends StatelessWidget {
  const FeedTab({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          right: 20, left: 20, top: 140, bottom: 5),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 6,
        itemBuilder: (context, index) {
          return ComplaintOverviewCard();
        },
      ),
    );
  }
}
