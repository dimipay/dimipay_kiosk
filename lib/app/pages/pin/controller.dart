import 'package:dimipay_kiosk/app/services/auth/repository.dart';
import 'package:dimipay_kiosk/app/widgets/alert_modal.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'dart:math';

import 'package:dimipay_kiosk/app/routes/routes.dart';

class PinPageController extends GetxController {
  static PinPageController get to => Get.find<PinPageController>();

  final numbers = List.generate(10, (index) => index);

  final _input = <int>[].obs;
  final _inputLength = 0.obs;
  final _isPressed = false.obs;
  final _pressedPin = <int>[].obs;
  final _dimension = [
    [0, 3, 6],
    [1, 4, 7, 9],
    [2, 5, 8]
  ];

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

  Future<void> up(int number) async {
    isPressed = !isPressed;

    if (inputLength == 4) return;

    if (number == 10) {
      if (inputLength == 0) return;
      input.removeLast();
      inputLength--;
      return;
    }

    input.add(number);
    inputLength++;

    if (inputLength == 4) {
      if (await _auth()) Get.offAndToNamed(Routes.ONBOARD);
    }
  }

  Future<bool> _auth() async {
    var dio = Dio();
    try {
      final response =
          await dio.request("https://dev-api.dimipay.io/pos-login/",
              data: {
                "passcode": input.join(),
              },
              options: Options(method: 'POST', headers: {
                'Content-Type': 'application/json',
              }));
      // print(AuthRepository().refreshAccessToken(response.data['accessToken']));

      return true;
    } catch (e) {
      input.clear();
      inputLength = 0;
      AlertModal.to.show("비밀번호가 틀렸습니다. 다시 입력해주세요.");
      return false;
    }
  }
}
