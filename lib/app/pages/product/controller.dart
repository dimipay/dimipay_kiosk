import 'package:dimipay_kiosk/app/core/utils/errors.dart';
import 'package:dimipay_kiosk/app/services/kiosk/model.dart';
import 'package:dimipay_kiosk/app/services/kiosk/service.dart';
import 'package:dimipay_kiosk/app/widgets/snackbar.dart';
import 'package:get/get.dart';

class ProductPageController extends GetxController {
  final String? firstProduct = Get.arguments as String?;
  KioskService kioskService = Get.find<KioskService>();

  final RxList<ProductItem> productItems = <ProductItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    if (firstProduct != null) {
      getProduct(barcode: firstProduct!);
    }
  }

  Future<Product?> getProduct({required String barcode}) async {
    try {
      Product data = await kioskService.getProduct(barcode: barcode);
      addOrUpdateProductItem(data);
      return data;
    } on ProductNotFoundException catch (e) {
      DPAlertModal.open(e.message);
    } on DisabledProductException catch (e) {
      DPAlertModal.open(e.message);
    } catch (e) {
      print(e);
    }
    return null;
  }

  void addOrUpdateProductItem(Product product) {
    int index = productItems.indexWhere((item) => item.id == product.id);
    if (index != -1) {
      // 이미 존재하는 상품이면 amount를 1 증가
      ProductItem updatedItem = ProductItem(
        id: product.id,
        name: product.name,
        price: product.price,
        amount: productItems[index].amount + 1,
      );
      productItems[index] = updatedItem;
    } else {
      // 새로운 상품이면 리스트에 추가
      productItems.add(ProductItem(
        id: product.id,
        name: product.name,
        price: product.price,
        amount: 1,
      ));
    }
  }

  void checkAndNavigateBack() {
    if (productItems.isEmpty) {
      Get.back();
    }
  }

  void decreaseProductItemAmount(String id) {
    int index = productItems.indexWhere((item) => item.id == id);
    if (index != -1) {
      if (productItems[index].amount > 1) {
        ProductItem updatedItem = ProductItem(
          id: productItems[index].id,
          name: productItems[index].name,
          price: productItems[index].price,
          amount: productItems[index].amount - 1,
        );
        productItems[index] = updatedItem;
      } else {
        productItems.removeAt(index);
      }
      checkAndNavigateBack();
    }
  }

  void clearProductItems() {
    productItems.clear();
    checkAndNavigateBack();
  }
}
