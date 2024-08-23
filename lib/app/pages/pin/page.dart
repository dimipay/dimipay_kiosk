import 'package:dimipay_kiosk/app/pages/pin/controller.dart';
import 'package:dimipay_kiosk/app/pages/pin/widgets/pin_page_base.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PinPage extends GetView<PinPageController> {
  const PinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          switch (controller.pinPageType) {
            case PinPageType.login:
              return const LoginPinPage();
            default:
              return const LoginPinPage();
          }
        },
      ),
    );
  }
}

class LoginPinPage extends GetView<PinPageController> {
  const LoginPinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PinPageBase(
      headerText: '결재 단말기 활성화 코드 입력',
      subText: '관리자 페이지에서 단말기 활성화 코드를 발급하여 입력해주세요',
      onPinComplete: controller.loginWithPasscode,
    );
  }
}
