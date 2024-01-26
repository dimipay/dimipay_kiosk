import 'package:get/instance_manager.dart';
import 'package:dio/dio.dart';

import 'package:dimipay_kiosk/app/widgets/alert_modal.dart';
import 'package:dimipay_kiosk/app/core/utils/errors.dart';
import 'package:dimipay_kiosk/app/services/auth/model.dart';
import 'package:dimipay_kiosk/app/provider/api_interface.dart';

class AuthRepository {
  final ApiProvider api;

  AuthRepository({ApiProvider? api}) : api = api ?? Get.find<ApiProvider>();

  Future<String> getAccessToken(String passcode) async {
    String url = "/pos-login/";
    Map body = {"passcode": passcode};
    try {
      Response response = await api.post(url, data: body);
      return response.data["accessToken"];
    } on DioException catch (e) {
      var message = e.response?.data["message"];

      AlertModal.to.show(message);
      throw IncorrectPinException(message);
    }
  }

  Future<String> refreshAccessToken(String refreshToken) async {
    String url = "/pos-login/refresh/";
    Map<String, dynamic> headers = {'Authorization': 'Bearer $refreshToken'};
    Response response = await api.post(url, options: Options(headers: headers));
    return response.data['accessToken'];
  }

  // Future<Map> onBoardingAuth(JWTToken accessToken) async {
  //   String url = '/pos-login/onBoarding';
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
