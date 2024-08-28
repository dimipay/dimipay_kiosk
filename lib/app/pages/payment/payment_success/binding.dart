import 'package:dimipay_kiosk/app/pages/payment/controller.dart';
import 'package:dimipay_kiosk/app/pages/payment/payment_failed/controller.dart';
import 'package:dimipay_kiosk/app/pages/payment/payment_success/controller.dart';
import 'package:get/get.dart';

class PaymentSuccessPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(PaymentSuccessPageController());
  }
}
