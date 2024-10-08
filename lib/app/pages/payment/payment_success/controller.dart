import 'package:dimipay_kiosk/app/routes/routes.dart';
import 'package:get/get.dart';
import 'dart:async';

class PaymentSuccessPageController extends GetxController {
  late Timer timer;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    timer = Timer(const Duration(seconds: 2), () {
      Get.offAllNamed(Routes.ONBOARDING);
    });
  }

  @override
  void onClose() {
    timer.cancel();
    super.onClose();
  }
}
