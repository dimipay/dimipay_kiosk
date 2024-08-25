import 'package:dimipay_kiosk/app/core/utils/errors.dart';
import 'package:dimipay_kiosk/app/provider/api_interface.dart';
import 'package:dimipay_kiosk/app/provider/model/response.dart';
import 'package:dimipay_kiosk/app/services/kiosk/model.dart';
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
      if (e.response?.data['code'] == 'ERR_TOKEN_ERROR') {
        throw TokenErrorException(message: e.response?.data['message']);
      }
      if (e.response?.data['code'] == 'ERR_CLIENT_NOT_FOUND') {
        throw TokenExpiredException(message: e.response?.data['message']);
      }
      if (e.response?.data['code'] == 'ERR_TOKEN_NOT_FOUND') {
        throw TokenNotFoundException(message: e.response?.data['message']);
      }
      if (e.response?.data['code'] == 'ERR_UNAUTHENTICATED') {
        throw UnauthenticatedException(message: e.response?.data['message']);
      }
      if (e.response?.data['code'] == 'ERR_WRONG_TOKEN_TYPE') {
        throw WrongTokenTypeException(message: e.response?.data['message']);
      }
      if (e.response?.data['code'] == 'ERR_WRONG_CLIENT_TYPE') {
        throw WrongClientTypeException(message: e.response?.data['message']);
      }
      if (e.response?.data['code'] == 'ERR_NO_TRANSACTION_ID_FOUND') {
        throw NoTransactionIdFoundException(
            message: e.response?.data['message']);
      }
      rethrow;
    }
  }

  Future<Product> getProduct({required String barcode}) async {
    String url = '/product/$barcode';

    try {
      DPHttpResponse response = await secureApi.get(url);

      return Product.fromJson(response.data["product"]);
    } on DioException catch (e) {
      if (e.response?.data['code'] == 'ERR_PRODUCT_NOT_FOUND') {
        throw ProductNotFoundException(message: e.response?.data['message']);
      }
      if (e.response?.data['code'] == 'ERR_DISABLED_PRODUCT') {
        throw DisabledProductException(message: e.response?.data['message']);
      }
      rethrow;
    }
  }
}
