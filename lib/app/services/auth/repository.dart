import 'package:get/instance_manager.dart';
import 'package:dio/dio.dart';
import 'dart:developer';

import 'package:dimipay_kiosk/app/provider/api_interface.dart';

class AuthRepository {
  final ApiProvider api;

  AuthRepository({ApiProvider? api}) : api = api ?? Get.find<ApiProvider>();

  Future<String> refreshAccessToken(String refreshToken) async {
    String url = "/pos-login/refresh/";

    Map<String, dynamic> headers = {
      'Authorization': 'Bearer $refreshToken',
    };
    Response response = await api.post(url, options: Options(headers: headers));
    return response.data['accessToken'];
  }
}
