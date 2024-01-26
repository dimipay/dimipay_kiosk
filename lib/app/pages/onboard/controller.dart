import 'package:get/get.dart';

import 'package:dimipay_kiosk/app/routes/routes.dart';

class OnboardPageController extends GetxController {
  static OnboardPageController get to => Get.find<OnboardPageController>();

  final RxBool _isConnecting = false.obs;
  final RxBool _isConnected = true.obs;

  bool get isConnecting => _isConnecting.value;
  bool get isConnected => _isConnected.value;

  set isConnecting(bool value) => _isConnecting.value = value;
  set isConnected(bool value) => _isConnected.value = value;
}
