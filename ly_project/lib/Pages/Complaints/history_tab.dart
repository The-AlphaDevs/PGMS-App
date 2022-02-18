import 'package:flutter/material.dart';

class ComplaintsHistoryTab extends StatefulWidget {
  ComplaintsHistoryTab({Key key}) : super(key: key);

  @override
  State<ComplaintsHistoryTab> createState() => _ComplaintsHistoryTabState();
}

class _ComplaintsHistoryTabState extends State<ComplaintsHistoryTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          right: 20, left: 20, top: 0, bottom: 0),
      child: Container(
        child: Center(
          child: Text("Complaints History"),
        ),
      ),
    );
  }
}