import 'package:flutter/material.dart';
import 'package:game_2048/game.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_2048/bloc/bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => FlickBloc(),
        child: GameScreen(),
      ),
    );
  }
}
