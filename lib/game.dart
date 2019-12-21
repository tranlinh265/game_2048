import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_2048/bloc/bloc.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width - 48;
    bool _isDraging = false;

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
          Container(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onHorizontalDragUpdate: (details) {
                if (!_isDraging) {
                  _isDraging = true;
                  if (details.primaryDelta > 0) {
                    print("left to right");
                    BlocProvider.of<FlickBloc>(context).add(FlickLeftToRight());
                  } else {
                    print("right to left");
                    BlocProvider.of<FlickBloc>(context).add(FlickRightToLeft());
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
                    BlocProvider.of<FlickBloc>(context).add(FlickTopToBottm());
                  } else {
                    print("btm to top");
                    BlocProvider.of<FlickBloc>(context).add(FlickBottomToTop());
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
                  child: BlocBuilder<FlickBloc, GameState>(
                    builder: (context, state) {
                      if (state is ReadyState) {
                        return GridView.count(
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
                        );
                      }
                      if (state is GameOverState) {
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
