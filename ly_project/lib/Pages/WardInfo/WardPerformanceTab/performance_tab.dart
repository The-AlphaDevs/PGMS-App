import 'package:flutter/material.dart';
import 'package:ly_project/Pages/WardInfo/WardPerformanceTab/AdministratorDetailsCard.dart';
import 'package:ly_project/Pages/WardInfo/WardPerformanceTab/PerformanceStatsCard.dart';
import 'package:ly_project/utils/constants.dart';

class WardPerformance extends StatefulWidget {
  WardPerformance({Key key}) : super(key: key);

  @override
  State<WardPerformance> createState() => _WardPerformanceState();
}

class _WardPerformanceState extends State<WardPerformance> with AutomaticKeepAliveClientMixin<WardPerformance> {
  String wardDdValue = WARDS[0];
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
          horizontal: 20,
          vertical: size.height * 0.025,
        ),
        child: Column(
          children: [
            buildDropdowns(size),
            SizedBox(height: size.height * 0.04),
            PerformanceStatsCard(size: size, durationDdValue: durationDdValue, dateFrom: dateFrom, dateTo: dateTo, wardDdValue: wardDdValue),
            AdministratorDetailsCard(size: size, wardDdValue: wardDdValue)
          ],
        ),
      ),
    );
  }


  Row buildDropdowns(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: size.width * 0.4,
          child: DropdownButtonFormField(
            hint: Text("Select Ward"),
            style: TextStyle(color: Colors.deepPurple),
            iconSize: 16,
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
                child: Text(
                  value,
                  softWrap: true,
                ),
              );
            }).toList(),
          ),
        ),
        Container(
          width: size.width * 0.45,
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
            items: LEADERBOARD_DURATIONS
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

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
