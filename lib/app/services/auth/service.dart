import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:dimipay_kiosk/app/services/auth/repository.dart';
import 'package:dimipay_kiosk/app/services/auth/model.dart';

class AuthService extends GetxController {
  static AuthService get to => Get.find<AuthService>();

  final AuthRepository repository;
  final Rx<String> _deviceName = Rx("");
  final Rx<JWTToken> _jwtToken = Rx(JWTToken());
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  AuthService({AuthRepository? repository})
      : repository = repository ?? AuthRepository();
  bool get isAuthenticated => _jwtToken.value.accessToken != null;
  String get deviceName => _deviceName.value;
  String? get accessToken => _jwtToken.value.accessToken;

  Future<AuthService> init() async {
    if (kDebugMode) {
      // await _storage.deleteAll();
    } else {
      // initializeCamera();
    }
    // final String? deviceName = await _storage.read(key: 'deviceName');
    final String? refreshToken = await _storage.read(key: 'refreshToken');
    // if (refreshToken == null || deviceName == null) {
    if (refreshToken == null) {
      return this;
    }
    // _deviceName.value = deviceName;
    _jwtToken.value = await repository.authRefresh(refreshToken);
    return this;
  }

  // Future<void> _storeLoginData(Login loginData) async {
  //   await _storage.write(
  //       key: 'refreshToken', value: loginData.tokens.refreshToken);
  //   await _storage.write(key: 'deviceName', value: deviceName);
  //   _deviceName.value = deviceName;
  // _jwtToken.value = loginData.tokens.refreshToken!;
  // }

  Future<void> _storeJWTToken(JWTToken jwtToken) async {
    await _storage.write(key: "refreshToken", value: jwtToken.refreshToken);
    _jwtToken.value = jwtToken;
  }

  Future<bool> loginKiosk(String pin) async {
    try {
      var result = await repository.authLogin(pin);
      _deviceName.value = result.name;
      await _storeJWTToken(result.tokens);
      // await _storeLoginData(result);
      return true;
    } catch (_) {
      return false;
    }
  }
}
