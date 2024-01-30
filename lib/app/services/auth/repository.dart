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
}
