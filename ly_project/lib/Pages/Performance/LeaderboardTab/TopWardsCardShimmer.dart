import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ly_project/Widgets/Shimmers.dart';
import 'package:ly_project/utils/colors.dart';

class TopWardsCardShimmer extends StatelessWidget {
  TopWardsCardShimmer({
    Key key,
    @required this.size,
    @required this.durationDdValue,
    @required this.dateFrom,
    @required this.dateTo,
  }) : super(key: key);

  final Size size;
  final String durationDdValue;
  final DateTime dateFrom;
  final DateTime dateTo;
  final BoxDecoration badgeDecoration = BoxDecoration(
      border: Border.all(color: GOLDEN_YELLOW, width: 5),
      shape: BoxShape.circle,
      color: DARK_PURPLE);
  final BoxDecoration shimmerBadgeDecoration = BoxDecoration(
    border: Border.all(color: GOLDEN_YELLOW, width: 5),
    shape: BoxShape.circle,
  );

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
                        decoration: shimmerBadgeDecoration,
                        child: TopWardShimmer(
                            height: size.width * 0.22,
                            width: size.width * 0.22,
                            baseColor: DARK_PURPLE,
                            highlightColor: SHIMMER_HIGHLIGHT_COLOR,
                            badgeDecoration: badgeDecoration)),
                    buildRankBadge(
                        radius: size.width * 0.07,
                        color: SILVER_GREY,
                        rank: "2",
                        position: -size.width * 0.029),
                    Positioned(
                      bottom: -size.width * 0.085,
                      child: CustomShimmer.rectangular(
                          height: 15,
                          width: size.width * 0.15,
                          baseColor: SHIMMER_BASE_COLOR,
                          highlightColor: SHIMMER_HIGHLIGHT_COLOR),
                    ),
                  ],
                ),
                Stack(
                  overflow: Overflow.visible,
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      decoration: shimmerBadgeDecoration,
                      child: TopWardShimmer(
                        height: size.width * 0.3,
                        width: size.width * 0.3,
                        baseColor: DARK_PURPLE,
                        highlightColor: SHIMMER_HIGHLIGHT_COLOR,
                        badgeDecoration: badgeDecoration,
                      ),
                    ),
                    buildRankBadge(
                        radius: size.width * 0.08,
                        color: GOLDEN_YELLOW,
                        rank: "1",
                        position: -size.width * 0.04),
                    Positioned(
                      bottom: -size.width * 0.09,
                      child: CustomShimmer.rectangular(
                          height: 15,
                          width: size.width * 0.15,
                          baseColor: SHIMMER_BASE_COLOR,
                          highlightColor: SHIMMER_HIGHLIGHT_COLOR),
                    ),
                  ],
                ),
                Stack(
                  overflow: Overflow.visible,
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      decoration: shimmerBadgeDecoration,
                      child: TopWardShimmer(
                          height: size.width * 0.22,
                          width: size.width * 0.22,
                          baseColor: DARK_PURPLE,
                          highlightColor: SHIMMER_HIGHLIGHT_COLOR,
                          badgeDecoration: badgeDecoration),
                    ),
                    buildRankBadge(
                        radius: size.width * 0.07,
                        color: BRONZE_BROWN,
                        rank: "3",
                        position: -size.width * 0.029),
                    Positioned(
                      bottom: -size.width * 0.085,
                      child: CustomShimmer.rectangular(
                          height: 15,
                          width: size.width * 0.15,
                          baseColor: SHIMMER_BASE_COLOR,
                          highlightColor: SHIMMER_HIGHLIGHT_COLOR),
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
