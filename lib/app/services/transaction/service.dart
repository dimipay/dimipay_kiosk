import 'package:get/get.dart';
import 'dart:async';

import 'package:dimipay_kiosk/app/services/transaction/repository.dart';

class TransactionService extends GetxController {
  static TransactionService get to => Get.find<TransactionService>();

  final TransactionRepository repository;

  TransactionService({TransactionRepository? repository})
      : repository = repository ?? TransactionRepository();

  Future<String> get transactionId async => (await repository.transactionId())!;
}
