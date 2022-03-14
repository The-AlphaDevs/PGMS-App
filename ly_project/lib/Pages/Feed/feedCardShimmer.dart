import 'package:flutter/material.dart';
import 'package:ly_project/Widgets/Shimmers.dart';
import 'package:ly_project/utils/colors.dart';

class ComplaintOverviewCardShimmer extends StatelessWidget {
  ComplaintOverviewCardShimmer(this.size);
  final Size size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          padding: EdgeInsets.fromLTRB(size.width * 0.01, size.height * 0.01,
              size.width * 0.01, size.height * 0.005),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Complaint
                    CustomShimmer.rectangular(
                      height: 15,
                      baseColor: SHIMMER_BASE_COLOR,
                      highlightColor: SHIMMER_HIGHLIGHT_COLOR,
                      width: size.width * 0.4,
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),

                    //Posted By:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //Icon
                        CustomShimmer.rectangular(
                          height: 12,
                          baseColor: SHIMMER_BASE_COLOR,
                          highlightColor: SHIMMER_HIGHLIGHT_COLOR,
                          width: 12,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        //Email Id
                        CustomShimmer.rectangular(
                          height: 11,
                          baseColor: SHIMMER_BASE_COLOR,
                          highlightColor: SHIMMER_HIGHLIGHT_COLOR,
                          width: size.width * 0.25,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    //DateTime
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Icon
                        CustomShimmer.rectangular(
                          height: 10,
                          baseColor: SHIMMER_BASE_COLOR,
                          highlightColor: SHIMMER_HIGHLIGHT_COLOR,
                          width: 10,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        //Date and Time
                        CustomShimmer.rectangular(
                          height: 10,
                          baseColor: SHIMMER_BASE_COLOR,
                          highlightColor: SHIMMER_HIGHLIGHT_COLOR,
                          width: size.width * 0.2,
                        )
                      ],
                    ),

                    SizedBox(height: size.height * 0.01),

                    //Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //Status
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: size.height * 0.005),
                            //Complaint Status
                            CustomShimmer.rectangular(
                              height: 11,
                              baseColor: SHIMMER_BASE_COLOR,
                              highlightColor: SHIMMER_HIGHLIGHT_COLOR,
                              width: size.width * 0.12,
                            ),
                            SizedBox(height: size.height * 0.008),
                            // Status Text
                            CustomShimmer.rectangular(
                              height: 10,
                              baseColor: SHIMMER_BASE_COLOR,
                              highlightColor: SHIMMER_HIGHLIGHT_COLOR,
                              width: size.width * 0.09,
                            ),
                          ],
                        ),
                        SizedBox(width: size.width * 0.02),

                        //Upvote
                        Column(
                          children: [
                            SizedBox(height: size.height * 0.005),
                            //Upvote button
                            CustomShimmer.rectangular(
                              height: 18,
                              baseColor: SHIMMER_BASE_COLOR,
                              highlightColor: SHIMMER_HIGHLIGHT_COLOR,
                              width: 18,
                            ),
                            SizedBox(height: size.height * 0.008),
                            //Upvote text and count
                            CustomShimmer.rectangular(
                              height: 10,
                              baseColor: SHIMMER_BASE_COLOR,
                              highlightColor: SHIMMER_HIGHLIGHT_COLOR,
                              width: size.width * 0.15,
                            ),
                          ],
                        ),
                        SizedBox(width: size.width * 0.02),
                        CustomShimmer.rectangular(
                          height: 30,
                          baseColor: SHIMMER_BASE_COLOR,
                          highlightColor: SHIMMER_HIGHLIGHT_COLOR,
                          width: 30,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              //Image
              Container(
                width: size.width * 0.35,
                height: size.height * 0.15,
                child: CustomShimmer.rectangular(
                  height: 11,
                  baseColor: SHIMMER_BASE_COLOR,
                  highlightColor: SHIMMER_HIGHLIGHT_COLOR,
                  width: size.width * 0.15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
