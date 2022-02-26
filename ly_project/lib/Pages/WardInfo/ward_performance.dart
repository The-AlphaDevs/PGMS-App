import 'package:flutter/material.dart';

class WardPerformance extends StatefulWidget {
  // WardPerformance({Key? key}) : super(key: key);

  @override
  State<WardPerformance> createState() => _WardPerformanceState();
}

class _WardPerformanceState extends State<WardPerformance> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          right: 20, left: 20, top: 0, bottom: 0),
      child: Container(
        child: Center(
          child: Text("Ward Performance"),
        ),
      ),
    );
  }
}