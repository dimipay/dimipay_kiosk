import 'package:get/get.dart';

import 'package:dimipay_kiosk/app/pages/payment/controller.dart';
import 'package:dimipay_kiosk/app/widgets/alert_modal.dart';

class PaymentPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AlertModal());
    Get.lazyPut(() => PaymentPageController());
  }
}
