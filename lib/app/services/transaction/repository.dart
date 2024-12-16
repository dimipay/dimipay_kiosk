import 'package:dimipay_kiosk/app/core/utils/errors.dart';
import 'package:dimipay_kiosk/app/provider/api_interface.dart';
import 'package:dimipay_kiosk/app/provider/model/response.dart';
import 'package:dimipay_kiosk/app/services/transaction/model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class TransactionRepository {
  final SecureApiProvider secureApi;

  TransactionRepository({SecureApiProvider? secureApi})
      : secureApi = secureApi ?? Get.find<SecureApiProvider>();

  Future<Map<String, dynamic>> generateTransactionId() async {
    String url = '/kiosk/transaction/id';

    try {
      DPHttpResponse response = await secureApi.get(url);

      return {
        'transactionId': response.data['transactionId'],
      };
    } on DioException catch (e) {
      throw UnknownException(message: e.response?.data['message']);
    }
  }

  Future<TransactionResult> payQR({
    required String dpToken,
    required String transactionId,
    required List<Map<String, dynamic>> formattedProductList,
  }) async {
    String url = '/kiosk/qr';

    try {
      DPHttpResponse response = await secureApi.post(
        url,
        data: {
          'products': formattedProductList,
        },
        options: Options(
            headers: {'Transaction-ID': transactionId, 'DP-Token': dpToken}),
      );

      return TransactionResult.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.data['code'] == 'ERR_NO_TRANSACTION_ID_FOUND') {
        throw NoTransactionIdFoundException(
            message: e.response?.data['message']);
      }
      if (e.response?.data['code'] == 'ERR_FORBIDDEN_USER') {
        throw ForbiddenUserException(message: e.response?.data['message']);
      }
      if (e.response?.data['code'] == 'ERR_WRONG_PAY_TOKEN') {
        throw WrongPayTokenException(message: e.response?.data['message']);
      }
      if (e.response?.data['code'] == 'ERR_UNKNOWN_PRODUCT') {
        throw UnknownProductException(message: e.response?.data['message']);
      }
      if (e.response?.data['code'] == 'ERR_FAILED_TO_CANCEL_TRANSACTION') {
        throw FailedToCancelTransactionException(
            message: e.response?.data['message']);
      }
      throw UnknownException(message: e.response?.data['message']);
    }
  }

  Future<TransactionResult> payFaceSign({
    required String transactionId,
    required List<Map<String, dynamic>> formattedProductList,
    required String paymentMethodId,
    required String otp,
  }) async {
    String url = '/kiosk/face-sign/payments/approve';

    try {
      DPHttpResponse response = await secureApi.post(
        url,
        data: {
          'products': formattedProductList,
          'paymentMethodId': paymentMethodId,
        },
        options: Options(headers: {
          'Transaction-ID': transactionId,
          'DP-PAYMENT-PIN-OTP': otp
        }),
      );

      return TransactionResult.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.data['code'] == 'ERR_NO_TRANSACTION_ID_FOUND') {
        throw NoTransactionIdFoundException(
            message: e.response?.data['message']);
      }
      if (e.response?.data['code'] == 'ERR_INVALID_OTP') {
        throw InvalidOTPException(message: e.response?.data['message']);
      }
      if (e.response?.data['code'] == 'ERR_FORBIDDEN_USER') {
        throw ForbiddenUserException(message: e.response?.data['message']);
      }
      if (e.response?.data['code'] == 'ERR_UNKNOWN_PRODUCT') {
        throw UnknownProductException(message: e.response?.data['message']);
      }
      if (e.response?.data['code'] == 'ERR_FAILED_TO_CANCEL_TRANSACTION') {
        throw FailedToCancelTransactionException(
            message: e.response?.data['message']);
      }
      throw UnknownException(message: e.response?.data['message']);
    }
  }
}
