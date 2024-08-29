import 'dart:async';
import 'package:dimipay_kiosk/app/pages/product/widgets/timeout_alert.dart';
import 'package:dimipay_kiosk/app/routes/routes.dart';
import 'package:get/get.dart';

class TimerService extends GetxService {
  Timer? _inactivityTimer;
  final RxInt remainingTime = 30.obs;
  final RxBool showAlert = false.obs;

  void startTimer({Function? onTimeout}) {
    stopTimer();
    remainingTime.value = 30;
    showAlert.value = false;

    _inactivityTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      print('Timer: ${remainingTime.value}');
      if (remainingTime.value > 1) {
        remainingTime.value--;
        if (remainingTime.value <= 10 && !showAlert.value) {
          showAlert.value = true;
          _showTimeoutAlert();
        }
      } else {
        stopTimer();
        Get.offAllNamed(Routes.ONBOARDING);
      }
    });
  }

  void _showTimeoutAlert() {
    Get.dialog(
      TimeoutAlert(
        remainingTime: remainingTime,
        onInteraction: resetTimer,
      ),
      barrierDismissible: false,
    );
  }

  void stopTimer() {
    _inactivityTimer?.cancel();
    _inactivityTimer = null;
    showAlert.value = false;
  }

  void resetTimer() {
    if (_inactivityTimer != null && _inactivityTimer!.isActive) {
      startTimer();
    }
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }
}