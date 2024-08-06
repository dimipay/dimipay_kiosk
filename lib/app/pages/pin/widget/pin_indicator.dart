import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:dimipay_kiosk/app/pages/pin/controller.dart';

class PinIndicator extends StatelessWidget {
  const PinIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Wrap(
          spacing: 24,
          alignment: WrapAlignment.center,
          children: [
            for (int i = 0; i < 4; i++)
              Container(
                height: 28,
                width: 28,
                decoration: BoxDecoration(color: i < PinPageController.to.inputLength ? DPColors.grayscale800 : DPColors.grayscale300, borderRadius: BorderRadius.circular(14)),
              ),
          ],
        );
      },
    );
  }
}
