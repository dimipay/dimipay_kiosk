import 'package:dimipay_kiosk/app/core/utils/errors.dart';
import 'package:dimipay_kiosk/app/provider/api_interface.dart';
import 'package:dimipay_kiosk/app/provider/model/response.dart';
import 'package:dimipay_kiosk/app/services/kiosk/model.dart';
import 'package:dimipay_kiosk/app/widgets/snackbar.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class TransactionRepository {
  final SecureApiProvider secureApi;

  TransactionRepository({SecureApiProvider? secureApi})
      : secureApi = secureApi ?? Get.find<SecureApiProvider>();

  Future<Map<String, dynamic>> generateTransactionId() async {
    String url = '/transaction/id';

    try {
      DPHttpResponse response = await secureApi.get(url);

      return {
        'transactionId': response.data['transactionId'],
      };
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<void> deleteTransactionId(String transactionId) async {
    String url = '/transaction/id/$transactionId';

    try {
      await secureApi.delete(url);
    } on DioException catch (e) {
      if (e.response?.data['code'] == 'ERR_DELETING_TRANSACTION_IF_NOT_FOUND') {
        throw DeletingTransactionIfNotFoundException(
            message: e.response?.data['message']);
      }
      rethrow;
    }
  }

  Future<void> payQR({
    required String dpToken,
    required String transactionId,
    required List<Map<String, dynamic>> formattedProductList,
  }) async {
    String url = '/qr';

    try {
      await secureApi.post(
        url,
        data: {
          'products': formattedProductList,
        },
        options: Options(
            headers: {'Transaction-ID': transactionId, 'DP-Token': dpToken}),
      );
    } on DioException catch (e) {
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
}
