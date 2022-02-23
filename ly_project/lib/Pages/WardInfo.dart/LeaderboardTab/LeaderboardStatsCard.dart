import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LeaderboardStatsCard extends StatelessWidget {
  const LeaderboardStatsCard({
    Key key,
    @required this.size,
    @required this.durationDdValue,
    @required this.dateFrom,
    @required this.dateTo,
    @required this.wardDdValue,
  }) : super(key: key);

  final Size size;
  final DateTime dateFrom;
  final DateTime dateTo;
  final String durationDdValue;
  final String wardDdValue;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          SizedBox(height: size.height * 0.02),
          Text(
            "Leaderboard",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: size.height * 0.01),
          durationDdValue != "All Time"
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(DateFormat.yMMMd().format(dateFrom)),
                      Icon(Icons.arrow_forward, size: 16),
                      Text(DateFormat.yMMMd().format(dateTo)),
                    ],
                  ),
                )
              : Center(child: Text("All Time")),
          Divider(thickness: 1.25),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            color: Colors.grey[50],
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.015,
                    vertical: size.height * 0.004),
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    border: Border.all(
                      color: Colors.blueGrey[400],
                    ),
                    borderRadius: BorderRadius.circular(12)),
                child: buildStatsTable()),
          ),
        ],
      ),
    );
  }

  Column buildStatsTable() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("No. of complaints"),
              Text("5600"),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Solved complaints"),
              Text("5600"),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Pending"),
              Text("5600"),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Completion Rate"),
              Text("5600"),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Fastest Completion"),
              Text("5600"),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Slowest Completion"),
              Text("5600"),
            ],
          ),
        ),
      ],
    );
  }
}
