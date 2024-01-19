import 'dart:math';

import 'package:dimipay_pos_flutter/app/routes/routes.dart';
import 'package:get/get.dart';

class NumberController extends GetxController {
  static NumberController get to => Get.find<NumberController>();

  final _length = 0.obs;
  final _pressed = false.obs;
  final _password = <int>[].obs;
  final _pressedNumber = <int>[].obs;
  final _procession = [
    [0, 3, 6],
    [1, 4, 7, 9],
    [2, 5, 8]
  ];

  final numbers = List.generate(10, (index) => index);

  int get length => _length.value;
  bool get pressed => _pressed.value;
  List<int> get password => _password.value;
  List<int> get pressedNumber => _pressedNumber.value;

  set length(int value) => _length.value = value;
  set pressed(bool value) => _pressed.value = value;
  set password(List<int> value) => _password.value = value;
  set pressedNumber(List<int> value) => _pressedNumber.value = value;

  @override
  void onInit() {
    super.onInit();
    numbers.shuffle();
  }

  List<int> _random(int number) {
    var index = numbers.indexOf(number);
    var row = index == 9 ? 1 : index % 3;
    var randomIndex = Random();
    var returnNumbers = [number];
    returnNumbers.add(numbers[_procession[0][randomIndex.nextInt(3)]]);
    returnNumbers.add(numbers[_procession[1][randomIndex.nextInt(4)]]);
    returnNumbers.add(numbers[_procession[2][randomIndex.nextInt(3)]]);
    returnNumbers.removeAt(++row);
    return returnNumbers;
  }

  void down(int number) {
    pressed = !pressed;
    if (number == 10) {
      pressedNumber = [10];
      return;
    }
    pressedNumber = _random(number);
  }

  void canceled() {
    pressed = !pressed;
  }

  void up(int number) {
    pressed = !pressed;

    if (number == 10) {
      if (length == 0) return;
      password.removeLast();
      length--;
      return;
    }

    password.add(number);
    length++;

    if (length == 4) {
      Get.toNamed(Routes.payment);
    }
  }
}
