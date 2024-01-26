import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlertModal extends GetxController {
  static AlertModal get to => Get.find<AlertModal>();

  void show(String message) {
    if (Get.isSnackbarOpen) Get.closeCurrentSnackbar();
    Get.rawSnackbar(
        messageText: Text(message,
            style: DPTypography.header1(color: DPColors.grayscale100)),
        icon: const DPIcons(Symbols.info_rounded, color: DPColors.grayscale100),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        duration: const Duration(seconds: 2),
        borderRadius: 16,
        snackPosition: SnackPosition.TOP,
        backgroundColor: DPColors.primaryNegative,
        animationDuration: const Duration(milliseconds: 500),
        reverseAnimationCurve: Curves.easeOut);
  }
}
