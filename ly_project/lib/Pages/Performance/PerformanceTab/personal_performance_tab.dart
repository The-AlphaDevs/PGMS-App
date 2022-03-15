import 'package:flutter/material.dart';
import 'package:ly_project/Pages/Performance/PerformanceTab/DonutChart.dart';
import 'package:ly_project/Pages/Performance/PerformanceTab/Shimmers/ShimmerScorecard.dart';
import 'package:ly_project/Pages/Performance/PerformanceTab/StatsCard.dart';
import 'package:ly_project/Pages/Performance/PerformanceTab/SummarySection.dart';
import 'package:ly_project/Services/PerformanceServices.dart';
import 'package:ly_project/utils/colors.dart';
import 'package:ly_project/utils/constants.dart';

class PersonalPerformance extends StatefulWidget {
  PersonalPerformance({Key key}) : super(key: key);

  @override
  State<PersonalPerformance> createState() => _PersonalPerformanceState();
}

class _PersonalPerformanceState extends State<PersonalPerformance>
    with AutomaticKeepAliveClientMixin<PersonalPerformance> {
  String email = "dummysupervisor@gmail.com";
  @override
  Widget build(BuildContext context) {
    super.build(context);
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: size.width * 0.04, vertical: size.height * 0.015),
        child: Card(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.018),
            color: Colors.grey[50],
            child: Column(
              children: [
                buildHeader(size),
                SizedBox(height: size.height * 0.008),
                FutureBuilder(
                  future:
                      PerformanceServices.getPersonalPerformance(email: email),
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return ShimmerScorecard(size: size);
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Something went wrong!"),
                      );
                    }
                    if (snapshot.hasData) {
                      final data = snapshot.data;
                      
                      int score = data["score"];
                      String imageUrl = data["imageUrl"].toString();
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
                          PerformanceServices.getLevelInfo(score);
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
                            imageUrl: imageUrl
                          ),
                          SizedBox(height: size.height * 0.02),
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
                              SizedBox(height: size.height * 0.02),
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
                          SizedBox(height: size.height * 0.02),
                          Divider(),
                          SizedBox(height: size.height * 0.02),
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
            style: TextStyle(fontFamily: "Times New Roman", fontSize: 24)),
        Divider(thickness: 1),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
