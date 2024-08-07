import 'package:get/get.dart';

import 'package:dimipay_kiosk/app/pages/payment/controller.dart';
import 'package:dimipay_kiosk/app/services/qr/service.dart';

class PaymentPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PaymentPageController());
    Get.lazyPut(() => QRService());
  }
}
