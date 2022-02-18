import 'package:flutter/material.dart';

class Leaderboard extends StatefulWidget {
  Leaderboard({Key key}) : super(key: key);

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          right: 20, left: 20, top: 0, bottom: 0),
      child: Container(
        child: Center(
          child: Text("LeaderBoard"),
        ),
      ),
    );
  }
}