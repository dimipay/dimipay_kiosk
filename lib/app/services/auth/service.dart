import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:dimipay_kiosk/app/pages/pin/controller.dart';
import 'package:dimipay_kiosk/app/services/auth/repository.dart';
import 'package:dimipay_kiosk/app/services/auth/model.dart';

class AuthService extends GetxController {
  static AuthService get to => Get.find<AuthService>();

  final AuthRepository repository;
  final Rx<JWTToken> _jwtToken = Rx(JWTToken());
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  AuthService({AuthRepository? repository})
      : repository = repository ?? AuthRepository();

  bool get isAuthenticated => _jwtToken.value.accessToken != null;
  String? get accessToken => _jwtToken.value.accessToken;

  Future<AuthService> init() async {
    final String? accessToken = await _storage.read(key: 'accessToken');
    final String? refreshToken = await _storage.read(key: 'refreshToken');

    _jwtToken.value =
        JWTToken(accessToken: accessToken, refreshToken: refreshToken);

    return this;
  }

  Future<void> _setJWTToken(JWTToken newToken) async {
    await _storage.write(key: 'accessToken', value: newToken.accessToken);
    await _storage.write(key: 'refreshToken', value: newToken.refreshToken);
    _jwtToken.value = newToken;
  }

  Future<bool> activateKiosk(String pin) async {
    try {
      _jwtToken.value =
          JWTToken(accessToken: await repository.getAccessToken(pin));
    } catch (_) {
      PinPageController.to.init();
      return false;
    }
    _setJWTToken(_jwtToken.value);
    return true;
  }
}
