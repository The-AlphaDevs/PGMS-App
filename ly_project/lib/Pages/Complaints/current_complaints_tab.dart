import 'package:flutter/material.dart';

class CurrentComplaintsTab extends StatefulWidget {
  // CurrentComplaintsTab({Key? key}) : super(key: key);

  @override
  State<CurrentComplaintsTab> createState() => _CurrentComplaintsTabState();
}

class _CurrentComplaintsTabState extends State<CurrentComplaintsTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          right: 20, left: 20, top: 0, bottom: 0),
      child: Container(
        child: Center(
          child: Text("Ongoing Complaints"),
        ),
      ),
    );
  }
}