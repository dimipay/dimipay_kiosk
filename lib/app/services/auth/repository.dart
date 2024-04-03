import 'package:get/instance_manager.dart';
import 'package:dio/dio.dart';

import 'package:dimipay_kiosk/app/widgets/alert_modal.dart';
import 'package:dimipay_kiosk/app/core/utils/errors.dart';
import 'package:dimipay_kiosk/app/services/auth/model.dart';
import 'package:dimipay_kiosk/app/provider/api_interface.dart';

class AuthRepository {
  final ApiProvider api;

  AuthRepository({ApiProvider? api}) : api = api ?? Get.find<ApiProvider>();

  Future<Login> authLogin(String passcode) async {
    String url = "/kiosk/auth/login";
    Map body = {"passcode": passcode};
    try {
      Response response = await api.post(url, data: body);
      return Login.fromJson(response.data["data"]);
    } on DioException catch (e) {
      AlertModal.to.show(e.response?.data["message"]);
      throw IncorrectPinException(e.response?.data["message"]);
    }
  }

  Future<JWTToken> authRefresh(String refreshToken) async {
    String url = "/kiosk/auth/refresh";
    Map<String, dynamic> headers = {'Authorization': 'Bearer $refreshToken'};
    try {
      Response response =
          await api.get(url, options: Options(headers: headers));
      return JWTToken.fromJson(response.data["data"]["tokens"]);
    } on DioException catch (e) {
      AlertModal.to.show(e.response?.data["message"]);
      throw NoRefreshTokenException();
    }
  }
}
