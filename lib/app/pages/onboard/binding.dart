import 'package:get/get.dart';

import 'package:dimipay_kiosk/app/pages/onboard/controller.dart';
import 'package:dimipay_kiosk/app/widgets/alert_modal.dart';

class OnboardPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OnboardPageController());
    Get.lazyPut(() => AlertModal());
  }
}
