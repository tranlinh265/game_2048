import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_2048/bloc/bloc.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width - 48;

    return Container(
      margin: EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: Container(),
              ),
              Column(children: <Widget>[
                Text("Score"),
                FlatButton(
                  onPressed: () {},
                  child: Text("Reset"),
                )
              ])
            ],
          ),
          Expanded(
            child: GestureDetector(
              onHorizontalDragEnd: (DragEndDetails details) {
                if (details.primaryVelocity > 0) {
                  print("left to right");
                  BlocProvider.of<FlickBloc>(context).add(FlickLeftToRight());
                } else if (details.primaryVelocity < 0) {
                  print("right to left");
                  BlocProvider.of<FlickBloc>(context).add(FlickRightToLeft());
                }
              },
              onVerticalDragEnd: (details) {
                if (details.primaryVelocity > 0) {
                  print("top to btm");
                  BlocProvider.of<FlickBloc>(context).add(FlickTopToBottm());
                } else if (details.primaryVelocity < 0) {
                  print("btm to top");
                  BlocProvider.of<FlickBloc>(context).add(FlickBottomToTop());
                }
              },
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.black26,
                  ),
                  width: _width,
                  height: _width,
                  child: BlocBuilder<FlickBloc, GameState>(
                    builder: (context, state) {
                      if (state is ReadyState) {
                        return GridView.count(
                          padding: EdgeInsets.all(5.0),
                          crossAxisCount: 4,
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing: 5.0,
                          physics: NeverScrollableScrollPhysics(),
                          children: List.generate(16, (index) {
                            int value =
                                state.data[(index / 4).truncate().toInt()]
                                    [index % 4];
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: value == 0
                                    ? Colors.black12
                                    : value == 2
                                        ? Colors.black38
                                        : value == 4
                                            ? Colors.black45
                                            : value == 8
                                                ? Colors.black54
                                                : Colors.black87,
                              ),
                              child: Center(
                                child: Text(
                                  value != 0 ? '$value' : '',
                                  style: TextStyle(
                                      fontSize: 30, color: Colors.white),
                                ),
                              ),
                            );
                          }),
                        );
                      }
                      if (state is GameState) {
                        return Text("game over");
                      }
                      return Text("error");
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
