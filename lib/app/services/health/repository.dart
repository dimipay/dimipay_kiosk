import 'package:dio/dio.dart';

import 'package:dimipay_kiosk/app/provider/api_interface.dart';
import 'package:dimipay_kiosk/app/services/health/model.dart';
import 'package:dimipay_kiosk/app/core/utils/errors.dart';

class HealthRepository {
  Future<Health> health(String accessToken) async {
    String url = "/kiosk/health";
    Map<String, dynamic> headers = {'Authorization': 'Bearer $accessToken'};
    try {
      Response response = await ApiProvider.to.get(url, options: Options(headers: headers));
      return Health.fromJson(response.data["data"]);
    } on DioException catch (e) {
      throw NoAccessTokenException(e.response?.data["message"]);
    }
  }
}
