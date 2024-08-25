import 'package:dimipay_kiosk/app/core/utils/errors.dart';
import 'package:dimipay_kiosk/app/provider/api_interface.dart';
import 'package:dimipay_kiosk/app/provider/model/response.dart';
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
}
