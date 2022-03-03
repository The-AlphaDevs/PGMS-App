import 'package:flutter/material.dart';
import 'package:ly_project/utils/constants.dart';
import 'package:ly_project/Pages/WardInfo/TopWardsCard.dart';
import 'package:ly_project/Pages/WardInfo/LeaderboardTab/LeaderboardTable.dart';

class Leaderboard extends StatefulWidget {
  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  String durationDdValue = LEADERBOARD_DURATIONS[0];
  DateTime dateFrom, dateTo;

  @override
  void initState() {
    super.initState();
    var now = DateTime.now();
    dateFrom = DateTime(now.year, now.month, now.day);
    dateTo = now;
  }

  updateDuration() {
    final now = DateTime.now();
    switch (durationDdValue) {
      case "Today":
        DateTime today = DateTime(now.year, now.month, now.day);
        dateFrom = today;
        dateTo = now;
        break;
      case "This Week":
        // From https://stackoverflow.com/a/62872997/13365850

        var weekDay = now.weekday;

        // Week begins on Monday
        final nearestMonday = now.subtract(Duration(days: weekDay));
        dateFrom = DateTime(
            nearestMonday.year, nearestMonday.month, nearestMonday.day);
        dateTo = DateTime.now();
        break;
      case "This Month":
        DateTime firstDayOfTheMonth = DateTime(now.year, now.month, 1);
        dateFrom = firstDayOfTheMonth;
        dateTo = now;
        break;
      case "This Year":
        DateTime firstDayOfTheMonth = DateTime(now.year, 1, 1);
        dateFrom = firstDayOfTheMonth;
        dateTo = now;
        break;
      case "All Time":
        dateFrom = DateTime(2000, 1, 1);
        dateTo = now;
        break;
      default:
        {
          DateTime today = DateTime(now.year, now.month, now.day);
          dateFrom = today;
          dateTo = now;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.04, vertical: size.height * 0.025),
        child: Column(
          children: [
            buildDurationDropdown(),
            SizedBox(height: size.height * 0.04),
            TopWardsCard(
              size: size,
              durationDdValue: durationDdValue,
              dateFrom: dateFrom,
              dateTo: dateTo,
              firstWard: dummyPerformanceData[0]["Ward"],
              secondWard: dummyPerformanceData[1]["Ward"],
              thirdWard: dummyPerformanceData[2]["Ward"],
              firstWardPoints: dummyPerformanceData[0]["Points"],
              secondWardPoints: dummyPerformanceData[1]["Points"],
              thirdWardPoints: dummyPerformanceData[2]["Points"],
            ),
            SizedBox(height: size.height * 0.04),
            LeaderboardTable(size: size, headerTexstyle: headerTexstyle),
          ],
        ),
      ),
    );
  }

  Container buildDurationDropdown() {
    return Container(
      child: DropdownButtonFormField(
        hint: Text("Select Duration"),
        style: TextStyle(color: Colors.deepPurple),
        iconSize: 16,
        icon: Icon(Icons.arrow_downward),
        decoration: textFormFieldDecoration("Duration", null),
        value: durationDdValue,
        onChanged: (String newValue) {
          setState(() {
            durationDdValue = newValue;
            updateDuration();
          });
        },
        items:
            LEADERBOARD_DURATIONS.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              softWrap: true,
            ),
          );
        }).toList(),
      ),
    );
  }

  TextStyle headerTexstyle = TextStyle(fontWeight: FontWeight.bold);

  InputDecoration textFormFieldDecoration(String lbl, IconData icon) {
    return InputDecoration(
      isDense: true,
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
