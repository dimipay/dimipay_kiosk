import 'package:dimipay_kiosk/app/routes/routes.dart';
import 'package:dimipay_kiosk/app/services/product/service.dart';
import 'package:flutter/foundation.dart';

import 'package:get/get.dart';
import 'dart:async';

import 'package:dimipay_kiosk/app/services/health/repository.dart';
import 'package:dimipay_kiosk/app/services/health/model.dart';
import 'package:dimipay_kiosk/app/services/auth/service.dart';

class HealthService extends GetxController {
  static HealthService get to => Get.find<HealthService>();

  final HealthRepository repository;
  final Rx<Health> _health = Rx(Health());

  String? get name => AuthService.to.deviceName;
  String? get status => _health.value.status;
  String? get message => _health.value.message;

  HealthService({HealthRepository? repository})
      : repository = repository ?? HealthRepository();

  Future<void> checkHealth() async {
    _health.value = Health();
    _health.value = await repository.health(AuthService.to.accessToken!);

    if (kDebugMode) {
      if (await ProductService.to.addProduct("1202303246757")) {
        Get.toNamed(Routes.PRODUCT);
      }
    }
  }
}
