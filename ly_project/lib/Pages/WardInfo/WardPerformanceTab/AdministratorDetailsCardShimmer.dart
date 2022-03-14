import 'package:flutter/material.dart';
import 'package:ly_project/Widgets/Shimmers.dart';
import 'package:ly_project/utils/colors.dart';

class AdministratorDetailsCardShimmer extends StatelessWidget {
  const AdministratorDetailsCardShimmer({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          SizedBox(height: size.height * 0.02),
          Text(
            "Administrator Details",
            style: TextStyle(fontSize: 20),
          ),
          Divider(),
          Container(
            color: Colors.grey[100],
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.04, vertical: size.height * 0.008),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomShimmer.rectangular(
                      height: 16,
                      baseColor: SHIMMER_BASE_COLOR,
                      highlightColor: SHIMMER_HIGHLIGHT_COLOR,
                      width: size.width * 0.4,
                    ),
                    SizedBox(height: size.height * 0.01),
                    CustomShimmer.rectangular(
                      height: 16,
                      baseColor: SHIMMER_BASE_COLOR,
                      highlightColor: SHIMMER_HIGHLIGHT_COLOR,
                      width: size.width * 0.2,
                    ),
                  ],
                ),
                Container(
                  width: size.width * 0.24,
                  height: size.height * 0.12,
                  child: Center(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: CustomShimmer.rectangular(
                            height: size.height * 0.10,
                            width: size.width * 0.22,
                            baseColor: SHIMMER_BASE_COLOR,
                            highlightColor: SHIMMER_HIGHLIGHT_COLOR)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
