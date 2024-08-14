import 'package:get/get.dart';
import 'dart:math';

import 'package:dimipay_kiosk/app/services/face_sign/service.dart';
import 'package:dimipay_kiosk/app/services/auth/service.dart';

class PinPageController extends GetxController {
  static PinPageController get to => Get.find<PinPageController>();

  final RxList<int> numbers = List.generate(10, (index) => index).obs;
  final RxList<int> pressedPin = <int>[].obs;
  final RxList<int> _input = <int>[].obs;
  final RxInt _inputLength = 0.obs;
  final RxBool _isPressed = false.obs;

  final _dimension = [
    [0, 3, 6],
    [1, 4, 7, 9],
    [2, 5, 8]
  ];

  int get inputLength => _inputLength.value;
  bool get isPressed => _isPressed.value;
  bool get canDelete => _inputLength.value > 0;

  set pressedPin(List<int> value) => pressedPin.value = value;

  PinPageController init() {
    _input.clear();
    _inputLength.value = 0;
    numbers.shuffle();
    return this;
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
    _isPressed.value = !isPressed;
    if (number >= 10) {
      pressedPin = [number];
      return;
    }
    pressedPin = _random(number);
  }

  void canceled() => _isPressed.value = !isPressed;

  void up(int number) async {
    _isPressed.value = !isPressed;
    if (inputLength == 4) return;
    if (number == -2) {
      if (inputLength == 0) return;
      _input.removeLast();
      _inputLength.value--;
      return;
    }
    if (number == -1) {
      return;
    }

    _input.add(number);
    _inputLength.value++;
    if (inputLength == 4) {
      if (AuthService.to.isAuthenticated) {
        await FaceSignService.to.approvePin(_input.join().toString());
      } else {
        await AuthService.to.loginKiosk(_input.join().toString());
      }
      init();
    }
  }
}