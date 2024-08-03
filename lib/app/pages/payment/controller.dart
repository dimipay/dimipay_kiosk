import 'package:get/get.dart';
import 'dart:async';

class Spot {
  final double size;
  final int color;
  final RxDouble left;
  final RxDouble top;
  final Map<String, double> animatedPosition;

  Spot({
    required this.size,
    required this.color,
    required this.left,
    required this.top,
    required this.animatedPosition,
  });
}

class PaymentPageController extends GetxController {
  static PaymentPageController get to => Get.find<PaymentPageController>();

  final _pressedButton = "".obs;
  String get pressedButton => _pressedButton.value;
  set pressedButton(String value) {
    _pressedButton.value = value;
  }

  final _timer = RxInt(30);
  final _turns = RxDouble(0.0);

  get turns => _turns.value;
  get timer => _timer.value;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    Timer(
      const Duration(seconds: 1),
      () {
        if (_timer.value > 0) {
          _timer.value--;
          startTimer();
        } else {
          Get.back();
        }
      },
    );
  }
}
