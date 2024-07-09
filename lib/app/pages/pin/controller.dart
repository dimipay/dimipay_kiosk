import 'package:dimipay_kiosk/app/services/auth/service.dart';
import 'package:dimipay_kiosk/app/services/face_sign/service.dart';
import 'package:get/get.dart';
import 'dart:math';

import 'package:dimipay_kiosk/app/routes/routes.dart';

class PinPageController extends GetxController {
  static PinPageController get to => Get.find<PinPageController>();

  final numbers = List.generate(10, (index) => index).obs;
  final pressedPin = <int>[].obs;
  final _input = <int>[].obs;
  final _inputLength = 0.obs;
  final _isPressed = false.obs;
  final _dimension = [
    [0, 3, 6],
    [1, 4, 7, 9],
    [2, 5, 8]
  ];

  int get inputLength => _inputLength.value;
  bool get isPressed => _isPressed.value;

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

    if (number == 10) {
      if (inputLength == 0) return;
      _input.removeLast();
      _inputLength.value--;
      return;
    }

    if (number == 11) {
      Get.back();
      return;
    }

    _input.add(number);
    _inputLength.value++;
    if (inputLength == 4) {
      if (AuthService.to.isAuthenticated) {
        if (await FaceSignService.to.approvePayment(_input.join().toString())) {
          Get.toNamed(Routes.PAYMENT_SUCCESS);
        } else {
          Get.toNamed(Routes.PAYMENT_FAILED);
        }
      } else {
        if (await AuthService.to.loginKiosk(_input.join().toString())) {
          Get.offAndToNamed(Routes.ONBOARD);
        }
      }
      init();
    }
  }
}
