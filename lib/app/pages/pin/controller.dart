import 'package:dimipay_pos_flutter/app/routes/routes.dart';
import 'package:get/get.dart';

class PinPageController extends GetxController {
  // AuthService authService = Get.find<AuthService>();

  Future onboardingAuth(String pin) async {
    // await authService.onBoardingAuth(pin);
    Get.offNamed(Routes.home);
  }
}
