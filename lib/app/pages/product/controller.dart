import 'package:get/get.dart';

class ProductPageController extends GetxController {
  static ProductPageController get to => Get.find<ProductPageController>();

  final _pressedButton = "".obs;
  String get pressedButton => _pressedButton.value;
  set pressedButton(String value) => _pressedButton.value = value;
}
