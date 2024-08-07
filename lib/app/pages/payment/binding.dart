import 'package:get/get.dart';

import 'package:dimipay_kiosk/app/pages/payment/controller.dart';

class PaymentPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PaymentPageController());
  }
}
