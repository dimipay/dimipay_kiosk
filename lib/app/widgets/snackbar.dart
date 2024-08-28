import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DPAlertModal {
  static void open(String message) {
    BuildContext context = Get.context!;
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;

    if (Get.isSnackbarOpen) Get.closeCurrentSnackbar();
    Get.rawSnackbar(
        messageText: Text(message,
            style: textTheme.header1.copyWith(color: colorTheme.grayscale100)),
        icon: Icon(Icons.info_rounded, color: colorTheme.grayscale100),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        borderRadius: 16,
        snackPosition: SnackPosition.TOP,
        backgroundColor: colorTheme.primaryNegative,
        animationDuration: const Duration(milliseconds: 200),
        reverseAnimationCurve: Curves.easeOut);
  }
}
