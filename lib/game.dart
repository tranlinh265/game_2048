import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_2048/bloc/bloc.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width - 48;
    bool _isDraging = false;

    return BlocListener<GameBloc, GameState>(
      listener: (context, state) {
        if (state is InitState) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('Start New Game'),
            ),
          );
        }
      },
      child: Container(
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
                    onPressed: () {
                      BlocProvider.of<GameBloc>(context)
                          .add(StartNewGameEvent());
                    },
                    child: Text("Reset"),
                  )
                ])
              ],
            ),
            Container(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onHorizontalDragUpdate: (details) {
                  if (!_isDraging) {
                    _isDraging = true;
                    if (details.primaryDelta > 0) {
                      print("left to right");
                      BlocProvider.of<GameBloc>(context)
                          .add(FlickLeftToRightEvent());
                    } else {
                      print("right to left");
                      BlocProvider.of<GameBloc>(context)
                          .add(FlickRightToLeftEvent());
                    }
                  }
                },
                onHorizontalDragCancel: () {
                  _isDraging = false;
                },
                onHorizontalDragDown: (detail) {
                  _isDraging = false;
                },
                onHorizontalDragEnd: (details) {
                  _isDraging = false;
                },
                onVerticalDragUpdate: (detail) {
                  if (!_isDraging) {
                    _isDraging = true;
                    if (detail.primaryDelta > 0) {
                      print("top to btm");
                      BlocProvider.of<GameBloc>(context)
                          .add(FlickTopToBottmEvent());
                    } else {
                      print("btm to top");
                      BlocProvider.of<GameBloc>(context)
                          .add(FlickBottomToTopEvent());
                    }
                  }
                },
                onVerticalDragCancel: () {
                  _isDraging = false;
                },
                onVerticalDragDown: (detail) {
                  _isDraging = false;
                },
                onVerticalDragEnd: (details) {
                  _isDraging = false;
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
                    child: BlocBuilder<GameBloc, GameState>(
                      builder: (context, state) {
                        return Stack(
                          children: [
                            GridView.count(
                              padding: EdgeInsets.all(5.0),
                              crossAxisCount: 4,
                              crossAxisSpacing: 5.0,
                              mainAxisSpacing: 5.0,
                              primary: false,
                              // physics: NeverScrollableScrollPhysics(),
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
                            ),
                            state is GameOverState
                                ? Container(
                                    width: _width,
                                    height: _width,
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            "Game Over",
                                            style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.white,
                                            ),
                                          ),
                                          FlatButton(
                                              child: Text(
                                                "Reset",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              onPressed: () {
                                                BlocProvider.of<GameBloc>(
                                                        context)
                                                    .add(StartNewGameEvent());
                                              }),
                                        ],
                                      ),
                                    ),
                                    color: Colors.black12,
                                  )
                                : SizedBox(),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
