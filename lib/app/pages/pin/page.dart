import 'package:dimipay_pos_flutter/app/pages/pin/controller.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:dimipay_pos_flutter/app/widgets/num_pad.dart';
import 'package:dimipay_pos_flutter/app/widgets/page_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PinPage extends GetView<PinPageController> {
  const PinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DPColors.grayscale100,
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  "결재 단말기 활성화 코드 입력",
                  style: DPTypography.title(color: DPColors.grayscale1000),
                ),
                const SizedBox(height: 16),
                Text("관리자 페이지에서 단말기 활성화 코드를 발급하여 입력해주세요",
                    style: DPTypography.header2(color: DPColors.grayscale700))
              ],
            ),
            const SizedBox(height: 120),
            const PageIndicator(),
            const SizedBox(height: 120),
            const NumPad(),
          ],
        ),
      ),
    );
  }
}
