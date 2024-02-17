import 'package:camera/camera.dart';
import 'package:get/get.dart';

import 'package:dimipay_kiosk/app/services/auth/service.dart';

class PaymentPageController extends GetxController {
  static PaymentPageController get to => Get.find<PaymentPageController>();

  CameraController? cameraController;
  Rx<XFile?> imageFile = Rx(null);

  Future<void> init() async {
    AuthService.to.findUser();
  }
}
