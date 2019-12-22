import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:game_2048/game_data_calculator.dart';
import './bloc.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  
  GameDataCalculator _gameDataCalculator = new GameDataCalculator();

  @override
  GameState get initialState => ReadyState(data: _gameDataCalculator.randomNewList());

  @override
  Stream<GameState> mapEventToState(
    GameEvent event,
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
    var combinedData = _gameDataCalculator.combine(data, flick);

    if(_gameDataCalculator.isGameOver(combinedData, data, flick)){
      yield GameOverState(data: combinedData);
      return;
    }

    combinedData = _gameDataCalculator.addNewValue(data, combinedData);

    yield ReadyState(data: combinedData);
  }
}
