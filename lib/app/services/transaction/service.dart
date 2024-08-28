import 'package:dimipay_kiosk/app/services/kiosk/model.dart';
import 'package:dimipay_kiosk/app/services/transaction/model.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:dimipay_kiosk/app/services/transaction/repository.dart';

class TransactionService extends GetxController {
  TransactionRepository repository;

  TransactionService({TransactionRepository? repository})
      : repository = repository ?? TransactionRepository();

  final _transactionId = Rx<String?>(null);

  String? get transactionId => _transactionId.value;

  Future<String?> generateTransactionId() async {
    try {
      final data = await repository.generateTransactionId();
      _transactionId.value = data['transactionId'];
      return transactionId;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteTransactionId({required String transactionId}) async {
    try {
      await repository.deleteTransactionId(transactionId);
    } catch (e) {
      rethrow;
    }
  }

  Future<TransactionResult> payQR({
    required String transactionId,
    required String dpToken,
    required List<Map<String, dynamic>> formattedProductList,
  }) async {
    try {
      TransactionResult data = await repository.payQR(
        transactionId: transactionId,
        dpToken: dpToken,
        formattedProductList: formattedProductList,
      );

      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<TransactionResult> payFaceSign({
    required String transactionId,
    required String otp,
    required String paymentMethodId,
    required List<Map<String, dynamic>> formattedProductList,
  }) async {
    try {
      TransactionResult data = await repository.payFaceSign(
        transactionId: transactionId,
        otp: otp,
        paymentMethodId: paymentMethodId,
        formattedProductList: formattedProductList,
      );

      return data;
    } catch (e) {
      rethrow;
    }
  }
}
