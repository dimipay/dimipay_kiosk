import 'package:dimipay_kiosk/app/core/utils/errors.dart';
import 'package:dimipay_kiosk/app/provider/api_interface.dart';
import 'package:dimipay_kiosk/app/provider/model/response.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class KioskRepository {
  final SecureApiProvider secureApi;

  KioskRepository({SecureApiProvider? secureApi})
      : secureApi = secureApi ?? Get.find<SecureApiProvider>();

  Future<Map> getHealth() async {
    String url = '/health';

    try {
      DPHttpResponse response = await secureApi.get(url);

      String status = response.data["status"];

      return {"status": status};
    } on DioException catch (e) {
      if (e.response?.data['code'] == 'ERR_WRONG_TRANSACTION_ID') {
        throw WrongTransactionIdException(message: e.response?.data['message']);
      }
      if (e.response?.data['code'] == 'ERR_CLIENT_DISABLED') {
        throw ClientDisabledException(message: e.response?.data['message']);
      }
      if (e.response?.data['code'] == 'ERR_WRONG_CLIENT_TYPE') {
        throw WrongClientTypeException(message: e.response?.data['message']);
      }
      if (e.response?.data['code'] == 'ERR_CLIENT_NOT_FOUND') {
        throw ClientNotFoundException(message: e.response?.data['message']);
      }
      rethrow;
    }
  }
}
