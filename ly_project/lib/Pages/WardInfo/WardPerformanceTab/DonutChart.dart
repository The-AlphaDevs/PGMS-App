import 'package:flutter/material.dart';
import 'package:ly_project/Utils/colors.dart';
import 'package:pie_chart/pie_chart.dart';

class DonutChart extends StatelessWidget {
  const DonutChart({
    Key key,
    @required this.dataMap,
  }) : super(key: key);

  final Map<String, double> dataMap;

  @override
  Widget build(BuildContext context) {
    return PieChart(
        dataMap: dataMap,
        animationDuration: Duration(milliseconds: 800),
        chartLegendSpacing: 32,
        chartRadius:
            MediaQuery.of(context).size.width / 2.5,
        colorList: donutChartColorList,
        initialAngleInDegree: 90, /// Avoid the intereference of lables with center text
        chartType: ChartType.ring,
        ringStrokeWidth: 12,
        centerText: "Complaints",
        legendOptions: LegendOptions(
          showLegendsInRow: false,
          legendPosition: LegendPosition.right,
          showLegends: true,
          legendShape: BoxShape.circle,
          legendTextStyle: TextStyle(
            fontSize: 12,
            height: 1.5,
            fontWeight: FontWeight.bold,
            decorationColor: Colors.blue,
            decorationThickness: 2,
          ),
        ),
        chartValuesOptions: ChartValuesOptions(
          showChartValueBackground: true,
          showChartValues: true,
          showChartValuesInPercentage: false,
          showChartValuesOutside: false,
          decimalPlaces: 0,
        ),
      );
  }
}
