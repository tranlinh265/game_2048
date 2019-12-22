import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:game_2048/game_data_calculator.dart';
import './bloc.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  
  GameDataCalculator _gameDataCalculator = new GameDataCalculator();

  @override
  GameState get initialState => InitState(data: _gameDataCalculator.randomNewList());

  @override
  Stream<GameState> mapEventToState(
    GameEvent event,
  ) async* {
    if (event is FlickLeftToRightEvent) {
      yield* mapFlickEventToState(Flick.leftToRight);
    } else if (event is FlickRightToLeftEvent) {
      yield* mapFlickEventToState(Flick.rightToLeft);
    } else if (event is FlickTopToBottmEvent) {
      yield* mapFlickEventToState(Flick.topToBtm);
    } else if (event is FlickBottomToTopEvent) {
      yield* mapFlickEventToState(Flick.btmToTop);
    } else if (event is StartNewGameEvent) {
      yield* startNewGame();
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

  Stream<GameState> startNewGame() async* {
    var gameData = _gameDataCalculator.randomNewList();
    yield InitState(data: gameData);
  }
}
