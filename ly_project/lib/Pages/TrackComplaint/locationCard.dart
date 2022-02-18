import 'package:flutter/material.dart';

class ComplaintCard extends StatelessWidget {
  final String statuss = "In Progress";
  ComplaintCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(25.0),
      child: Card(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.03,
              vertical: size.height * 0.02,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: size.width * 0.42,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Potholes on Road",
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.calendar_today),
                          // SizedBox(
                          //   width: 5,
                          // ),
                          Text(
                            "10/12/2021",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),

                      SizedBox(height: 10),
                      //   Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //     crossAxisAlignment: CrossAxisAlignment.end,
                      //     children: <Widget>[
                      //     Center(
                      //       child: Column(
                      //         mainAxisAlignment: MainAxisAlignment.end,
                      //         crossAxisAlignment: CrossAxisAlignment.center,
                      //         children: <Widget>[
                      //           Text(statuss,
                      //               style: TextStyle(
                      //                 fontSize: 16,
                      //                 color: statuss == 'Rejected'
                      //                     ? Colors.red
                      //                     : statuss == 'Solved'
                      //                         ? Colors.green
                      //                         : statuss == 'In Progress'
                      //                             ? Colors.blue
                      //                             : statuss == 'Passed'
                      //                                 ? Colors.cyan
                      //                                 : Colors.deepOrange,
                      //                 fontWeight: FontWeight.bold,
                      //               )),
                      //           // SizedBox(
                      //           //   height: 8,
                      //           // ),
                      //           Text(
                      //             'Status',
                      //             overflow: TextOverflow.ellipsis,
                      //             style: TextStyle(
                      //               fontSize: 13,
                      //               ),
                      //               textAlign: TextAlign.center,
                      //             ),
                      //           ],
                      //         ),
                      //       ),

                      //   ],
                      // ),

                      Flexible(
                        flex: 10,
                        // fit: FlexFit.tight,
                        child: Text(
                          "Narasimha Chintaman Kelkar Road, Dadar West, Mumbai - 400030",
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),

                      SizedBox(
                        height: 5,
                      ),

                      Text(
                        "Posted 5 days ago",
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: size.width * 0.42,
                  child: Image(
                    image: AssetImage('assets/loc.jpg'),
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
          )),
    );
  }
}
