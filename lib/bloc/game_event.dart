import 'package:equatable/equatable.dart';

enum Flick {
  leftToRight,
  rightToLeft,
  topToBtm,
  btmToTop,
}

abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object> get props => [];
}

class FlickRightToLeftEvent extends GameEvent {}

class FlickLeftToRightEvent extends GameEvent {}

class FlickTopToBottmEvent extends GameEvent {}

class FlickBottomToTopEvent extends GameEvent {}

class StartNewGameEvent extends GameEvent{}