import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

class ComplaintTimeline extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int itemCount = 3;

    bool isEdgeIndex(int index) {
      return index == 0 || index == itemCount - 2;
    }

    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Timeline.tileBuilder(
          // padding: EdgeInsets.symmetric(vertical: 5.0),
          theme: TimelineThemeData(
            nodePosition: 0,
            connectorTheme: ConnectorThemeData(
              thickness: 3.0,
              color: Color(0xffd3d3d3),
            ),
            indicatorTheme: IndicatorThemeData(
              size: 15.0,
            ),
          ),
          builder: TimelineTileBuilder.connected(
            itemCount: itemCount ,
            // itemExtentBuilder: (_, __) => 50,
            indicatorBuilder: (_, index) {
              return DotIndicator(
                color: Color(0xff6ad192),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 15.0,
                ),
              );
            },

            contentsAlign: ContentsAlign.basic,
            connectorBuilder: (_, index, __) {
              if (isEdgeIndex(index)) {
                return SolidLineConnector(color: Color(0xff6ad192));
              } else {
                return SolidLineConnector();
              }
            },
            contentsBuilder: (context, index) {
              // if (isEdgeIndex(index)) {
              //   return null;
              // }
              return SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Card(
                    elevation: 6,
                    color: Colors.green[100],
                    child: Container(
                      padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: size.width * 0.035,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Title",
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey),
                                ),
                                SizedBox(height: size.height*0.04),
                                // SizedBox(height: 5),
                                Text(
                                  "Description",
                                  maxLines: 3,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
