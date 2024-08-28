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
            case PinPageType.facesign:
              return const FaceSignPinPage();
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
      headerText: '결제 단말기 활성화 코드 입력',
      subText: '관리자 페이지에서 단말기 활성화 코드를 발급하여 입력해주세요.',
      onPinComplete: controller.loginWithPasscode,
      popBtnAvailable: false,
    );
  }
}

class FaceSignPinPage extends GetView<PinPageController> {
  const FaceSignPinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PinPageBase(
      headerText: '결제 비밀번호 입력',
      subText: '안전한 결제를 위해 결제 비밀번호를 입력해주세요.',
      onPinComplete: controller.payFaceSign,
      popBtnAvailable: true,
    );
  }
}
