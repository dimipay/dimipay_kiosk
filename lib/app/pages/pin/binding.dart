import 'package:get/get.dart';

import 'package:dimipay_kiosk/app/pages/pin/controller.dart';
import 'package:dimipay_kiosk/app/widgets/alert_modal.dart';

class PinPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AlertModal());
    Get.lazyPut(() => PinPageController().init());
  }
}
