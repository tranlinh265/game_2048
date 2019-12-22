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

class FlickRightToLeft extends GameEvent {}

class FlickLeftToRight extends GameEvent {}

class FlickTopToBottm extends GameEvent {}

class FlickBottomToTop extends GameEvent {}
