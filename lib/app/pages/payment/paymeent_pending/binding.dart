import 'package:dimipay_kiosk/app/pages/payment/controller.dart';
import 'package:dimipay_kiosk/app/pages/payment/paymeent_pending/controller.dart';
import 'package:dimipay_kiosk/app/pages/payment/payment_failed/controller.dart';
import 'package:get/get.dart';

class PaymentPendingPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PaymentPendingPageController());
  }
}
