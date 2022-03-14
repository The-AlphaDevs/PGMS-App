// Inspired by https://medium.flutterdevs.com/explore-shimmer-animation-effect-in-flutter-7b0e46a9c722

import 'package:flutter/material.dart';
import 'package:ly_project/utils/colors.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;
  final Color baseColor;
  final Color highlightColor;

  CustomShimmer.rectangular({
    this.width = double.infinity,
    @required this.height,
    @required this.baseColor,
    @required this.highlightColor,
  }) : this.shapeBorder = const RoundedRectangleBorder();

  CustomShimmer.circular({
    this.width = double.infinity,
    this.shapeBorder = const CircleBorder(),
    @required this.height,
    @required this.baseColor,
    @required this.highlightColor,
  });

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        period: Duration(seconds: 2),
        child: Container(
          width: width,
          height: height,
          decoration:
              ShapeDecoration(color: Colors.grey[400], shape: shapeBorder),
        ),
      );
}

class TopWardShimmer extends StatelessWidget {
  final double width;
  final double height;
  final Color baseColor;
  final Color highlightColor;
  final BoxDecoration badgeDecoration;

  TopWardShimmer({
    @required this.width,
    @required this.height,
    @required this.baseColor,
    @required this.highlightColor,
    this.badgeDecoration,
  });

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        period: Duration(milliseconds: 150),
        child: Container(
          width: width - 8,
          height: height - 10,
          child: CustomShimmer.circular(
            height: 20,
            baseColor: SHIMMER_BASE_COLOR,
            highlightColor: SHIMMER_HIGHLIGHT_COLOR,
          ),
        ),
      );
}
