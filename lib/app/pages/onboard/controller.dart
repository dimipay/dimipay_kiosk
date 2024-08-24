import 'package:dimipay_kiosk/app/core/utils/errors.dart';
import 'package:dimipay_kiosk/app/routes/routes.dart';
import 'package:dimipay_kiosk/app/services/auth/service.dart';
import 'package:dimipay_kiosk/app/services/kiosk/service.dart';
import 'package:dimipay_kiosk/app/widgets/snackbar.dart';
import 'package:get/get.dart';

class OnboardPageController extends GetxController {
  AuthService authService = Get.find<AuthService>();
  KioskService kioskService = Get.find<KioskService>();

  final Rx<HealthStatus> healthAreaStatus =
      Rx<HealthStatus>(HealthStatus.loading());

  @override
  void onInit() {
    super.onInit();
    getHealth();
  }

  Future<void> logout() async {
    try {
      await authService.logout();
      Get.offAllNamed(Routes.PIN);
    } catch (e) {
      print(e);
    }
  }

  Future<void> getHealth() async {
    try {
      healthAreaStatus.value = HealthStatus.loading();
      final health = await kioskService.getHealth();
      if (health == 'healthy') {
        healthAreaStatus.value = HealthStatus.success();
      } else if (health == 'stopped') {
        healthAreaStatus.value = HealthStatus.failed();
      }
    } on WrongTransactionIdException catch (e) {
      DPAlertModal.open(e.message);
      healthAreaStatus.value = HealthStatus.failed();
    } on ClientDisabledException catch (e) {
      DPAlertModal.open(e.message);
      healthAreaStatus.value = HealthStatus.failed();
    } on WrongClientTypeException catch (e) {
      DPAlertModal.open(e.message);
      healthAreaStatus.value = HealthStatus.failed();
    } on ClientNotFoundException catch (e) {
      DPAlertModal.open(e.message);
      healthAreaStatus.value = HealthStatus.failed();
    } catch (e) {
      print(e);
      healthAreaStatus.value = HealthStatus.failed();
    }
  }
}

enum HealthStatusType { loading, success, failed }

class HealthStatus {
  final HealthStatusType type;

  HealthStatus.loading() : type = HealthStatusType.loading;

  HealthStatus.success() : type = HealthStatusType.success;

  HealthStatus.failed() : type = HealthStatusType.failed;

  T when<T>({
    required T Function() loading,
    required T Function() success,
    required T Function() failed,
  }) {
    switch (type) {
      case HealthStatusType.loading:
        return loading();
      case HealthStatusType.success:
        return success();
      case HealthStatusType.failed:
        return failed();
    }
  }
}
