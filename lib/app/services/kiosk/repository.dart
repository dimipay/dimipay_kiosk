import 'package:get/instance_manager.dart';
import 'package:dio/dio.dart';

import 'package:dimipay_kiosk/app/provider/api_interface.dart';
import 'package:dimipay_kiosk/app/services/kiosk/model.dart';

class KioskRepository {
  final ApiProvider api;

  KioskRepository({ApiProvider? api}) : api = api ?? Get.find<ApiProvider>();

  Future<Kiosk> getKioskHealth(String accessToken) async {
    String url = "/pos-login/health/";
    Map<String, dynamic> headers = {'Authorization': 'Bearer $accessToken'};
    Response response = await api.post(url, options: Options(headers: headers));
    return response.data;
  }
}
