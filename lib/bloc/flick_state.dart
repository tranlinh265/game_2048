import 'package:equatable/equatable.dart';
import "package:meta/meta.dart";

abstract class GameState extends Equatable {
  const GameState();

  @override
  List<Object> get props => null;
}

class GameOverState extends GameState {
  final List<List<int>> data;

  const GameOverState({@required this.data});
  @override
  List<Object> get props => [this.data];
}

class ReadyState extends GameState {
  final List<List<int>> data;

  const ReadyState({@required this.data});

  @override
  List<Object> get props => [this.data];
}
