import 'package:dimipay_kiosk/app/services/timer/service.dart';
import 'package:get/get.dart';

class PaymentFailedPageController extends GetxController {
  TimerService timerService = Get.find<TimerService>();

  @override
  void onInit() {
    timerService.stopTimer();
    super.onInit();
  }

  @override
  void onClose() {
    timerService.startTimer();
    super.onClose();
  }
}
