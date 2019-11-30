import 'package:equatable/equatable.dart';

enum Flick {
  leftToRight,
  rightToLeft,
  topToBtm,
  btmToTop,
}

abstract class FlickEvent extends Equatable {
  const FlickEvent();

  @override
  List<Object> get props => [];
}

class FlickRightToLeft extends FlickEvent {}

class FlickLeftToRight extends FlickEvent {}

class FlickTopToBottm extends FlickEvent {}

class FlickBottomToTop extends FlickEvent {}
