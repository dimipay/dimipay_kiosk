import 'package:get/get.dart';

import 'package:dimipay_kiosk/app/pages/onboard/controller.dart';

class OnboardPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OnboardPageController());
  }
}
