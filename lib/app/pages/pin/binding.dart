import 'package:dimipay_kiosk/app/services/auth/service.dart';
import 'package:dimipay_kiosk/app/services/face_sign/service.dart';
import 'package:get/get.dart';

import 'package:dimipay_kiosk/app/pages/pin/controller.dart';

class PinPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PinPageController());
    Get.lazyPut(() => AuthService());
    Get.lazyPut(() => FaceSignService());
  }
}
