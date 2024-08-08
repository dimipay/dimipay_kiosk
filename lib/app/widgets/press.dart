import 'package:get/get.dart';

mixin Press {
  final RxString _pressedButton = "".obs;

  String get pressedButton => _pressedButton.value;

  pressButton(String button) {
    _pressedButton.value = button;
  }

  resetButton() {
    _pressedButton.value = "";
  }

  bool isPressed(String button) {
    return _pressedButton.value == button;
  }
}
