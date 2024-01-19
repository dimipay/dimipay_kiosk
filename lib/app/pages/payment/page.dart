import 'package:dimipay_pos_flutter/app/pages/payment/controller.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:dimipay_pos_flutter/app/widgets/number_controller.dart';
import 'package:dimipay_pos_flutter/app/widgets/number_pad.dart';
import 'package:dimipay_pos_flutter/app/widgets/number_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentPage extends GetView<PaymentPageController> {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NumberController());
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(36),
          child: Wrap(spacing: 36, children: [
            Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: DPColors.grayscale300, width: 1),
                )),
            Text("얼굴 인식 중...",
                style: DPTypography.header1(color: DPColors.grayscale600)),
            // Image.asset(
            //   "assets/images/logo.png",
            //   width: 100,
            // ),
          ])),
      Expanded(
          child: Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 36),
              color: DPColors.grayscale200,
              child: Wrap(
                  alignment: WrapAlignment.start,
                  direction: Axis.vertical,
                  spacing: 24,
                  children: [
                    Container(
                      color: DPColors.grayscale100,
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text("adsf"), Text("adsf")]),
                    ),
                    const Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        children: [Text("adsf"), Text("adsf")])
                  ]))),
      Container(
        padding: const EdgeInsets.all(36),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Wrap(
            direction: Axis.vertical,
            spacing: 8,
            children: [Text("2개 상품"), Text("100,000원")],
          ),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              color: DPColors.primaryBrand,
              child: Text("결재하기"))
        ]),
      )
    ])));
  }
}
