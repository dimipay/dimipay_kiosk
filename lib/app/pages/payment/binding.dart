import 'package:dimipay_kiosk/app/pages/payment/controller.dart';
import 'package:get/get.dart';

class PaymentPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PaymentPageController());
  }
}
