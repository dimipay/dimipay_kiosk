import 'package:dimipay_kiosk/app/pages/pin/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PinPage extends GetView<PinPageController> {
  const PinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => controller.loginWithPasscode(passcode: '3071'),
          child: Text('gogo'),
        ),
      ),
    );
  }
}
