import 'package:dimipay_kiosk/app/routes/routes.dart';
import 'package:get/get.dart';
import 'dart:developer' as dev;
import 'dart:async';
import 'dart:io';

import 'package:dimipay_kiosk/app/services/auth/repository.dart';
import 'package:dimipay_kiosk/app/services/auth/model.dart';

class AuthService extends GetxController {
  final AuthRepository repository;
  final Rx<JWTToken> _jwtToken = Rx(JWTToken());
  final Rx<JWTToken> _onboardingToken = Rx(JWTToken());

  Completer<void> _refreshTokenApiCompleter = Completer()..complete();

  AuthService({AuthRepository? repository})
      : repository = repository ?? AuthRepository();

  // Future<AuthService> init() async {
  //   _jwtToken.value =
  //       JWTToken(accessToken: accessToken, refreshToken: refreshToken);

  //   return this;
  // }

  ///Throws exception and route to loginpage if refresh faild
  Future<void> refreshAcessToken() async {
    // refreshTokenApi의 동시 다발적인 호출을 방지하기 위해 completer를 사용함. 동시 다발적으로 이 함수를 호출해도 api는 1번만 호출 됨.
    if (_refreshTokenApiCompleter.isCompleted == false) {
      return _refreshTokenApiCompleter.future;
    }

    //첫 호출(null)이거나 이미 완료된 호출(completed completer)일 경우 새 객체 할당
    _refreshTokenApiCompleter = Completer();
    // repository.refreshAccessToken();
  }
}
