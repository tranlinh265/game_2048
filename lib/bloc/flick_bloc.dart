import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:game_2048/game_data.dart';
import './bloc.dart';

class FlickBloc extends Bloc<FlickEvent, GameState> {
  
  GameData _gameData = new GameData();

  @override
  GameState get initialState => ReadyState(data: _gameData.randomNewList());

  @override
  Stream<GameState> mapEventToState(
    FlickEvent event,
  ) async* {
    if (event is FlickLeftToRight) {
      yield* mapFlickEventToState(Flick.leftToRight);
    } else if (event is FlickRightToLeft) {
      yield* mapFlickEventToState(Flick.rightToLeft);
    } else if (event is FlickTopToBottm) {
      yield* mapFlickEventToState(Flick.topToBtm);
    } else if (event is FlickBottomToTop) {
      yield* mapFlickEventToState(Flick.btmToTop);
    }
  }

  Stream<GameState> mapFlickEventToState(Flick flick) async* {
    var data = state.props[0];
    data = _gameData.caculateTableBaseOnFlick(data, flick);
    yield ReadyState(data: data);
  }
}
