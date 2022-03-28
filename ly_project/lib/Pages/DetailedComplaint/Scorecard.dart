import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ly_project/Pages/DetailedComplaint/Shimmers/ShimmerScorecard.dart';
import 'package:ly_project/Services/SupScorecardServices.dart';
import 'package:ly_project/utils/colors.dart';
import 'package:ly_project/utils/constants.dart';
import 'package:pie_chart/pie_chart.dart';

class SupervisorScorecard extends StatefulWidget {
  SupervisorScorecard({Key key, this.supervisorDocRef}) : super(key: key);
  final DocumentReference supervisorDocRef;
  @override
  State<SupervisorScorecard> createState() => _SupervisorScorecardState();
}

class _SupervisorScorecardState extends State<SupervisorScorecard> {
  DocumentReference supervisorDocRef;

  @override
  void initState() {
    super.initState();
    supervisorDocRef = widget.supervisorDocRef;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Container(
        child: Card(
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: size.height * 0.01, horizontal: size.width * 0.04),
            color: Colors.grey[50],
            child: Column(
              children: [
                buildHeader(size),
                SizedBox(height: size.height * 0.008),
                FutureBuilder(
                  future: SupScorecardServices.getSupervisorPerformance(
                      supervisorDocRef: supervisorDocRef),
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return ShimmerScorecard(size: size);
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text("Something went wrong!"));
                    }
                    if (snapshot.hasData) {
                      final data = snapshot.data;

                      int score = data["score"];
                      String imageUrl = data["imageUrl"].toString();
                      String supervisorName = data["name"].toString();
                      int complaintsAssigned = data["complaintsAssigned"];

                      int complaintsCompleted = data["complaintsCompleted"];
                      int complaintsCompletionPoints =
                          complaintsCompleted * COMPLETION_POINTS;
                      int complaintsResolved = data["complaintsResolved"];
                      int complaintsResolutionPoints =
                          complaintsResolved * RESOLUTION_POINTS;
                      int complaintsOverdue = data["complaintsOverdue"];
                      int complaintsOverduePoints =
                          complaintsOverdue * OVERDUE_POINTS;

                      Map<String, String> levelInfo =
                          SupScorecardServices.getLevelInfo(score);
                      String levelName = levelInfo["levelName"];
                      String level = levelInfo["level"];

                      int complaintsTotal = complaintsAssigned +
                          complaintsCompleted +
                          complaintsResolved +
                          complaintsOverdue;
                      int totalPoints = complaintsCompletionPoints +
                          complaintsResolutionPoints +
                          complaintsOverduePoints;

                      return Column(
                        children: [
                          SummarySection(
                            size: size,
                            levelName: levelName,
                            level: level,
                            score: score.toString(),
                            imageUrl: imageUrl,
                            supervisorName: supervisorName,
                          ),
                          SizedBox(height: size.height * 0.015),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  StatsCard(
                                      size: size,
                                      title: "Resolved Complaints",
                                      count: complaintsResolved.toString(),
                                      points:
                                          "+ $complaintsResolutionPoints points",
                                      pointsColor: Colors.green),
                                  StatsCard(
                                      size: size,
                                      title: "Completed Complaints",
                                      count: complaintsCompleted.toString(),
                                      points:
                                          "+ $complaintsCompletionPoints points",
                                      pointsColor: Colors.green),
                                ],
                              ),
                              SizedBox(height: size.height * 0.01),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  StatsCard(
                                      size: size,
                                      title: "Overdue Complaints",
                                      count: complaintsOverdue.toString(),
                                      points:
                                          "-$complaintsOverduePoints points",
                                      pointsColor: Colors.red),
                                  StatsCard(
                                      size: size,
                                      title: "Total Complaints",
                                      count: complaintsTotal.toString(),
                                      points: "+ $totalPoints points",
                                      pointsColor: DARK_BLUE),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * 0.01),
                          Divider(),
                          SizedBox(height: size.height * 0.01),
                          Column(
                            children: [
                              Text(
                                "Stats",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              DonutChart(
                                dataMap: {
                                  "Completed":
                                      complaintsCompleted.floorToDouble(),
                                  "Resolved":
                                      complaintsResolved.floorToDouble(),
                                  "Overdue": complaintsOverdue.floorToDouble(),
                                },
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                    return ShimmerScorecard(size: size);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column buildHeader(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Scorecard",
            style: TextStyle(fontFamily: "Times New Roman", fontSize: 22)),
        Divider(thickness: 1),
      ],
    );
  }
}

class SummarySection extends StatelessWidget {
  final Size size;
  final String levelName, level, score, imageUrl, supervisorName;
  const SummarySection({
    Key key,
    @required this.size,
    @required this.levelName,
    @required this.level,
    @required this.score,
    @required this.imageUrl,
    @required this.supervisorName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
      padding: EdgeInsets.symmetric(vertical: size.height * 0.012),
      decoration: BoxDecoration(
        border: Border.all(color: DARK_BLUE),
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            Colors.green[50],
            Colors.purple[50],
            Colors.amber[50],
            Colors.blue[50],
          ],
        ),
      ),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.black,
            radius: size.width * 0.12,
            child: CircleAvatar(
              radius: size.width * 0.11,
              backgroundColor: Colors.white,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(200),
                child: CachedNetworkImage(
                  fit: BoxFit.fitWidth,
                  imageUrl: imageUrl,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.01),
          Text(
            supervisorName,
            style: TextStyle(
                fontSize: 17, fontWeight: FontWeight.bold, color: DARK_PURPLE),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: size.height * 0.015),
          Text(
            levelName,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                color: DARK_PURPLE),
          ),
          SizedBox(height: size.height * 0.008),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Level: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14)),
                    TextSpan(text: level, style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Score: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14)),
                    TextSpan(text: score, style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class StatsCard extends StatelessWidget {
  StatsCard(
      {Key key,
      this.size,
      this.title,
      this.count,
      this.points,
      this.pointsColor})
      : super(key: key);

  final Size size;
  final String title, count, points;
  final Color pointsColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.32,
      height: size.height * 0.16,
      child: Card(
        shadowColor: DARK_BLUE,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white, Colors.grey[50]],
              ),
              border: Border.all(color: DARK_PURPLE),
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(title,
                      style: TextStyle(fontSize: 16, color: Colors.grey[900]),
                      textAlign: TextAlign.center)),
              SizedBox(height: size.height * 0.01),
              Text(count, style: TextStyle(fontSize: 20)),
              SizedBox(height: size.height * 0.02),
              Text(points, style: TextStyle(color: pointsColor)),
            ],
          ),
        ),
      ),
    );
  }
}

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
      chartRadius: MediaQuery.of(context).size.width / 2.5,
      colorList: donutChartColorList,
      initialAngleInDegree: 90,
      chartType: ChartType.ring,
      ringStrokeWidth: 12,
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
