import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_2048/bloc/bloc.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Column(
      children: <Widget>[
        Container(
          height: 200,
        ),
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
                  BlocProvider.of<FlickBloc>(context).add(FlickLeftToRight());
                } else if (details.velocity.pixelsPerSecond.dx < 0) {
                  print("right to left");
                  BlocProvider.of<FlickBloc>(context).add(FlickRightToLeft());
                }
              }, onVerticalDragEnd: (details) {
                if (details.velocity.pixelsPerSecond.dy > 0) {
                  print("top to btm");
                  BlocProvider.of<FlickBloc>(context).add(FlickTopToBottm());
                } else if (details.velocity.pixelsPerSecond.dy < 0) {
                  print("btm to top");
                  BlocProvider.of<FlickBloc>(context).add(FlickBottomToTop());
                }
              }, child: BlocBuilder<FlickBloc, GameState>(
                builder: (context, state) {
                  if (state is ReadyState) {
                    return GridView.count(
                      padding: EdgeInsets.all(5.0),
                      crossAxisCount: 4,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 5.0,
                      physics: NeverScrollableScrollPhysics(),
                      children: List.generate(16, (index) {
                        int value = state.data[(index / 4).truncate().toInt()]
                            [index % 4];
                        return Container(
                          color: Colors.black,
                          child: Center(
                            child: Text(
                              value != 0 ? '$value' : '',
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white),
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
              ))),
        ),
      ],
    );
  }
}
// class GameScreen extends StatefulWidget {
//   @override
//   _GameScreenState createState() => _GameScreenState();
// }

// class _GameScreenState extends State<GameScreen> {
//   double _width;

//   @override
//   Widget build(BuildContext context) {
//     if (_width == null) {
//       _width = MediaQuery.of(context).size.width;
//     }

//     return Column(
//       children: <Widget>[
//         Container(
//           height: 200,
//         ),
//         Center(
//           child: Container(
//             padding: EdgeInsets.all(0),
//             width: _width,
//             height: _width,
//             color: Colors.white,
//             child: GestureDetector(
//               onHorizontalDragEnd: (DragEndDetails details) {
//                 if (details.velocity.pixelsPerSecond.dx > 0) {
//                   print("left to right");
//                 } else if (details.velocity.pixelsPerSecond.dx < 0) {
//                   print("right to left");
//                 }
//               },
//               onVerticalDragEnd: (details) {
//                 if (details.velocity.pixelsPerSecond.dy > 0) {
//                   print("top to btm");
//                 } else if (details.velocity.pixelsPerSecond.dy < 0) {
//                   print("btm to top");
//                 }
//               },
//               child: GridView.count(
//                 padding: EdgeInsets.all(5.0),
//                 crossAxisCount: 4,
//                 crossAxisSpacing: 5.0,
//                 mainAxisSpacing: 5.0,
//                 physics: NeverScrollableScrollPhysics(),
//                 children: List.generate(16, (index) {
//                   int value = data[(index / 4).truncate().toInt()][index % 4];
//                   return Container(
//                     color: Colors.black,
//                     child: Center(
//                       child: Text(
//                         value != 0 ? '$value' : '',
//                         style: TextStyle(fontSize: 30, color: Colors.white),
//                       ),
//                     ),
//                   );
//                 }),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
