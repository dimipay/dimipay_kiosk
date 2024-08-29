import 'dart:async';
import 'package:dimipay_kiosk/app/core/utils/errors.dart';
import 'package:dimipay_kiosk/app/routes/routes.dart';
import 'package:dimipay_kiosk/app/services/auth/service.dart';
import 'package:dimipay_kiosk/app/services/kiosk/model.dart';
import 'package:dimipay_kiosk/app/services/kiosk/service.dart';
import 'package:dimipay_kiosk/app/widgets/snackbar.dart';
import 'package:get/get.dart';
import 'dart:io';

class OnboardPageController extends GetxController {
  AuthService authService = Get.find<AuthService>();
  KioskService kioskService = Get.find<KioskService>();

  final Rx<HealthStatus> healthAreaStatus =
      Rx<HealthStatus>(HealthStatus.loading());

  Timer? _healthCheckTimer;
  static const Duration healthCheckInterval = Duration(minutes: 5);

  @override
  void onInit() {
    super.onInit();
    getHealth();
    _startPeriodicHealthCheck();
  }

  @override
  void onClose() {
    _healthCheckTimer?.cancel();
    super.onClose();
  }

  Future<Product?> getProduct({required String input}) async {
    try {
      Product data = await kioskService.getProduct(barcode: input);
      Get.offAndToNamed(Routes.PRODUCT, arguments: data);
      return data;
    } on ProductNotFoundException catch (e) {
      DPAlertModal.open(e.message);
    } on DisabledProductException catch (e) {
      DPAlertModal.open(e.message);
    } on UnknownException catch (e) {
      DPAlertModal.open(e.message);
      healthAreaStatus.value = HealthStatus.failed();
    }
    return null;
  }

  void _startPeriodicHealthCheck() {
    _healthCheckTimer = Timer.periodic(healthCheckInterval, (_) => getHealth());
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

      bool isConnected = await checkInternetConnection();
      if (!isConnected) {
        healthAreaStatus.value = HealthStatus.failed();
        DPAlertModal.open('인터넷 연결이 없습니다. 네트워크 상태를 확인해주세요.');
        return;
      }

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
    } on TokenErrorException catch (e) {
      DPAlertModal.open(e.message);
      healthAreaStatus.value = HealthStatus.failed();
    } on TokenExpiredException catch (e) {
      DPAlertModal.open(e.message);
      healthAreaStatus.value = HealthStatus.failed();
    } on TokenNotFoundException catch (e) {
      DPAlertModal.open(e.message);
      healthAreaStatus.value = HealthStatus.failed();
    } on UnauthenticatedException catch (e) {
      DPAlertModal.open(e.message);
      healthAreaStatus.value = HealthStatus.failed();
    } on WrongTokenTypeException catch (e) {
      DPAlertModal.open(e.message);
      healthAreaStatus.value = HealthStatus.failed();
    } on NoTransactionIdFoundException catch (e) {
      DPAlertModal.open(e.message);
      healthAreaStatus.value = HealthStatus.failed();
    } on UnknownException catch (e) {
      DPAlertModal.open(e.message);
      healthAreaStatus.value = HealthStatus.failed();
    }
  }

  Future<bool> checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('prod-next.dimipay.io');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
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
