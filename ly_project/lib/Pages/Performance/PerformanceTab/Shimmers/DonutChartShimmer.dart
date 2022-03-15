import 'package:flutter/material.dart';
import 'package:ly_project/Widgets/Shimmers.dart';
import 'package:ly_project/utils/colors.dart';

class DonutChartShimmer extends StatelessWidget {
  final Size size;
  const DonutChartShimmer({Key key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: size.width * 0.5,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomShimmer.circular(
                      height: size.height * 0.25,
                      width: size.height * 0.25,
                      baseColor: SHIMMER_BASE_COLOR,
                      highlightColor: SHIMMER_HIGHLIGHT_COLOR),
                  Container(
                      height: (size.height * 0.25 - 35),
                      width: (size.height * 0.25 - 35),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white))
                ],
              ),
            ),
            Container(
              width: size.width * 0.2,
              child: Column(
                children: [
                  CustomShimmer.rectangular(
                      height: 15,
                      baseColor: SHIMMER_BASE_COLOR,
                      highlightColor: SHIMMER_HIGHLIGHT_COLOR),
                  SizedBox(height: 8),
                  CustomShimmer.rectangular(
                      height: 15,
                      baseColor: SHIMMER_BASE_COLOR,
                      highlightColor: SHIMMER_HIGHLIGHT_COLOR),
                  SizedBox(height: 8),
                  CustomShimmer.rectangular(
                      height: 15,
                      baseColor: SHIMMER_BASE_COLOR,
                      highlightColor: SHIMMER_HIGHLIGHT_COLOR),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
