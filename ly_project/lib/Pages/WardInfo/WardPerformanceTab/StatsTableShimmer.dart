import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ly_project/Widgets/Shimmers.dart';
import 'package:ly_project/utils/colors.dart';

class StatsTableShimmer extends StatelessWidget {
  const StatsTableShimmer(this.size);
  final Size size;

  @override
  Widget build(context) {
    return Container(
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
          child: Column(
            children: shimmerBuilder(),
          ),
        ),
      ),
    );
  }

  List<Widget> shimmerBuilder() {
    List<Widget> shimmerRows = [];
    for (var i = 0; i < 7; ++i) {
      shimmerRows.add(
        Padding(
          padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomShimmer.rectangular(
                width: size.width * 0.35,
                height: 15,
                baseColor: SHIMMER_BASE_COLOR,
                highlightColor: SHIMMER_HIGHLIGHT_COLOR,
              ),
              CustomShimmer.rectangular(
                width: size.width * 0.1,
                height: 15,
                baseColor: SHIMMER_BASE_COLOR,
                highlightColor: SHIMMER_HIGHLIGHT_COLOR,
              ),
            ],
          ),
        ),
      );
    }
    return shimmerRows;
  }
}
