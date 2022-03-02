import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Contains helper methods for processing the ward performance data
class WardInfoServices {

  /// Get the complaints of a particular [`ward`] submitted between [`dateFrom`] and [`dateTo`], both inclusive.
  static Future<QuerySnapshot> getWardPrformance({
    @required String ward,
    @required String dateFrom,
    @required String dateTo,
  }) {
    return FirebaseFirestore.instance
        .collection("complaints")
        .where("ward", isEqualTo: ward)
        .where("dateTime", isGreaterThanOrEqualTo: dateFrom)
        .where("dateTime", isLessThanOrEqualTo: dateTo)
        .orderBy("dateTime", descending: true)
        .get();
  }


  /// Returns a map containing statistics of the ward performance. 
  /// Key string is the metric and value string is the correponding value
  /// 
  static Map<String, String> processPerformanceData(
      List<DocumentSnapshot> docs) {

    //Default values
    Map<String, String> data = {
      "No. of complaints": "0",
      "Solved complaints": "0",
      "In progress complaints": "0",
      "Pending complaints": "0",
      "Completion Rate": "0",
      "Fastest Completion": "-",
      "Slowest Completion": "-"
    };

    //No documents found
    if (docs == null || docs.length == 0) {
      return data;
    }

    int pending = 0, inProgress = 0, closed = 0, none = 0, total = 0;
    double completionRate;
    DateTime complaintDate, resolutionDate;
    Duration minDuration = Duration(minutes: 1000000);
    Duration maxDuration = Duration(minutes: 0);

    docs.forEach((doc) {
      String status = doc["status"];

      //Check the status of the complaint
      switch (status) {
        case "Pending":
          pending++;
          break;
        case "In Progress":
          inProgress++;
          break;
        case "Closed":
          closed++;

          //If the complaint is closed / resolved, its resolution time can be compared with 
          // complaint registration time to get the complaint resolution duration.
          complaintDate = DateTime.parse(doc["dateTime"]);
          resolutionDate = DateTime.parse(doc["resolutionDateTime"]);

          if (resolutionDate != null && complaintDate != null) {

            // difference is the difference between complaintDate & resolutionDate
            // in Duration(minutes).
            Duration difference = getDifferenceDuration(
                complaintDate: complaintDate, resolutionDate: resolutionDate);

            // If duration of difference is shorter than minDuration, returns < 0.
            if (difference.compareTo(minDuration) <= 0) {
              minDuration = difference;
            }
            if (difference.compareTo(maxDuration) >= 0) {
              maxDuration = difference;
            }
          }
          break;
        default:
          none++;
      }
    });

    total = docs.length;
    completionRate = closed * 100 / total;

    data["No. of complaints"] = total.toString();
    data["Solved complaints"] = closed.toString();
    data["In progress complaints"] = inProgress.toString();
    data["Pending complaints"] = pending.toString();
    data["Completion Rate"] = completionRate.toStringAsFixed(2) + " %";
    data["Fastest Completion"] = formatDuration(minDuration);
    data["Slowest Completion"] = formatDuration(maxDuration);

    return data;
  }


  /// Gets the difference between complaintDate & resolutionDate
  /// in Duration(minutes).
  static Duration getDifferenceDuration(
      {@required DateTime resolutionDate, @required DateTime complaintDate}) {
    int differenceInMinutes =
        resolutionDate.difference(complaintDate).inMinutes;
    print("differenceInMinutes");
    print(differenceInMinutes);
    final difference = Duration(minutes: differenceInMinutes);

    return difference;
  }

  /// Formats the duration for pretty printing
  static String formatDuration(Duration durationInMinutes) {
    // Refer: https://stackoverflow.com/a/67709153/13365850
    // and
    // https://stackoverflow.com/a/71266668/13365850

    if (durationInMinutes == null) return "";

    final zero = DateTime(0, 0, 0, 0, 0, 0);
    // DateTime now = DateTime.now();
    DateTime duration = DateTime(zero.year)
        .add(durationInMinutes)
        .subtract(const Duration(days: 1));

    // Helps in handling singular and plural words dependent 
    // upon a value

    datePluralHandler(int n, String unit) => Intl.plural(
          n,
          zero: '',
          one: '$n $unit',
          other: '$n ${unit}s',
          name: "timeunits",
          args: [n],
        );
    
    String res = (duration.year > 0
            ? datePluralHandler(duration.year, 'Years')
            : '') +
        (duration.month - 1 > 0
            ? " " + datePluralHandler(duration.month - 1, 'Months')
            : '') +
        (duration.day > 0 ? " " + datePluralHandler(duration.day, 'Day') : '') +
        (duration.hour > 0
            ? " " + datePluralHandler(duration.hour, 'Hour')
            : '') +
        (duration.minute > 0
            ? " " + datePluralHandler(duration.minute, 'Minute')
            : '');
    return res;
  }

  static Map<String, double> getDonutChartDataMap(
      Map<String, String> performanceData) {
    return {
      "Solved\nComplaints": double.parse(performanceData["Solved complaints"]),
      "In progress\nComplaints": double.parse(performanceData["In progress complaints"]),
      "Pending\nComplaints": double.parse(performanceData["Pending complaints"]),
    };
  }
}
