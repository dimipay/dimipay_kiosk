import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:flutter/widgets.dart';

import 'package:dimipay_kiosk/app/pages/product/controller.dart';

class ProductListItem extends StatelessWidget {
  const ProductListItem({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    if (ProductPageController.to.productList[id] == null) {
      return const SizedBox();
    }

    return Column(children: [
      const SizedBox(height: 36),
      GestureDetector(
          onTapDown: (_) => ProductPageController.to.pressedButton = "${id}box",
          onTapCancel: () => ProductPageController.to.pressedButton = "",
          onTapUp: (_) {
            ProductPageController.to.pressedButton = "";
            ProductPageController.to.deleteProduct(id);
          },
          child: Obx(() => Container(
              decoration: BoxDecoration(
                  color: ProductPageController.to.pressedButton == "${id}box"
                      ? DPColors.grayscale300
                      : DPColors.grayscale100,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      width: 2,
                      style: BorderStyle.solid,
                      color: DPColors.grayscale300,
                      strokeAlign: BorderSide.strokeAlignInside)),
              padding: const EdgeInsets.all(28),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                        spacing: 6,
                        direction: Axis.vertical,
                        alignment: WrapAlignment.start,
                        children: [
                          Text(ProductPageController.to.productList[id]!.name,
                              style: DPTypography.pos
                                  .itemTitle(color: DPColors.grayscale900)),
                          Text(
                              "${ProductPageController.to.productList[id]!.price}원",
                              style: DPTypography.pos.itemDescription())
                        ]),
                    Wrap(
                        spacing: 32,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Obx(() => Text(
                              "${ProductPageController.to.productList[id]!.count}개",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: DPTypography.weight.medium,
                                  letterSpacing: -0.6,
                                  color: DPColors.grayscale600))),
                          GestureDetector(
                              onTapDown: (_) =>
                                  ProductPageController.to.pressedButton = id,
                              onTapCancel: () =>
                                  ProductPageController.to.pressedButton = "",
                              onTapUp: (_) {
                                ProductPageController.to.pressedButton = "";
                                ProductPageController.to.removeProduct(id);
                              },
                              child: Obx(() => Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                      color: ProductPageController
                                                  .to.pressedButton ==
                                              id
                                          ? DPColors.grayscale800
                                          : DPColors.grayscale600,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: const DPIcons(Symbols.remove,
                                      size: 24, color: DPColors.grayscale200))))
                        ])
                  ]))))
    ]);
  }
}

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            color: DPColors.grayscale200,
            child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 36),
                child: Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("상품을 터치해서 삭제할 수 있어요",
                            style: DPTypography.pos
                                .itemDescription(color: DPColors.grayscale500)),
                        GestureDetector(
                            onTapDown: (_) => ProductPageController
                                .to.pressedButton = "clean",
                            onTapCancel: () =>
                                ProductPageController.to.pressedButton = "",
                            onTapUp: (_) {
                              ProductPageController.to.pressedButton = "";
                              ProductPageController.to.cleanProduct();
                            },
                            child: Obx(() => Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                                decoration: BoxDecoration(
                                  color:
                                      ProductPageController.to.pressedButton ==
                                              "clean"
                                          ? DPColors.grayscale800
                                          : DPColors.grayscale600,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Text("상품 전체 삭제",
                                    style: TextStyle(
                                        color: DPColors.grayscale100,
                                        fontWeight: DPTypography.weight.medium,
                                        fontSize: 20,
                                        height: 1.25)))))
                      ]),
                  Obx(() => Column(
                        children: ProductPageController.to.productList.entries
                            .map((e) => ProductListItem(id: e.key))
                            .toList(),
                      ))
                ]))));
  }
}
