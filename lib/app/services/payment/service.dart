// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
// import 'dart:async';

// import 'package:dimipay_kiosk/app/services/payment/repository.dart';
// import 'package:dimipay_kiosk/app/services/auth/service.dart';

// class PaymentService extends GetxController {
//   static PaymentService get to => Get.find<PaymentService>();

//   final PaymentRepository repository;

//   PaymentService({PaymentRepository? repository})
//       : repository = repository ?? PaymentRepository();

//   Future<void> checkPin() async {
//     await repository.paymentPinAuthURL(AuthService.to.accessToken!);
//   }
// }
