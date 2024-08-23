import 'package:dimipay_kiosk/app/routes/routes.dart';
import 'package:dimipay_kiosk/app/services/auth/service.dart';
import 'package:get/get.dart';

class OnboardPageController extends GetxController {
  AuthService authService = Get.find<AuthService>();

  Future logout() async {
    try {
      authService.logout();
      Get.offAllNamed(Routes.PIN);
    } catch (e) {
      print(e);
    }
  }
}
