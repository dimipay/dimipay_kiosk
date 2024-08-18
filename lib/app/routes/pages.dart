import 'package:dimipay_kiosk/app/pages/test/page.dart';
import 'package:get/get.dart';

import 'package:dimipay_kiosk/app/pages/payment/widget/payment_success.dart';
import 'package:dimipay_kiosk/app/pages/payment/widget/payment_failed.dart';
import 'package:dimipay_kiosk/app/pages/onboard/binding.dart';
import 'package:dimipay_kiosk/app/pages/product/binding.dart';
import 'package:dimipay_kiosk/app/pages/payment/binding.dart';
import 'package:dimipay_kiosk/app/pages/onboard/page.dart';
import 'package:dimipay_kiosk/app/pages/product/page.dart';
import 'package:dimipay_kiosk/app/pages/payment/page.dart';
import 'package:dimipay_kiosk/app/pages/pin/binding.dart';
import 'package:dimipay_kiosk/app/pages/pin/page.dart';
import 'package:dimipay_kiosk/app/routes/routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: Routes.TEST, page: () => const TestPage()),
    GetPage(
      name: Routes.PIN,
      page: () => const PinPage(),
      binding: PinPageBinding(),
    ),
    GetPage(
      name: Routes.ONBOARD,
      page: () => const OnboardPage(),
      binding: OnboardPageBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.PRODUCT,
      page: () => const ProductPage(),
      binding: ProductPageBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.PAYMENT,
      page: () => const PaymentPage(),
      binding: PaymentPageBinding(),
    ),
    GetPage(
      name: Routes.PAYMENT_SUCCESS,
      page: () => const PaymentSuccess(),
    ),
    GetPage(
      name: Routes.PAYMENT_FAILED,
      page: () => const PaymentFailed(),
      binding: PaymentPageBinding(),
    ),
  ];
}
