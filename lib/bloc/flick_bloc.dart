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
    var data = state.data;
    var combinedData = _gameData.combine(data, flick);

    if(_gameData.isGameOver(combinedData, data, flick)){
      yield GameOverState(data: combinedData);
      return;
    }

    combinedData = _gameData.addNewValue(data, combinedData);

    yield ReadyState(data: combinedData);
  }
}
