import 'package:flutter/material.dart';
import 'package:ly_project/Widgets/Shimmers.dart';
import 'package:ly_project/utils/colors.dart';

class StatsCardShimmer extends StatelessWidget {
  StatsCardShimmer({Key key, this.size}) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.38,
      height: size.height * 0.18,
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
                child:
                    //Title
                    Column(
                  children: [
                    CustomShimmer.rectangular(
                        width: 65,
                        height: 16,
                        baseColor: SHIMMER_BASE_COLOR,
                        highlightColor: SHIMMER_HIGHLIGHT_COLOR),
                    SizedBox(height: 4),
                    CustomShimmer.rectangular(
                        width: 65,
                        height: 16,
                        baseColor: SHIMMER_BASE_COLOR,
                        highlightColor: SHIMMER_HIGHLIGHT_COLOR),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.01),

              //Count
              CustomShimmer.rectangular(
                  width: 50,
                  height: 22,
                  baseColor: SHIMMER_BASE_COLOR,
                  highlightColor: SHIMMER_HIGHLIGHT_COLOR),

              SizedBox(height: size.height * 0.025),

              //Points
              CustomShimmer.rectangular(
                  width: 70,
                  height: 14,
                  baseColor: SHIMMER_BASE_COLOR,
                  highlightColor: SHIMMER_HIGHLIGHT_COLOR),
            ],
          ),
        ),
      ),
    );
  }
}
