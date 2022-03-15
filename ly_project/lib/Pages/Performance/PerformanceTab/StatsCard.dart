import 'package:flutter/material.dart';
import 'package:ly_project/utils/colors.dart';

class StatsCard extends StatelessWidget {
  StatsCard(
      {Key key,
      this.size,
      this.title,
      this.count,
      this.points,
      this.pointsColor})
      : super(key: key);

  final Size size;
  final String title, count, points;
  final Color pointsColor;

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
                child: Text(title,
                    style: TextStyle(fontSize: 16, color: Colors.grey[900]),
                    textAlign: TextAlign.center)
              ),
              SizedBox(height: size.height * 0.01),
              Text(count, style: TextStyle(fontSize: 22)),
              SizedBox(height: size.height * 0.025),
              Text(points, style: TextStyle(color: pointsColor)),
            ],
          ),
        ),
      ),
    );
  }
}
