import 'package:get/get.dart';

import 'package:dimipay_pos_flutter/app/pages/payment/controller.dart';

class PaymentPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PaymentPageController());
  }
}
