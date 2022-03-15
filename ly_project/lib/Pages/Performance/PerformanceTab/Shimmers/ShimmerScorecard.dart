import 'package:flutter/material.dart';
import 'package:ly_project/Pages/Performance/PerformanceTab/Shimmers/DonutChartShimmer.dart';
import 'package:ly_project/Pages/Performance/PerformanceTab/Shimmers/StatsCardShimmer.dart';
import 'package:ly_project/Pages/Performance/PerformanceTab/Shimmers/SummarySectionShimmer.dart';

class ShimmerScorecard extends StatelessWidget {
  final Size size;
  const ShimmerScorecard({Key key, @required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SummarySectionShimmer(size: size),
        SizedBox(height: size.height * 0.02),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StatsCardShimmer(size: size),
                StatsCardShimmer(size: size),
              ],
            ),
            SizedBox(height: size.height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StatsCardShimmer(size: size),
                StatsCardShimmer(size: size),
              ],
            ),
          ],
        ),
        SizedBox(height: size.height * 0.02),
        Divider(),
        SizedBox(height: size.height * 0.02),
        Column(
          children: [
            Text("Stats",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            DonutChartShimmer(size: size),
          ],
        ),
      ],
    );
  }
}
