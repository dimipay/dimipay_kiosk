import 'package:dio/dio.dart';

import 'package:dimipay_kiosk/app/widgets/alert_modal.dart';
import 'package:dimipay_kiosk/app/core/utils/errors.dart';
import 'package:dimipay_kiosk/app/services/auth/model.dart';
import 'package:dimipay_kiosk/app/provider/api_interface.dart';

class AuthRepository {
  Future<Login> authLogin(String passcode) async {
    String url = "/kiosk/auth/login";
    try {
      Response response = await ApiProvider.to.post(
        url,
        data: {
          "passcode": passcode,
        },
      );
      return Login.fromJson(response.data["data"]);
    } on DioException catch (e) {
      AlertModal.to.show(e.response?.data["message"]);
      throw IncorrectPinException(e.response?.data["message"]);
    }
  }

  Future<JWTToken> authRefresh(String refreshToken) async {
    String url = "/kiosk/auth/refresh";
    try {
      Response response = await ApiProvider.to.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $refreshToken',
          },
        ),
      );
      return JWTToken.fromJson(response.data["data"]["tokens"]);
    } on DioException catch (e) {
      AlertModal.to.show(e.response?.data["message"]);
      throw NoRefreshTokenException();
    }
  }

  Future<String?> authEncryptionKey(String rsaKey) async {
    String url = "/kiosk/auth/encryption-key";
    try {
      Response response = await ApiProvider.to.get(
        url,
        options: Options(
          headers: {
            "Encryption-Public-Key": rsaKey,
          },
        ),
      );
      return response.data["data"]["encryptionKey"];
    } on DioException catch (e) {
      AlertModal.to.show(e.response?.data["message"]);
      throw NoAccessTokenException(e.response?.data["message"]);
    }
  }
}
