import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ly_project/utils/colors.dart';

class TopWardsCard extends StatelessWidget {
  TopWardsCard({
    Key key,
    @required this.size,
    @required this.durationDdValue,
    @required this.dateFrom,
    @required this.dateTo,
    @required this.firstWard,
    @required this.secondWard,
    @required this.thirdWard,
    @required this.firstWardPoints,
    @required this.secondWardPoints,
    @required this.thirdWardPoints,
  }) : super(key: key);

  final Size size;
  final String durationDdValue;
  final DateTime dateFrom;
  final DateTime dateTo;
  final String firstWard;
  final String secondWard;
  final String thirdWard;
  final String firstWardPoints;
  final String secondWardPoints;
  final String thirdWardPoints;
  final BoxDecoration badgeDecoration = BoxDecoration(
      border: Border.all(color: GOLDEN_YELLOW, width: 5),
      shape: BoxShape.circle,
      color: DARK_PURPLE);

  bool isWardNameSimple(String name) =>
      name.replaceAll("Ward ", "").split(" ").length == 1;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          SizedBox(height: size.height * 0.02),
          Text(
            "Top Wards",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: size.height * 0.01),
          durationDdValue != "All Time"
              ? durationDdValue == "Today"
                  ? Center(
                      child: Text(
                        DateFormat.yMMMd().format(dateFrom),
                      ),
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
          SizedBox(height: size.height * 0.01),
          Container(
            padding: EdgeInsets.only(bottom: size.width * 0.12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Stack(
                  overflow: Overflow.visible,
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      height: size.width * 0.22,
                      width: size.width * 0.22,
                      child: buildWardName(rank: "2", wardName: secondWard),
                      decoration: badgeDecoration,
                    ),
                    buildRankBadge(
                        radius: size.width * 0.07,
                        color: SILVER_GREY,
                        rank: "2",
                        position: -size.width * 0.029),
                    Positioned(
                      bottom: -size.width * 0.085,
                      child: Text("$secondWardPoints Points"),
                    ),
                  ],
                ),
                Stack(
                  overflow: Overflow.visible,
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      height: size.width * 0.3,
                      width: size.width * 0.3,
                      child: buildWardName(rank: "1", wardName: firstWard),
                      decoration: badgeDecoration,
                    ),
                    buildRankBadge(
                        radius: size.width * 0.08,
                        color: GOLDEN_YELLOW,
                        rank: "1",
                        position: -size.width * 0.04),
                    Positioned(
                      bottom: -size.width * 0.09,
                      child: Text("$firstWardPoints Points"),
                    ),
                  ],
                ),
                Stack(
                  overflow: Overflow.visible,
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      height: size.width * 0.22,
                      width: size.width * 0.22,
                      child: buildWardName(rank: "3", wardName: thirdWard),
                      decoration: badgeDecoration,
                    ),
                    buildRankBadge(
                        radius: size.width * 0.07,
                        color: BRONZE_BROWN,
                        rank: "3",
                        position: -size.width * 0.029),
                    Positioned(
                      bottom: -size.width * 0.085,
                      child: Text("$thirdWardPoints Points"),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.01),
        ],
      ),
    );
  }

  Widget buildWardName({
    @required String wardName,
    @required String rank,
  }) {
    return Center(
      child: isWardNameSimple(wardName)
          ? Text(
              wardName.replaceAll("Ward ", ""),
              softWrap: true,
              style: TextStyle(
                fontSize: rank == "1" ? 30 : 20,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  wardName.replaceAll("Ward ", "").split(" ")[0],
                  softWrap: true,
                  style: TextStyle(
                    fontSize: rank == "1" ? 30 : 20,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  wardName.replaceAll("Ward ", "").split(" ")[1],
                  softWrap: true,
                  style: TextStyle(
                    fontSize: rank == "1" ? 20 : 16,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
    );
  }

  Positioned buildRankBadge(
      {@required double radius,
      @required Color color,
      @required String rank,
      @required double position}) {
    return Positioned(
      bottom: position,
      child: Container(
        width: radius,
        height: radius,
        child: Center(
          child: Text(
            rank,
            style: TextStyle(color: DARK_PURPLE, fontWeight: FontWeight.w700),
          ),
        ),
        decoration: BoxDecoration(
          border: Border.all(color: DARK_PURPLE, width: 3),
          shape: BoxShape.circle,
          color: color,
        ),
      ),
    );
  }
}
