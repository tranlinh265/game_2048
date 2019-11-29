import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        
        Center(
          child: Container(
            margin: EdgeInsets.only(top: 100),
            width: 300,
            height: 300,
            color: Colors.white,
            child: GestureDetector(
              onHorizontalDragEnd: (DragEndDetails details){
                if(details.velocity.pixelsPerSecond.dx > 0){
                  print("left to right");
                } else if(details.velocity.pixelsPerSecond.dx < 0){
                  print("right to left");
                }
              },
              onVerticalDragEnd: (details){
                if (details.velocity.pixelsPerSecond.dy >0){
                  print("btm to top");
                } else if (details.velocity.pixelsPerSecond.dy < 0){
                  print ("top to btm");
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}