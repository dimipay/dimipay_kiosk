import 'package:get/instance_manager.dart';
import 'package:dio/dio.dart';

import 'package:dimipay_kiosk/app/widgets/alert_modal.dart';
import 'package:dimipay_kiosk/app/core/utils/errors.dart';
import 'package:dimipay_kiosk/app/services/auth/model.dart';
import 'package:dimipay_kiosk/app/provider/api_interface.dart';

class AuthRepository {
  final ApiProvider api;

  AuthRepository({ApiProvider? api}) : api = api ?? Get.find<ApiProvider>();

  Future<JWTToken> login(String passcode) async {
    String url = "/pos-login/";
    Map body = {"passcode": passcode};
    try {
      Response response = await api.post(url, data: body);
      return JWTToken(
          accessToken: response.data["accessToken"],
          refreshToken: response.data["refreshToken"]);
    } on DioException catch (e) {
      AlertModal.to.show(e.response?.data["message"]);
      throw IncorrectPinException(e.response?.data["message"]);
    }
  }

  Future<String> refreshAccessToken(String refreshToken) async {
    String url = "/pos-login/refresh/";
    Map<String, dynamic> headers = {'Authorization': 'Bearer $refreshToken'};
    try {
      Response response =
          await api.post(url, options: Options(headers: headers));
      return response.data['accessToken'];
    } on DioException catch (e) {
      AlertModal.to.show(e.response?.data["message"]);
      throw NoRefreshTokenException();
    }
  }

  Future<Kiosk> getKioskHealth(String accessToken) async {
    String url = "/pos-login/health/";
    Map<String, dynamic> headers = {'Authorization': 'Bearer $accessToken'};
    try {
      Response response =
          await api.get(url, options: Options(headers: headers));
      return Kiosk.fromJson(response.data);
    } on DioException catch (e) {
      AlertModal.to.show(e.response?.data["message"]);
      throw NoAccessTokenException(e.response?.data["message"]);
    }
  }

  // Future<Map> onBoardingAuth(JWTToken accessToken) async {
  //   String url = '/pos-login/';
  //   try {
  //     Response response = await api.post(url, data: body);
  //     return response.data['accessToken'];
  //   } on DioException catch (e) {
  //     switch (e.response?.statusCode) {
  //       case 400:
  //         switch (e.response?.data['code']) {
  //           case 'ERR_PIN_MISMATCH':
  //             throw IncorrectPinException(
  //                 e.response?.data['message'], e.response?.data['left']);
  //           case 'PIN_LOCKED':
  //             throw PinLockException(e.response?.data['message']);
  //         }
  //         break;
  //       case 401:
  //         throw OnboardingTokenException('구글 로그인을 다시 진행해주세요');
  //     }
  //   }
  //   return {};
  // }
}
