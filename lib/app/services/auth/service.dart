import 'dart:async';
import 'dart:convert';
import 'dart:developer' as dev;
import 'package:dimipay_kiosk/app/core/utils/errors.dart';
import 'package:dimipay_kiosk/app/routes/routes.dart';
import 'package:dimipay_kiosk/app/services/auth/repository.dart';
import 'package:fast_rsa/fast_rsa.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'key_manager/aes.dart';
import 'key_manager/jwt.dart';
import 'key_manager/rsa.dart';

class AuthService {
  final AuthRepository repository;

  late final JwtManager jwt;
  late final AesManager aes;
  late final RsaManager rsa;

  bool get isPasscodeLoginSuccess => jwt.onboardingToken.accessToken != null;

  bool get isAuthenticated => jwt.token.accessToken != null;

  Completer _refreshTokenApiCompleter = Completer()..complete();

  AuthService({AuthRepository? repository})
      : repository = repository ?? AuthRepository();

  Future<AuthService> init() async {
    jwt = await JwtManager().init();
    aes = await AesManager().init();
    rsa = await RsaManager().init();

    return this;
  }

  Future<void> _getEncryptionKey() async {
    rsa.setKey(await RsaManager.generateRSAKeyPair());
    final String rawAesEncKey = await repository.getEncryptionKey(
        rsa.key!.publicKey.replaceAll('\n', '\\r\\n'),
        jwt.onboardingToken.accessToken!);

    aes.setKey(await RSA.decryptOAEPBytes(
        base64.decode(rawAesEncKey), '', Hash.SHA1, rsa.key!.privateKey));
  }

  Future<void> loginWithPasscode({required String passcode}) async {
    Map loginResult = await repository.loginWithPasscode(passcode: passcode);

    jwt.setOnboardingToken(
        JwtToken(accessToken: loginResult['tokens']['accessToken']));

    await _getEncryptionKey();
  }

  ///Throws exception and route to LoginPage if refresh faild
  Future<void> refreshAcessToken() async {
    // refreshTokenApi의 동시 다발적인 호출을 방지하기 위해 completer를 사용함. 동시 다발적으로 이 함수를 호출해도 api는 1번만 호출 됨.
    if (_refreshTokenApiCompleter.isCompleted == false) {
      return _refreshTokenApiCompleter.future;
    }

    //첫 호출(null)이거나 이미 완료된 호출(completed completer)일 경우 새 객체 할당
    _refreshTokenApiCompleter = Completer();
    try {
      JwtToken newJwt =
          await repository.refreshAccessToken(jwt.token.refreshToken!);
      if (jwt.token.refreshToken == null) {
        throw NoRefreshTokenException();
      }
      dev.log('token refreshed!');
      dev.log(
          'accessToken expires at ${JwtDecoder.getExpirationDate(newJwt.accessToken!)}');
      dev.log(
          'refreshToken expires at ${JwtDecoder.getExpirationDate(newJwt.refreshToken!)}');
      await jwt.setToken(newJwt);
      _refreshTokenApiCompleter.complete();
    } catch (e) {
      await logout();
      Get.offAllNamed(Routes.ONBOARDING);
      _refreshTokenApiCompleter.completeError(e);
      rethrow;
    }
  }

  Future<void> _clearTokens() async {
    await jwt.clear();
    await aes.clear();
    await rsa.clear();
  }

  Future<void> logout() async {
    await _clearTokens();
  }
}
