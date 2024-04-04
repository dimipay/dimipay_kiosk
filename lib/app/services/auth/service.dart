import 'dart:ffi';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:dimipay_kiosk/app/services/auth/repository.dart';
import 'package:dimipay_kiosk/app/services/auth/model.dart';

class AuthService extends GetxController {
  static AuthService get to => Get.find<AuthService>();

  final AuthRepository repository;
  final Rx<String?> _transactionId = Rx(null);
  final Rx<String?> _deviceName = Rx(null);
  final Rx<JWTToken> _jwtToken = Rx(JWTToken());
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  AuthService({AuthRepository? repository})
      : repository = repository ?? AuthRepository();
  bool get isAuthenticated => _jwtToken.value.accessToken != null;
  String? get deviceName => _deviceName.value;
  String? get accessToken => _jwtToken.value.accessToken;
  Future<String?> get transactionId async {
    _transactionId.value ??= await repository.transactionId(accessToken!);
    return _transactionId.value;
  }

  Future<AuthService> init() async {
    if (kDebugMode) {
      // await _storage.deleteAll();
    }
    final String? refreshToken = await _storage.read(key: 'refreshToken');
    _deviceName.value = await _storage.read(key: 'deviceName');
    if (refreshToken == null || _deviceName.value == null) {
      return this;
    }
    _jwtToken.value = await repository.authRefresh(refreshToken);
    return this;
  }

  Future<void> _storeLoginData(Login loginData) async {
    await _storage.write(key: "deviceName", value: loginData.name);
    await _storage.write(
        key: "refreshToken", value: loginData.tokens.refreshToken);
    _deviceName.value = loginData.name;
    _jwtToken.value = loginData.tokens;
  }

  Future<bool> loginKiosk(String pin) async {
    try {
      await _storeLoginData(await repository.authLogin(pin));
      return true;
    } catch (_) {
      return false;
    }
  }

  // Future<void> createTransactionId() async {
  //   if (_transactionId.value != null) return;
  //   _transactionId.value = await repository.transactionId(accessToken!);
  // }
}
