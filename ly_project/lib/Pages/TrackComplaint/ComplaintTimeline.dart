import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

class ComplaintTimeline extends StatefulWidget {
  final id;
  final status;

  ComplaintTimeline({this.id, this.status});
  @override
  State<ComplaintTimeline> createState() => _ComplaintTimelineState();
}

class _ComplaintTimelineState extends State<ComplaintTimeline> {
  
  String pendingBoxColor;
  String inProgressBoxColor;
  String resolvedBoxColor;

  @override
  void initState() {
    super.initState();
    if(widget.status=="Pending"){
      pendingBoxColor = "green";
      inProgressBoxColor = "red";
      resolvedBoxColor = "red";

    } 
    else if(widget.status=="In Progress"){
      pendingBoxColor = "green";
      inProgressBoxColor = "green";
      resolvedBoxColor = "red";
    }
    else{
      pendingBoxColor = "green";
      inProgressBoxColor = "green";
      resolvedBoxColor = "green";
    }
  }

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
              if(index==0){
                return dotIndicator(pendingBoxColor);
              }
              else if(index==1){
                return dotIndicator(inProgressBoxColor);
              }
              else{
                return dotIndicator(resolvedBoxColor);
              }
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
              if(index==0){
                return timelineTile(context, "Pending", "Description", pendingBoxColor);
              }
              else if(index==1){
                return timelineTile(context, "In Progress", "Description", inProgressBoxColor);
              }
              else{
                return timelineTile(context, "Resolved", "Description", resolvedBoxColor);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget dotIndicator(color){
    IconData boxIcon;
    if(color=="green"){
      boxIcon = Icons.check;
    }
    else{
      boxIcon = Icons.circle;
    }
    return DotIndicator(
      color: Color(0xff6ad192),
      child: Icon(
        boxIcon,
        color: Colors.white,
        size: 15.0,
      ),
    );
  }

  Widget timelineTile(context, title, description, color){
    Size size = MediaQuery.of(context).size;
    Color boxColor;
    if(color=="green"){
      boxColor = Colors.green[100];
    }
    else{
      boxColor = Colors.red[100];
    }
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Card(
          elevation: 6,
          color: boxColor,
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
                        title,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      SizedBox(height: size.height*0.04),
                      // SizedBox(height: 5),
                      Text(
                        description,
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
  }
}
