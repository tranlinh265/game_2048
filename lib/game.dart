import 'package:flutter/material.dart';
import 'package:game_2048/game_data.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  double _width;
  List<List<int>> data = [
    [0, 0, 0, 2],
    [0, 0, 2, 0],
    [0, 0, 0, 0],
    [2, 0, 0, 0]
  ];
  GameData gameData = GameData();

  @override
  Widget build(BuildContext context) {
    if (_width == null) {
      _width = MediaQuery.of(context).size.width;
    }

    return Column(
      children: <Widget>[
        Container(height: 200,),
        Center(
          child: Container(
            padding: EdgeInsets.all(0),
            width: _width,
            height: _width,
            color: Colors.white,
            child: GestureDetector(
              onHorizontalDragEnd: (DragEndDetails details) {
                if (details.velocity.pixelsPerSecond.dx > 0) {
                  print("left to right");
                  setState(() {
                    data = gameData.caculateTableBaseOnFlick(
                        data, Flick.leftToRight);
                  });
                } else if (details.velocity.pixelsPerSecond.dx < 0) {
                  print("right to left");
                  setState(() {
                    data = gameData.caculateTableBaseOnFlick(
                        data, Flick.rightToLeft);
                  });
                }
              },
              onVerticalDragEnd: (details) {
                if (details.velocity.pixelsPerSecond.dy > 0) {
                  print("top to btm");
                  setState(() {
                    data =
                        gameData.caculateTableBaseOnFlick(data, Flick.topToBtm);
                  });
                } else if (details.velocity.pixelsPerSecond.dy < 0) {
                  print("btm to top");
                  setState(() {
                    data =
                        gameData.caculateTableBaseOnFlick(data, Flick.btmToTop);
                  });
                }
              },
              child: GridView.count(
                padding: EdgeInsets.all(5.0) ,
                crossAxisCount: 4,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
                physics: NeverScrollableScrollPhysics(),
                children: List.generate(16, (index) {
                  int value = data[(index / 4).truncate().toInt()][index % 4];
                  return Container(
                    color: Colors.black,
                    child: Center(
                      child: Text(
                        value != 0 ? '$value' : '',
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
