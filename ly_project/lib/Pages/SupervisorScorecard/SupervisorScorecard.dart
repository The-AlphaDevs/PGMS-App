import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ly_project/Pages/SupervisorScorecard/DonutChart.dart';
import 'package:ly_project/Pages/SupervisorScorecard/Shimmers/ShimmerScorecard.dart';
import 'package:ly_project/Pages/SupervisorScorecard/StatsCard.dart';
import 'package:ly_project/Pages/SupervisorScorecard/SummarySection.dart';
import 'package:ly_project/Services/SupScorecardServices.dart';
import 'package:ly_project/utils/colors.dart';
import 'package:ly_project/utils/constants.dart';

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
