import 'package:dimipay_kiosk/app/pages/onboard/controller.dart';
import 'package:get/get.dart';

class OnboardPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardPageController>(() => OnboardPageController());
  }
}
