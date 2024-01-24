import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:dimipay_pos_flutter/app/pages/product/widget/payment_desk.dart';
import 'package:dimipay_pos_flutter/app/pages/product/widget/payment_bar.dart';
import 'package:dimipay_pos_flutter/app/pages/product/controller.dart';
import 'package:material_symbols_icons/symbols.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(height: 36),
      Container(
          decoration: BoxDecoration(
              color: DPColors.grayscale100,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                  width: 2,
                  style: BorderStyle.solid,
                  color: DPColors.grayscale300,
                  strokeAlign: BorderSide.strokeAlignInside)),
          padding: const EdgeInsets.all(28),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Wrap(
                spacing: 6,
                direction: Axis.vertical,
                alignment: WrapAlignment.start,
                children: [
                  Text("롯데) 옥동자 밀크",
                      style: DPTypography.pos
                          .itemTitle(color: DPColors.grayscale900)),
                  Text("320원", style: DPTypography.pos.itemDescription())
                ]),
            Wrap(
                spacing: 32,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text("1개",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: DPTypography.weight.medium,
                          letterSpacing: -0.6,
                          color: DPColors.grayscale600)),
                  Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: DPColors.grayscale600,
                          borderRadius: BorderRadius.circular(8)),
                      child: const DPIcons(Symbols.remove,
                          size: 24, color: DPColors.grayscale100))
                ])
          ]))
    ]);
  }
}

class ProductPage extends GetView<ProductPageController> {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      const ProductBar(),
      Expanded(
          child: Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 36),
              color: DPColors.grayscale200,
              child: Column(children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("상품을 터치해서 삭제할 수 있어요",
                          style: DPTypography.pos
                              .itemDescription(color: DPColors.grayscale500)),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          decoration: BoxDecoration(
                            color: DPColors.grayscale600,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Text("상품 전체 삭제",
                              style: TextStyle(
                                  color: DPColors.grayscale100,
                                  fontWeight: DPTypography.weight.medium,
                                  fontSize: 20,
                                  height: 1.25)))
                    ]),
                ProductItem(),
                ProductItem(),
                ProductItem(),
              ]))),
      const ProductDesk()
    ])));
  }
}
