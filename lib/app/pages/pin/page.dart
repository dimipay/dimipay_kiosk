import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:dimipay_kiosk/app/pages/pin/widget/pin_indicator.dart';
import 'package:dimipay_kiosk/app/pages/pin/widget/pin_pad.dart';
import 'package:dimipay_kiosk/app/services/auth/service.dart';
import 'package:dimipay_kiosk/app/pages/pin/controller.dart';

class PinPage extends GetView<PinPageController> {
  const PinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    AuthService.to.isAuthenticated
                        ? "결제 비밀번호 입력"
                        : "결재 단말기 활성화 코드 입력",
                    style: DPTypography.title(
                      color: DPColors.grayscale1000,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    AuthService.to.isAuthenticated
                        ? "안전한 결제를 위해 결제 비밀번호를 입력해주세요."
                        : "관리자 페이지에서 단말기 활성화 코드를 발급하여 입력해주세요",
                    style: DPTypography.header2(
                      color: DPColors.grayscale700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 120),
              const PinIndicator(),
              const SizedBox(height: 120),
              const PinPad(),
            ],
          ),
        ),
      ),
    );
  }
}
