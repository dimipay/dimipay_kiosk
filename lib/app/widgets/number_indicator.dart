import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:dimipay_pos_flutter/app/widgets/number_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NumberIndicator extends StatelessWidget {
  const NumberIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => NumberController());

    return Wrap(
      spacing: 24,
      alignment: WrapAlignment.center,
      children: [
        for (int i = 0; i < 4; i++)
          Obx(() {
            print(Get.find<NumberController>().password.length);
            return Container(
              height: 28,
              width: 28,
              decoration: BoxDecoration(
                color: i < Get.find<NumberController>().password.length
                    ? DPColors.grayscale800
                    : DPColors.grayscale300,
                borderRadius: BorderRadius.circular(14),
              ),
            );
          }),
      ],
    );
  }
}
