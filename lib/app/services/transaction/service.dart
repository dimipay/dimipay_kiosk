import 'package:get/get.dart';
import 'dart:async';

import 'package:dimipay_kiosk/app/services/transaction/repository.dart';

class TransactionService extends GetxController {
  static TransactionService get to => Get.find<TransactionService>();

  final TransactionRepository repository;
  String? _transactionId;

  TransactionService({TransactionRepository? repository})
      : repository = repository ?? TransactionRepository();

  Future<String> get transactionId async {
    print(_transactionId);
    _transactionId = _transactionId ?? await repository.transactionId();
    return _transactionId!;
  }

  Future<void> refreshTransactionId() async {
    _transactionId = await repository.transactionId();
  }

  void deleteTransactionId() {
    _transactionId = null;
  }
}
