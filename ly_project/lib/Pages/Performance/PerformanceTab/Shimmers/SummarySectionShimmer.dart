import 'package:flutter/material.dart';
import 'package:ly_project/Widgets/Shimmers.dart';
import 'package:ly_project/utils/colors.dart';

class SummarySectionShimmer extends StatelessWidget {
  final Size size;

  const SummarySectionShimmer({Key key, this.size}) : super(key: key);

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
                child: CustomShimmer.circular(
                    height: size.width * 0.11,
                    width: size.width * 0.11,
                    baseColor: SHIMMER_BASE_COLOR,
                    highlightColor: SHIMMER_HIGHLIGHT_COLOR),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.01),
          // LevelName
          CustomShimmer.rectangular(
              width: 50,
              height: 18,
              baseColor: SHIMMER_BASE_COLOR,
              highlightColor: SHIMMER_HIGHLIGHT_COLOR),

          SizedBox(height: size.height * 0.008),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomShimmer.rectangular(
                  width: 50,
                  height: 17,
                  baseColor: SHIMMER_BASE_COLOR,
                  highlightColor: SHIMMER_HIGHLIGHT_COLOR),
              CustomShimmer.rectangular(
                  width: 50,
                  height: 17,
                  baseColor: SHIMMER_BASE_COLOR,
                  highlightColor: SHIMMER_HIGHLIGHT_COLOR),
            ],
          ),
        ],
      ),
    );
  }
}
