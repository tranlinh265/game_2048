import 'package:game_2048/game_data.dart';
import 'package:test/test.dart';

void main() {
  test('test caculate result on one row', () {
    final gamedata = GameData();

    expect(gamedata.caculateRow([2, 2, 4, 2]), [0, 4, 4, 2]);
    expect(gamedata.caculateRow([0, 0, 0, 2]), [0, 0, 0, 2]);
    expect(gamedata.caculateRow([2, 4, 8, 16]), [2, 4, 8, 16]);
    expect(gamedata.caculateRow([0, 2, 2, 0]), [0, 0, 0, 4]);
    expect(gamedata.caculateRow([8, 2, 0, 0]), [0, 0, 8, 2]);
  });

  test('caculate result on table', () {
    final gamedata = GameData();

    expect(
        gamedata.caculateTable([
          [2, 2, 4, 2],
          [0, 0, 0, 2],
          [2, 4, 8, 16],
          [8, 2, 0, 0]
        ]),
        [
          [0, 4, 4, 2],
          [0, 0, 0, 2],
          [2, 4, 8, 16],
          [0, 0, 8, 2]
        ]);
  });

  test('rotate when flick right to left', () {
    final gameData = GameData();

    expect(
        gameData.rotateTable([
          [2, 2, 4, 2],
          [0, 0, 0, 2],
          [2, 4, 8, 16],
          [8, 2, 0, 0]
        ], Flick.rightToLeft),
        [
          [2, 4, 2, 2],
          [2, 0, 0, 0],
          [16, 8, 4, 2],
          [0, 0, 2, 8]
        ]);

    expect(
        gameData.rotateTable([
          [2, 4, 2, 2],
          [2, 0, 0, 0],
          [16, 8, 4, 2],
          [0, 0, 2, 8]
        ], Flick.rightToLeft, true),
        [
          [2, 2, 4, 2],
          [0, 0, 0, 2],
          [2, 4, 8, 16],
          [8, 2, 0, 0]
        ]);
  });

  test('rotate when flick top to bottom', () {
    final gameData = GameData();

    expect(
        gameData.rotateTable([
          [2, 2, 4, 2],
          [0, 0, 0, 2],
          [2, 4, 8, 16],
          [8, 2, 0, 0]
        ], Flick.topToBtm),
        [
          [2, 0, 2, 8],
          [2, 0, 4, 2],
          [4, 0, 8, 0],
          [2, 2, 16, 0]
        ]);
    expect(
        gameData.rotateTable([
          [2, 0, 2, 8],
          [2, 0, 4, 2],
          [4, 0, 8, 0],
          [2, 2, 16, 0]
        ], Flick.topToBtm, true),
        [
          [2, 2, 4, 2],
          [0, 0, 0, 2],
          [2, 4, 8, 16],
          [8, 2, 0, 0]
        ]);
  });
  test('rotate when flick bottom to top', () {
    final gameData = GameData();

    expect(
        gameData.rotateTable([
          [2, 2, 4, 2],
          [0, 0, 0, 2],
          [2, 4, 8, 16],
          [8, 2, 0, 0]
        ], Flick.btmToTop),
        [
          [8, 2, 0, 2],
          [2, 4, 0, 2],
          [0, 8, 0, 4],
          [0, 16, 2, 2]
        ]);

    expect(
        gameData.rotateTable([
          [8, 2, 0, 2],
          [2, 4, 0, 2],
          [0, 8, 0, 4],
          [0, 16, 2, 2]
        ], Flick.btmToTop, true),
        [
          [2, 2, 4, 2],
          [0, 0, 0, 2],
          [2, 4, 8, 16],
          [8, 2, 0, 0]
        ]);
  });

  test('caculate when flick right to left', () {
    final gameData = GameData();

    expect(
        gameData.caculateTableBaseOnFlick([
          [2, 2, 4, 2],
          [0, 0, 0, 2],
          [2, 4, 8, 16],
          [8, 2, 0, 0]
        ], Flick.rightToLeft),
        [
          [4, 4, 2, 0],
          [2, 0, 0, 0],
          [2, 4, 8, 16],
          [8, 2, 0, 0]
        ]);
  });

  test('caculate when flick top to bottom', () {
    final gameData = GameData();

    expect(
        gameData.caculateTableBaseOnFlick([
          [2, 2, 4, 2],
          [0, 0, 0, 2],
          [2, 4, 8, 16],
          [8, 2, 0, 0]
        ], Flick.topToBtm),
        [
          [0, 0, 0, 0],
          [0, 2, 0, 0],
          [4, 4, 4, 4],
          [8, 2, 8, 16]
        ]);
  });

  test('caculate when flick bottom to top', () {
    final gameData = GameData();

    expect(
        gameData.caculateTableBaseOnFlick([
          [2, 2, 4, 2],
          [0, 0, 0, 2],
          [2, 4, 8, 16],
          [8, 2, 0, 0]
        ], Flick.btmToTop),
        [
          [4, 2, 4, 4],
          [8, 4, 8, 16],
          [0, 2, 0, 0],
          [0, 0, 0, 0]
        ]);
  });

  test('game over', () {
    final gameData = GameData();

    expect(
        gameData.isGameOver([
          [2, 2, 4, 2],
          [0, 0, 0, 2],
          [2, 4, 8, 16],
          [8, 2, 0, 0]
        ]),
        false);

    expect(
        gameData.isGameOver([
          [2, 2, 4, 2],
          [2, 4, 8, 2],
          [2, 4, 8, 16],
          [8, 2, 2, 2]
        ]),
        true);
  });
}
