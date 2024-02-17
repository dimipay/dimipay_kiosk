import 'package:get/instance_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
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
    String url = "/pos-login/refresh";
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

  Future<Kiosk> getHealth(String accessToken) async {
    String url = "/pos-login/health";
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

  Future<List<User>?> findFace(String accessToken, String imagePath) async {
    String url = "/auth/face/find";
    Map<String, dynamic> headers = {'Authorization': 'Bearer $accessToken'};
    try {
      FormData formData;
      if (kDebugMode) {
        var bytes = (await rootBundle.load(imagePath)).buffer.asUint8List();
        formData = FormData.fromMap({
          "image": MultipartFile.fromBytes(bytes, filename: "face.jpg"),
        });
      } else {
        formData = FormData.fromMap({
          "image":
              await MultipartFile.fromFile(imagePath, filename: "face.jpg"),
        });
      }

      Response response = await api.post(url,
          data: formData,
          options: Options(
              headers: headers,
              contentType: Headers.multipartFormDataContentType));
      return response.data["users"]
          .map<User>((json) => User.fromJson(json))
          .toList();
    } on DioException catch (e) {
      if (e.response?.data["code"] == "ERR_FACE_NOT_FOUND") return null;
      AlertModal.to.show(e.response?.data["message"]);
      throw NoAccessTokenException(e.response?.data["message"]);
    }
  }
}
