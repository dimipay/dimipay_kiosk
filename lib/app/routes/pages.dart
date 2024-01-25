import 'package:dimipay_pos_flutter/app/pages/pin/binding.dart';
import 'package:dimipay_pos_flutter/app/pages/pin/page.dart';
import 'package:dimipay_pos_flutter/app/pages/onboard/binding.dart';
import 'package:dimipay_pos_flutter/app/pages/onboard/page.dart';
import 'package:dimipay_pos_flutter/app/pages/product/binding.dart';
import 'package:dimipay_pos_flutter/app/pages/product/page.dart';
import 'package:dimipay_pos_flutter/app/routes/routes.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = [
    GetPage(
        name: Routes.pin,
        page: () => const PinPage(),
        binding: PinPageBinding()),
    GetPage(
        name: Routes.onboard,
        page: () => const OnboardPage(),
        binding: OnboardPageBinding()),
    GetPage(
        name: Routes.product,
        page: () => const ProductPage(),
        binding: ProductPageBinding()),
  ];
}
