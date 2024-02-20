import 'package:get/instance_manager.dart';
import 'package:dio/dio.dart';

import 'package:dimipay_kiosk/app/widgets/alert_modal.dart';
import 'package:dimipay_kiosk/app/core/utils/errors.dart';
import 'package:dimipay_kiosk/app/services/auth/model.dart';
import 'package:dimipay_kiosk/app/provider/api_interface.dart';

class PaymentRepository {
  final ApiProvider api;

  PaymentRepository({ApiProvider? api}) : api = api ?? Get.find<ApiProvider>();

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
}
