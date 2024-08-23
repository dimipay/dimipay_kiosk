import 'package:dimipay_kiosk/app/pages/payment/payment_failed/page.dart';
import 'package:dimipay_kiosk/app/pages/payment/payment_success/page.dart';
import 'package:dimipay_kiosk/app/pages/test/page.dart';
import 'package:get/get.dart';

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
      gestureWidth: (_) => 0,
    ),
    GetPage(
      name: Routes.ONBOARDING,
      page: () => const OnboardingPage(),
      binding: OnboardPageBinding(),
      transition: Transition.cupertino,
      gestureWidth: (_) => 0,
    ),
    GetPage(
      name: Routes.PRODUCT,
      page: () => const ProductPage(),
      binding: ProductPageBinding(),
      transition: Transition.cupertino,
      gestureWidth: (_) => 0,
    ),
    GetPage(
      name: Routes.PAYMENT,
      page: () => const PaymentPage(),
      binding: PaymentPageBinding(),
      gestureWidth: (_) => 0,
    ),
    GetPage(
      name: Routes.PAYMENT_SUCCESS,
      page: () => const PaymentSuccessPage(),
      gestureWidth: (_) => 0,
    ),
    GetPage(
      name: Routes.PAYMENT_FAILED,
      page: () => const PaymentFailedPage(),
      binding: PaymentPageBinding(),
      gestureWidth: (_) => 0,
    ),
  ];
}
