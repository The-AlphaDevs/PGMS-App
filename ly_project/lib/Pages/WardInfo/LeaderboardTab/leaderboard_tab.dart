import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ly_project/Services/LeaderboardServices.dart';
import 'package:ly_project/utils/constants.dart';
import 'package:ly_project/Pages/WardInfo/TopWardsCard.dart';
import 'package:ly_project/Pages/WardInfo/LeaderboardTab/LeaderboardTable.dart';

class Leaderboard extends StatefulWidget {
  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard>
    with AutomaticKeepAliveClientMixin<Leaderboard> {
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
    super.build(context);
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.04, vertical: size.height * 0.025),
        child: Column(children: [
          buildDurationDropdown(),
          SizedBox(height: size.height * 0.04),
          StreamBuilder(
              stream:
                  LeaderboardServices.getWardScores(duration: durationDdValue),
              builder: (ctxt, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: Container(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2.0)));
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Something went wrong!"),
                  );
                }
                if (snapshot.hasData && snapshot.data != null) {
                  List<Map<String, String>> performanceData =
                      LeaderboardServices.formatScores(
                          duration: durationDdValue,
                          wardList: snapshot.data.docs);
                  return Column(children: [
                    TopWardsCard(
                      size: size,
                      durationDdValue: durationDdValue,
                      dateFrom: dateFrom,
                      dateTo: dateTo,
                      firstWard: performanceData[0]["Ward"],
                      secondWard: performanceData[1]["Ward"],
                      thirdWard: performanceData[2]["Ward"],
                      firstWardPoints: performanceData[0]["Points"],
                      secondWardPoints: performanceData[1]["Points"],
                      thirdWardPoints: performanceData[2]["Points"],
                    ),
                    SizedBox(height: size.height * 0.04),
                    LeaderboardTable(
                        size: size,
                        headerTexstyle: headerTexstyle,
                        performanceData: performanceData),
                  ]);
                }
                return Container(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2.0));
              }),
        ]),
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

  @override
  bool get wantKeepAlive => true;
}
