import 'package:flutter/material.dart';
import 'package:ly_project/utils/constants.dart';

class Leaderboard extends StatefulWidget {
  Leaderboard({Key key}) : super(key: key);

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  String wardDdValue = WARDS[0];
  String durationDdValue = LEADERBOARD_DURATIONS[0];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 10),
      child: SingleChildScrollView(
        
        child: Column(
          children: [
            Column(
              
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField(
                  
                  icon: Icon(Icons.arrow_downward),
                  decoration: textFormFieldDecoration("Ward", null),
                  value: wardDdValue,
                  onChanged: (String newValue) {
                    setState(() {
                      wardDdValue = newValue;
                    });
                  },
                  items: WARDS.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                DropdownButtonFormField(
                  icon: Icon(Icons.arrow_downward),
                  decoration: textFormFieldDecoration("Duration", null),
                  value: durationDdValue,
                  onChanged: (String newValue) {
                    setState(() {
                      durationDdValue = newValue;
                    });
                  },
                  items: LEADERBOARD_DURATIONS
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Text("LeaderBoard"),
          ],
        ),
      ),
    );
  }

  InputDecoration textFormFieldDecoration(String lbl, IconData icon) {
    return InputDecoration(
      labelText: lbl,
      suffixIcon: icon != null ? Icon(icon) : null,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: BorderSide(color: Colors.blueGrey),
      ),
    );
  }
}
