import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'dart:developer' as dev;
import 'dart:async';
import 'dart:io';

import 'package:dimipay_kiosk/app/services/auth/repository.dart';
import 'package:dimipay_kiosk/app/services/auth/model.dart';
import 'package:dimipay_kiosk/app/routes/routes.dart';

class AuthService extends GetxController {
  static AuthService get to => Get.find<AuthService>();

  final AuthRepository repository;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final Rx<JWTToken> _jwtToken = Rx(JWTToken());

  AuthService({AuthRepository? repository})
      : repository = repository ?? AuthRepository();

  bool get isAuthenticated => _jwtToken.value.accessToken != null;
  String? get accessToken => _jwtToken.value.accessToken;

  Future<AuthService> init() async {
    final String? accessToken = await _storage.read(key: 'accessToken');
    _jwtToken.value = JWTToken(accessToken: accessToken);
    return this;
  }

  Future<void> _setJWTToken(JWTToken newToken) async {
    await _storage.write(key: 'accessToken', value: newToken.accessToken);
    _jwtToken.value = newToken;
  }
}
