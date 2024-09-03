import 'package:dimipay_kiosk/app/pages/product/controller.dart';
import 'package:dimipay_kiosk/app/services/face_sign/service.dart';
import 'package:dimipay_kiosk/app/services/kiosk/service.dart';
import 'package:dimipay_kiosk/app/services/transaction/service.dart';
import 'package:get/get.dart';

class ProductPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductPageController());
    Get.lazyPut(() => KioskService());
    Get.lazyPut(() => TransactionService());
    Get.lazyPut(() => FaceSignService());
  }
}
