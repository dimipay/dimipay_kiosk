import 'package:get/get.dart';
// import 'dart:async';

class PaymentPageController extends GetxController {
  static PaymentPageController get to => Get.find<PaymentPageController>();

  final _pressedButton = "".obs;
  String get pressedButton => _pressedButton.value;
  set pressedButton(String value) {
    _pressedButton.value = value;
  }

  final _timer = RxInt(30);

  get timer => _timer.value;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    // Timer(
    //   const Duration(seconds: 1),
    //   () {
    //     if (_timer.value > 0) {
    //       _timer.value--;
    //       startTimer();
    //     } else {
    //       Get.back();
    //     }
    //   },
    // );
  }
}
