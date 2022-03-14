import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ly_project/Pages/WardInfo/WardPerformanceTab/DonutChart.dart';
import 'package:ly_project/Pages/WardInfo/WardPerformanceTab/StatsTableShimmer.dart';
import 'package:ly_project/Services/WardInfoServices.dart';

class PerformanceStatsCard extends StatelessWidget {
  const PerformanceStatsCard({
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

          /// Heading
          Text("Performance", style: TextStyle(fontSize: 20)),
          SizedBox(height: size.height * 0.01),

          /// Duration / Date Range
          durationDdValue != "All Time"
              ? durationDdValue == "Today"
                  ? Center(
                      child: Text(DateFormat.yMMMd().format(dateFrom)),
                    )
                  : Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.12),
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

          /// Get data of the selected ward for selected duration
          FutureBuilder(
            future: WardInfoServices.getWardPrformance(
              ward: wardDdValue,
              dateFrom: dateFrom.toString(),
              dateTo: dateTo.toString(),
            ),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return StatsTableShimmer(size);
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text("Something went wrong"),
                );
              }
              if (snapshot.hasData) {
                /// Process the data to show in the chart
                Map<String, String> performanceData =
                    WardInfoServices.processPerformanceData(snapshot.data.docs);

                /// Get data to be shown in the donut chart
                Map<String, double> dataMap =
                    WardInfoServices.getDonutChartDataMap(performanceData);

                return tableWrapper(
                    Column(
                      children: [
                        /// Display the statistics in rows
                        buildStatsTable(performanceData),

                        /// Display the donut chart when data is available
                        snapshot.data.docs.length > 0
                            ? Column(
                                children: [
                                  Divider(thickness: 1.51),
                                  DonutChart(dataMap: dataMap),
                                ],
                              )
                            : SizedBox()
                      ],
                    ),
                    size);
              }
              return StatsTableShimmer(size);
            },
          ),
        ],
      ),
    );
  }

  Container tableWrapper(Widget child, Size size) => Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      color: Colors.grey[50],
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        color: Colors.grey[50],
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: size.width * 0.04),
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.015, vertical: size.height * 0.004),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            border: Border.all(
              color: Colors.blueGrey[400],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: child,
        ),
      ));

  Column buildStatsTable(Map<String, String> performanceData) {
    List<Widget> rows = [];

    /// Create a row for each metric to be shown
    performanceData.forEach(
      (key, value) => rows.add(
        Padding(
          padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(key.toString()),
              Container(
                width: size.width * 0.3,
                child: Text(value.toString(),
                    textAlign: TextAlign.end, softWrap: true),
              ),
            ],
          ),
        ),
      ),
    );
    return Column(children: rows);
  }
}
