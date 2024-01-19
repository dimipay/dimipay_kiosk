import 'dart:math';

import 'package:get/get.dart';

class NumberController extends GetxController {
  final _isPressed = false.obs;
  // final _selectedNumber = 0.obs;
  final _password = List<int>.empty().obs;
  final _numberIndex = List<int>.empty().obs;
  final _pressedNumber = List<int>.empty().obs;

  final _numbers = List.generate(10, (index) => index);

  bool get isPressed => _isPressed.value;
  // int get selectedNumber => _selectedNumber.value;
  List<int> get password => _password.value;
  List<int> get numberIndex => _numberIndex.value;
  List<int> get pressedNumber => _pressedNumber.value;

  set isPressed(bool value) => _isPressed.value = value;
  // set selectedNumber(int value) => _selectedNumber.value = value;
  set password(List<int> value) => _password.value = value;
  set numberIndex(List<int> value) => _numberIndex.value = value;
  set pressedNumber(List<int> value) => _pressedNumber.value = value;

  @override
  void onInit() {
    super.onInit();
    _numbers.shuffle();
  }

  void init(List<int> numbers) {
    numberIndex = numbers;
  }

  List<int> _random(int number) {
    var index = numberIndex.indexOf(number);
    var row = index == 9 ? 1 : index % 3;
    var randomIndex = Random();
    var returnNumbers = [number];
    const rowIndex = [
      [0, 3, 6],
      [1, 4, 7, 9],
      [2, 5, 8]
    ];
    returnNumbers.add(numberIndex[rowIndex[0][randomIndex.nextInt(3)]]);
    returnNumbers.add(numberIndex[rowIndex[1][randomIndex.nextInt(4)]]);
    returnNumbers.add(numberIndex[rowIndex[2][randomIndex.nextInt(3)]]);
    returnNumbers.removeAt(++row);
    return returnNumbers;
  }

  void pressed(int number) {
    isPressed = !isPressed;
    pressedNumber = _random(number);
    // print("pressed button number : ${pressedNumber}");
  }

  void canceled() {
    isPressed = !isPressed;
    // print("canceled");
  }

  void released(int number) {
    isPressed = !isPressed;
    password.add(number);

    if (password.length == 4) {
      print("password : ${password}");
    }
    // selectedNumber = number;
    // print("selected number : ${selectedNumber}");
  }

  void delete() {
    password.removeLast();
  }
}
