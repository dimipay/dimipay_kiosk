import 'package:dimipay_pos_flutter/app/pages/product/binding.dart';
import 'package:dimipay_pos_flutter/app/pages/product/page.dart';
import 'package:dimipay_pos_flutter/app/pages/pin/binding.dart';
import 'package:dimipay_pos_flutter/app/pages/pin/page.dart';
import 'package:dimipay_pos_flutter/app/routes/routes.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = [
    // GetPage(name: Routes.test, page: () => const TestPage()),
    // GetPage(name: Routes.home, page: () => const HomePage()),
    GetPage(
        name: Routes.product,
        page: () => const ProductPage(),
        binding: ProductPageBinding()),
    GetPage(
        name: Routes.pin,
        page: () => const PinPage(),
        binding: PinPageBinding()),
    // GetPage(name: Routes.onboard, page: () => const OnboardPage(), binding: OnboardingPageBinding()),
  ];
}
