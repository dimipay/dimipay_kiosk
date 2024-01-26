import 'package:dimipay_kiosk/app/pages/pin/binding.dart';
import 'package:dimipay_kiosk/app/pages/pin/page.dart';
import 'package:dimipay_kiosk/app/pages/onboard/binding.dart';
import 'package:dimipay_kiosk/app/pages/onboard/page.dart';
import 'package:dimipay_kiosk/app/pages/product/binding.dart';
import 'package:dimipay_kiosk/app/pages/product/page.dart';
import 'package:dimipay_kiosk/app/pages/payment/binding.dart';
import 'package:dimipay_kiosk/app/pages/payment/page.dart';
import 'package:dimipay_kiosk/app/routes/routes.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = [
    GetPage(
        name: Routes.PIN,
        page: () => const PinPage(),
        binding: PinPageBinding()),
    GetPage(
        name: Routes.ONBOARD,
        page: () => const OnboardPage(),
        binding: OnboardPageBinding()),
    GetPage(
        name: Routes.PRODUCT,
        page: () => const ProductPage(),
        binding: ProductPageBinding()),
    GetPage(
        name: Routes.PAYMENT,
        page: () => const PaymentPage(),
        binding: PaymentPageBinding()),
  ];
}
