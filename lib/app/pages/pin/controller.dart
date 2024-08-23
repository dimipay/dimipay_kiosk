import 'package:dimipay_kiosk/app/core/utils/errors.dart';
import 'package:dimipay_kiosk/app/routes/routes.dart';
import 'package:get/get.dart';

import 'package:dimipay_kiosk/app/services/auth/service.dart';

class PinPageController extends GetxController {
  AuthService authService = Get.find<AuthService>();

  final Rx<bool> _isLoginInProgress = Rx(false);

  bool get isLoginInProgress => _isLoginInProgress.value;

  Future loginWithPasscode({required String passcode}) async {
    try {
      _isLoginInProgress.value = true;
      await authService.loginWithPasscode(passcode: passcode);
      Get.offNamed(Routes.ONBOARDING);
    } on PasscodeNotFoundException catch (e) {
      print(e.message);
    } catch (e) {
      print(e);
    } finally {
      _isLoginInProgress.value = false;
    }
  }
}
