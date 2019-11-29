import 'dart:math';

enum Flick {
  leftToRight,
  rightToLeft,
  topToBtm,
  btmToTop,
}

class GameData {
  List<List<int>> createEmptyList([int size = 4]) {
    return List.generate(size, (_) => List.filled(size, 0));
  }

  List<int> removeValueZeroInside(List<int> input) {
    List<int> arr = List.filled(input.length, 0);
    var position = arr.length - 1;
    for (var i = input.length - 1; i >= 0; i--) {
      if (input[i] != 0) {
        arr[position] = input[i];
        position--;
      }
    }
    return arr;
  }

  List<int> caculateRow(List<int> input) {
    List<int> arr = removeValueZeroInside(input);
    List<int> output = List.filled(input.length, 0);

    for (var i = input.length - 1; i > 0; i--) {
      if (arr[i] == 0) return output;
      if (arr[i] == arr[i - 1]) {
        // caculate output[i] = arr[i] + arr[i-1]
        output[i] = arr[i] * 2;
        // change position of all item before arr[i-1]
        // and add 0 to arr[0]
        for (var j = i - 1; j > 0; j--) {
          arr[j] = arr[j - 1];
        }
        arr[0] = 0;
      } else {
        output[i] = arr[i];
      }
    }

    output[0] = arr[0];
    return output;
  }

  List<List<int>> caculateTable(List<List<int>> input) {
    List<List<int>> output = createEmptyList();

    for (var i = 0; i < input.length; i++) {
      output[i] = caculateRow(input[i]);
    }
    return output;
  }

  List<List<int>> rotateTable(List<List<int>> input, Flick flick,
      [bool reverse = false]) {
    int size = input.length;

    List<List<int>> output = List.generate(size, (_) => List.filled(size, 0));

    switch (flick) {
      case Flick.leftToRight:
        return input;
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

  List<List<int>> caculateTableBaseOnFlick(List<List<int>> input, Flick flick) {
    List<List<int>> output = createEmptyList();

    input = rotateTable(input, flick);
    output = caculateTable(input);
    output = rotateTable(output, flick, true);
    if( input != output){
      output = addNewValue(output);
    }
    

    return output;
  }

  List<List<int>> getEmptyPosition(List<List<int>> input) {
    List<List<int>> positionList = new List();
    for (var i = 0; i < input.length; i++) {
      for (var j = 0; j < input.length; j++) {
        if (input[i][j] == 0) {
          positionList.add([i, j]);
        }
      }
    }
    return positionList;
  }

  bool isGameOver(List<List<int>> input){
    return getEmptyPosition(input).isEmpty;
  }

  List<List<int>> addNewValue(List<List<int>> input, [List<List<int>> emptyPositionList, int value = 2]){
    if(emptyPositionList == null){
      emptyPositionList = getEmptyPosition(input);
    }

    if(emptyPositionList.isNotEmpty){
      var ran = new Random();
      List<int> position = emptyPositionList[ran.nextInt(emptyPositionList.length -1)];
      input[position[0]][position[1]] = value;
    }

    return input;
  }
}
