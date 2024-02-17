import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlertModal extends GetxController {
  static AlertModal get to => Get.find<AlertModal>();

  Future<void> show(String message, {int duration = 2}) async {
    if (Get.isSnackbarOpen) Get.closeCurrentSnackbar();
    Get.rawSnackbar(
        messageText: Text(message,
            style: DPTypography.header1(color: DPColors.grayscale100)),
        icon: const DPIcons(Symbols.info_rounded, color: DPColors.grayscale100),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        duration: Duration(seconds: duration),
        borderRadius: 16,
        snackPosition: SnackPosition.TOP,
        backgroundColor: DPColors.primaryNegative,
        animationDuration: const Duration(milliseconds: 250),
        reverseAnimationCurve: Curves.easeOut);
  }
}
