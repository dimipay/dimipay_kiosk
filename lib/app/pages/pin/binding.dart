import 'package:dimipay_kiosk/app/pages/pin/controller.dart';
import 'package:get/get.dart';

class PinPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PinPageController().init());
  }
}
