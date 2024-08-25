import 'package:dimipay_design_kit/interfaces/dimipay_colors.dart';
import 'package:dimipay_design_kit/interfaces/dimipay_typography.dart';
import 'package:dimipay_kiosk/app/pages/product/controller.dart';
import 'package:dimipay_kiosk/app/widgets/barcode_scanner.dart';
import 'package:dimipay_kiosk/app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductPage extends GetView<ProductPageController> {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<DPColors>()!;
    final textTheme = Theme.of(context).extension<DPTypography>()!;

    return BarcodeScanner(
      onScan: (input) async {
        controller.getProduct(barcode: input);
      },
      child: Scaffold(
        body: Column(
          children: [
            _buildHeader(colorTheme, textTheme),
            Expanded(
              child: _buildProductList(colorTheme, textTheme),
            ),
            _buildFooter(colorTheme, textTheme),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(DPColors colorTheme, DPTypography textTheme) {
    return Padding(
      padding: const EdgeInsets.all(36),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: colorTheme.grayscale100,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                color: colorTheme.grayscale300,
                width: 1,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Text(
            '얼굴 인식 중...',
            style: textTheme.header1.copyWith(
              fontWeight: FontWeight.w500,
              color: colorTheme.grayscale800,
            ),
          ),
          const Spacer(),
          _buildAddButton('마이쮸 추가', '8801111187893'),
          const SizedBox(width: 16),
          _buildAddButton('오미자 추가', '8801047289685'),
        ],
      ),
    );
  }

  Widget _buildAddButton(String label, String barcode) {
    return ElevatedButton(
      onPressed: () => controller.getProduct(barcode: barcode),
      child: Text(label),
    );
  }

  Widget _buildProductList(DPColors colorTheme, DPTypography textTheme) {
    return Container(
      padding: const EdgeInsets.all(36),
      color: colorTheme.grayscale200,
      child: Column(
        children: [
          _buildListHeader(colorTheme, textTheme),
          const SizedBox(height: 36),
          Expanded(
            child: Obx(
              () => ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: controller.productItems.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 24),
                itemBuilder: (context, index) => _buildProductItem(
                  controller.productItems[index],
                  colorTheme,
                  textTheme,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListHeader(DPColors colorTheme, DPTypography textTheme) {
    return Row(
      children: [
        Text(
          '상품을 터치해서 삭제할 수 있어요',
          style: textTheme.header1.copyWith(
            fontWeight: FontWeight.w500,
            color: colorTheme.grayscale500,
          ),
        ),
        const Spacer(),
        DPGestureDetectorWithOpacityInteraction(
          onTap: controller.clearProductItems,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: colorTheme.grayscale600,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              '상품 전체 삭제',
              style: textTheme.header2.copyWith(
                color: colorTheme.grayscale100,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductItem(
    dynamic item,
    DPColors colorTheme,
    DPTypography textTheme,
  ) {
    return DPGestureDetectorWithOpacityInteraction(
      onTap: () {},
      child: DPGestureDetectorWithScaleInteraction(
        onTap: () => controller.decreaseProductItemAmount(item.id),
        child: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: colorTheme.grayscale100,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: colorTheme.grayscale300,
              width: 2,
            ),
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: textTheme.header1.copyWith(
                      color: colorTheme.grayscale900,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${item.price}원',
                    style: textTheme.header1.copyWith(
                      color: colorTheme.grayscale700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                '${item.amount}개',
                style: textTheme.header2.copyWith(
                  color: colorTheme.grayscale700,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 32),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: colorTheme.grayscale600,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.remove,
                  color: colorTheme.grayscale100,
                  size: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(DPColors colorTheme, DPTypography textTheme) {
    return Padding(
      padding: const EdgeInsets.all(36),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Text(
                  '${controller.productItems.fold<int>(0, (sum, item) => sum + item.amount)}개 상품',
                  style: textTheme.header1.copyWith(
                    fontWeight: FontWeight.w500,
                    color: colorTheme.grayscale700,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Obx(
                () => Text(
                  '${controller.productItems.fold<int>(0, (sum, item) => sum + item.price * item.amount)}원',
                  style: textTheme.header1.copyWith(
                    fontSize: 36,
                    color: colorTheme.primaryBrand,
                  ),
                ),
              ),
            ],
          ),
          DPButton(
            onTap: () {},
            child: Text(
              "결제하기",
              style: textTheme.header1.copyWith(color: colorTheme.grayscale100),
            ),
          )
        ],
      ),
    );
  }
}
