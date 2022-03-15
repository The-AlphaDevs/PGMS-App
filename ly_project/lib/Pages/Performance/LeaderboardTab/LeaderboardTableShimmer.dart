import 'package:flutter/material.dart';
import 'package:ly_project/Widgets/Shimmers.dart';
import 'package:ly_project/utils/colors.dart';
import 'package:ly_project/utils/constants.dart';

class LeaderboardTableShimmer extends StatelessWidget {
  const LeaderboardTableShimmer(
      {Key key, @required this.size, @required this.headerTexstyle})
      : super(key: key);

  final Size size;
  final TextStyle headerTexstyle;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.blue[300],
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8))),
            padding: EdgeInsets.symmetric(
                vertical: size.height * 0.005, horizontal: 5),
            child: Row(
              children: [
                Container(
                    width: size.width * 0.14,
                    child: Text("Rank", style: headerTexstyle)),
                Container(
                    width: size.width * 0.31,
                    child: Text("Ward", style: headerTexstyle)),
                Container(
                    width: size.width * 0.3,
                    child: Text("Locality", style: headerTexstyle)),
                Container(child: Text("Points", style: headerTexstyle)),
              ],
            ),
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: WARDS.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                  color: index % 2 == 0 ? Colors.white : Colors.blue[100],
                  borderRadius: index != WARDS.length - 1
                      ? BorderRadius.zero
                      : BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8)),
                ),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: size.width * 0.01),
                      width: size.width * 0.1,
                      child: CustomShimmer.rectangular(
                        height: 13,
                        baseColor: SHIMMER_BASE_COLOR,
                        highlightColor: SHIMMER_HIGHLIGHT_COLOR,
                        width: 5,
                      ),
                    ),
                    SizedBox(width: 15),
                    Container(
                      width: size.width * 0.22,
                      child: CustomShimmer.rectangular(
                        height: 13,
                        baseColor: SHIMMER_BASE_COLOR,
                        highlightColor: SHIMMER_HIGHLIGHT_COLOR,
                        width: 5
                      ),
                    ),
                    SizedBox(width: 35),
                    Container(
                      width: size.width * 0.22,
                      child: CustomShimmer.rectangular(
                        height: 13,
                        baseColor: SHIMMER_BASE_COLOR,
                        highlightColor: SHIMMER_HIGHLIGHT_COLOR,
                        width: 5,
                      ),
                    ),
                    SizedBox(width: 35),
                    Container(
                      width: size.width * 0.05,
                      child: CustomShimmer.rectangular(
                        height: 13,
                        baseColor: SHIMMER_BASE_COLOR,
                        highlightColor: SHIMMER_HIGHLIGHT_COLOR,
                        width: 20,
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
