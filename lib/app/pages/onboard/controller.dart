import 'package:get/get.dart';

import 'package:dimipay_kiosk/app/services/product/service.dart';
import 'package:dimipay_kiosk/app/services/auth/service.dart';
import 'package:dimipay_kiosk/app/services/auth/model.dart';

class OnboardPageController extends GetxController {
  static OnboardPageController get to => Get.find<OnboardPageController>();

  final Rx<Kiosk?> kiosk = Rx(null);

  @override
  Future<void> onInit() async {
    super.onInit();
    kiosk.value =
        await AuthService.to.repository.getHealth(AuthService.to.accessToken!);
    Get.lazyPut(() => ProductService());
  }
}
