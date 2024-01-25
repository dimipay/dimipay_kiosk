import 'package:get/get.dart';
import 'dart:math';

import 'package:dimipay_pos_flutter/app/routes/routes.dart';

class PinPageController extends GetxController {
  static PinPageController get to => Get.find<PinPageController>();

  // AuthService authService = Get.find<AuthService>();

  // Future onboardingAuth(String pin) async {
  //   await authService.onBoardingAuth(pin);
  //   Get.offNamed(Routes.home);
  // }

  final _input = <int>[].obs;
  final _inputLength = 0.obs;

  final _isPressed = false.obs;
  final _pressedPin = <int>[].obs;
  final _dimension = [
    [0, 3, 6],
    [1, 4, 7, 9],
    [2, 5, 8]
  ];

  final numbers = List.generate(10, (index) => index);

  List<int> get input => _input;
  int get inputLength => _inputLength.value;
  bool get isPressed => _isPressed.value;
  List<int> get pressedPin => _pressedPin;

  set input(List<int> value) => _input.value = value;
  set inputLength(int value) => _inputLength.value = value;
  set isPressed(bool value) => _isPressed.value = value;
  set pressedPin(List<int> value) => _pressedPin.value = value;

  @override
  void onInit() {
    super.onInit();
    numbers.shuffle();
  }

  List<int> _random(int number) {
    var index = numbers.indexOf(number);
    var row = index == 9 ? 1 : index % 3;
    var randomIndex = Random();
    var returnPins = [number];
    returnPins.add(numbers[_dimension[0][randomIndex.nextInt(3)]]);
    returnPins.add(numbers[_dimension[1][randomIndex.nextInt(4)]]);
    returnPins.add(numbers[_dimension[2][randomIndex.nextInt(3)]]);
    returnPins.removeAt(++row);
    return returnPins;
  }

  void down(int number) {
    isPressed = !isPressed;
    if (number == 10) {
      pressedPin = [10];
      return;
    }
    pressedPin = _random(number);
  }

  void canceled() {
    isPressed = !isPressed;
  }

  void up(int number) {
    isPressed = !isPressed;

    if (number == 10) {
      if (inputLength == 0) return;
      input.removeLast();
      inputLength--;
      return;
    }

    input.add(number);
    inputLength++;

    if (inputLength == 4) {
      Get.offAndToNamed(Routes.onboard);
    }
  }
}
