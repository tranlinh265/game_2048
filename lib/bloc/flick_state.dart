import 'package:equatable/equatable.dart';
import "package:meta/meta.dart";

abstract class GameState extends Equatable {
  final List<List<int>> data;

  const GameState({this.data});

  @override
  List<Object> get props => [this.data];
}

class GameOverState extends GameState {
  const GameOverState({@required data}) : super(data : data);
}

class ReadyState extends GameState {
  const ReadyState({@required data}) : super(data: data);
}
