import 'package:get/get.dart';

import 'package:dimipay_kiosk/app/pages/pin/controller.dart';

class PinPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PinPageController());
  }
}
