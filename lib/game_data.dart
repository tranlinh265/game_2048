import 'dart:math';
import 'bloc/flick_event.dart';
import 'package:collection/collection.dart';

class GameData {
  static const arraySize = 4;

  List<List<int>> combine(List<List<int>> input, Flick flick) {
    input = rotateTable(input, flick);
    for (var i = 0; i < input.length; i++) {
      input[i] = slide(input[i]);
      input[i] = combineOneRow(input[i]);
      input[i] = slide(input[i]);
    }

    return rotateTable(input, flick, true);
  }

  List<int> combineOneRow(List<int> input) {
    for (var i = input.length - 1; i >= 1; i--) {
      if (input[i] != 0 && input[i] == input[i - 1]) {
        input[i] *= 2;
        input[i - 1] = 0;
      }
    }
    return input;
  }

  List<int> slide(List<int> input) {
    List<int> output = createEmptyRow(input.length);
    int position = output.length - 1;
    for (var i = input.length - 1; i >= 0; i--) {
      if (input[i] != 0) {
        output[position] = input[i];
        position--;
      }
    }

    return output;
  }

  List<int> createEmptyRow(int size) {
    return List.generate(size, (_) => 0);
  }

  List<List<int>> createEmptyList([int size = arraySize]) {
    return List.generate(size, (_) => List.filled(size, 0));
  }

  List<List<int>> randomNewList([int size = arraySize]) {
    List<List<int>> output = createEmptyList(size);

    var ran = Random();
    var i = ran.nextInt(size - 1);
    var j = ran.nextInt(size - 1);

    output[i][j] = 2;

    return output;
  }

  List<List<int>> rotateTable(List<List<int>> input, Flick flick,
      [bool reverse = false]) {
    int size = input.length;

    List<List<int>> output = List.generate(size, (_) => List.filled(size, 0));

    switch (flick) {
      case Flick.leftToRight:
        for (var i = 0; i < size; i++) {
          for (var j = 0; j < size; j++) {
            output[i][j] = input[i][j];
          }
        }
        break;
      case Flick.rightToLeft:
        // 00 03
        // 01 02
        // 02 01
        // 03 00
        for (var i = 0; i < size; i++) {
          for (var j = 0; j < size; j++) {
            output[i][j] = input[i][size - 1 - j];
          }
        }
        break;
      case Flick.topToBtm:
        // 00 00
        // 10 01
        // 20 02
        // 30 03
        for (var i = 0; i < size; i++) {
          for (var j = 0; j < size; j++) {
            output[i][j] = input[j][i];
          }
        }
        break;
      case Flick.btmToTop:
        // 00 03
        // 10 02
        // 20 01
        // 30 00
        for (var i = 0; i < size; i++) {
          for (var j = 0; j < size; j++) {
            if (reverse) {
              output[size - 1 - j][i] = input[i][j];
            } else {
              output[i][j] = input[size - 1 - j][i];
            }
          }
        }
        break;
    }

    return output;
  }

  bool isGameOver(
      List<List<int>> input, List<List<int>> combined, Flick flick) {
    for (var i = 0; i < input.length; i++) {
      for (var j = 0; j < input[i].length; j++) {
        if (input[i][j] == 0) {
          return false;
        }
      }
    }

    if (flick == Flick.leftToRight || flick == Flick.rightToLeft) {
      flick = Flick.btmToTop;
    } else {
      flick = Flick.rightToLeft;
    }

    Function deepEq = const DeepCollectionEquality().equals;

    return deepEq(input, combined) && deepEq(input, combine(input, flick));
  }

  List<List<int>> addNewValue(List<List<int>> input, List<List<int>> combined) {
    Function deepEq = const DeepCollectionEquality().equals;

    if (deepEq(input, combined)) {
      return input;
    }

    List<List<int>> positionList = [];
    for (var i = 0; i < combined.length; i++) {
      for (var j = 0; j < combined[i].length; j++) {
        if (combined[i][j] == 0) {
          positionList.add([i, j]);
        }
      }
    }

    if (positionList.length > 0) {
      Random ran = Random();
      int position = ran.nextInt(positionList.length);

      combined[positionList[position][0]][positionList[position][1]] = 2;
    }

    return combined;
  }
}
