import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AdministratorDetailsCard extends StatelessWidget {
  const AdministratorDetailsCard({
    Key key,
    @required this.size,
    @required this.wardDdValue,
  }) : super(key: key);

  final Size size;
  final String wardDdValue;

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
          Divider(
            
          ),
          Container(
            color: Colors.grey[100],
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.04, vertical: size.height * 0.008),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Administrator Name",
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text("Corporator, $wardDdValue"),
                  ],
                ),
                Container(
                  width: size.width * 0.24,
                  height: size.height * 0.12,
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: CachedNetworkImage(
                        width: size.width * 0.18,
                        height: size.height * 0.09,
                        imageUrl: "http://placebeard.it/640",
                        fit: BoxFit.fitHeight,
                      ),
                    ),
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
