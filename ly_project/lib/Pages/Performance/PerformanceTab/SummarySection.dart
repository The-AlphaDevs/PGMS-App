import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ly_project/utils/colors.dart';

class SummarySection extends StatelessWidget {
  final Size size;
  final String levelName, level, score, imageUrl;
  const SummarySection({ Key key, this.size, this.levelName, this.level, this.score, this.imageUrl }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
      Container(
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
                child: CachedNetworkImage(
                  fit: BoxFit.fitWidth,
                  imageUrl: imageUrl,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.01),
          Text(
            levelName,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                color: DARK_PURPLE),
          ),
          SizedBox(height: size.height * 0.008),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Level: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17)),
                    TextSpan(text: level, style: TextStyle(fontSize: 17)),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Score: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17)),
                    TextSpan(text: score, style: TextStyle(fontSize: 17)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}