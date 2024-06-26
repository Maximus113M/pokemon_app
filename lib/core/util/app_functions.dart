import 'dart:math';

class AppFunctions {
  static final RegExp emailRegExp = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  );

  static List<int> getRandomNumbers() {
    List<int> numbers = [];
    int randomNumber = 1;
    while (numbers.length < 4) {
      randomNumber = Random().nextInt(648) + 1;
      if (numbers.contains(randomNumber)) continue;
      numbers.add(randomNumber);
    }
    return numbers;
  }

  static int getRandomIndex() {
    int randomNumber = 0;
    randomNumber = Random().nextInt(4);
    return randomNumber;
  }
}
