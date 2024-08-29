import 'package:dimipay_kiosk/app/core/utils/errors.dart';
import 'package:dimipay_kiosk/app/provider/api_interface.dart';
import 'package:dimipay_kiosk/app/provider/model/response.dart';
import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';

import 'key_manager/jwt.dart';

class AuthRepository {
  final SecureApiProvider secureApi;

  AuthRepository({SecureApiProvider? secureApi})
      : secureApi = secureApi ?? Get.find<SecureApiProvider>();

  Future<Map> loginWithPasscode({required String passcode}) async {
    String url = '/kiosk/auth/login';

    final body = {'passcode': passcode};

    try {
      DPHttpResponse response = await secureApi.post(
        url,
        data: body,
      );
      return response.data;
    } on DioException catch (e) {
      if (e.response?.data['code'] == 'ERR_PASSCODE_NOT_FOUND') {
        throw PasscodeNotFoundException(message: e.response?.data['message']);
      }
      throw UnknownException(message: e.response?.data['message']);
    }
  }

  ///returns accessToken
  Future<JwtToken> refreshAccessToken(String refreshToken) async {
    String url = "/kiosk/auth/refresh";

    Map<String, dynamic> headers = {
      'Authorization': 'Bearer $refreshToken',
    };
    DPHttpResponse response =
    await secureApi.get(url, options: Options(headers: headers));
    return JwtToken(
        accessToken: response.data['tokens']['accessToken'],
        refreshToken: response.data['tokens']['refreshToken']);
  }

  Future<String> getEncryptionKey(String publicKey,
      String onBoardingToken) async {
    String url = '/kiosk/auth/encryption-key';
    publicKey = publicKey.replaceAll('\n', '\\r\\n');
    Map<String, dynamic> headers = {
      'Dp-Encryption-Public-Key': publicKey,
      'Authorization': 'Bearer $onBoardingToken',
    };
    DPHttpResponse response =
    await secureApi.get(url, options: Options(headers: headers));
    return response.data['encryptionKey'];
  }
}
