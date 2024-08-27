import 'package:camera/camera.dart';
import 'package:dimipay_kiosk/app/core/utils/errors.dart';
import 'package:dimipay_kiosk/app/pages/payment/paymeent_pending/controller.dart';
import 'package:dimipay_kiosk/app/routes/routes.dart';
import 'package:dimipay_kiosk/app/services/face_sign/model.dart';
import 'package:dimipay_kiosk/app/services/face_sign/service.dart';
import 'package:dimipay_kiosk/app/services/kiosk/model.dart';
import 'package:dimipay_kiosk/app/services/kiosk/service.dart';
import 'package:dimipay_kiosk/app/services/transaction/service.dart';
import 'package:dimipay_kiosk/app/widgets/snackbar.dart';
import 'package:get/get.dart';

enum FaceDetectionStatus { searching, detected, failed }

class ProductPageController extends GetxController {
  final String? firstProduct = Get.arguments as String?;
  KioskService kioskService = Get.find<KioskService>();
  TransactionService transactionService = Get.find<TransactionService>();
  FaceSignService faceSignService = Get.find<FaceSignService>();

  final RxList<ProductItem> productItems = <ProductItem>[].obs;
  late final String? transactionId;
  late String dpToken;
  late User user;

  final Rx<FaceDetectionStatus> faceDetectionStatus =
      Rx<FaceDetectionStatus>(FaceDetectionStatus.searching);

  late CameraController _cameraController;
  bool _isCameraInitialized = false;

  late Rx<Method> selectedPaymentMethod;

  RxBool get isPaymentMethodSelectable =>
      (faceDetectionStatus.value == FaceDetectionStatus.detected).obs;

  @override
  void onInit() async {
    super.onInit();
    await _initializeCamera();
    if (firstProduct != null) {
      getProduct(barcode: firstProduct!);
    }
    await generateTransactionId();
    await doFaceSignAction();

    selectedPaymentMethod = Rx<Method>(user.paymentMethods.methods.firstWhere(
      (method) => method.id == user.paymentMethods.mainPaymentMethodId,
    ));
  }

  @override
  void onClose() {
    _cameraController.dispose();
    super.onClose();
    deleteTransactionId(transactionId: transactionId!);
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) {
      throw CameraException(
          'No cameras found', 'No cameras available on this device');
    }

    _cameraController = CameraController(
      cameras[1],
      ResolutionPreset.low,
      enableAudio: false,
    );

    try {
      await _cameraController.initialize();
      await _cameraController.setFlashMode(FlashMode.off);
      _isCameraInitialized = true;
    } on CameraException catch (e) {
      print('Error initializing camera: $e');
      _isCameraInitialized = false;
    }
  }

  Future<XFile> captureImage() async {
    if (!_isCameraInitialized) {
      throw CameraException('Camera not initialized',
          'Please initialize the camera before capturing an image');
    }

    try {
      final XFile image = await _cameraController.takePicture();
      return image;
    } on CameraException catch (e) {
      print('Error capturing image: $e');
      throw CameraException('Failed to capture image', e.description);
    }
  }

  Future<void> doFaceSignAction() async {
    int attempts = 0;
    const int maxAttempts = 5;

    while (faceDetectionStatus.value == FaceDetectionStatus.searching &&
        attempts < maxAttempts) {
      try {
        XFile image = await captureImage();

        User detectedUser = await faceSignService.getUserWithFaceSign(
          image: image,
          transactionId: transactionId!,
        );

        faceDetectionStatus.value = FaceDetectionStatus.detected;
        user = detectedUser;
        return;
      } on NoMatchedUserException {
        attempts++;
        if (attempts >= maxAttempts) {
          faceDetectionStatus.value = FaceDetectionStatus.failed;
        }
      }
    }
  }

  Future<void> restartFaceDetection() async {
    faceDetectionStatus.value = FaceDetectionStatus.searching;
    await doFaceSignAction();
  }

  Future<void> generateTransactionId() async {
    try {
      transactionId = await transactionService.generateTransactionId();
    } catch (e) {
      print(e);
    }
  }

  void deleteTransactionId({required String transactionId}) async {
    try {
      await transactionService.deleteTransactionId(
          transactionId: transactionId);
    } on DeletingTransactionIfNotFoundException catch (e) {
      // Handle exception
    } catch (e) {
      print(e);
    }
  }

  void setDPToken({required String barcode}) {
    dpToken = barcode;
    payQR();
  }

  void payQR() {
    Get.toNamed(Routes.PAYMENT_PENDING, arguments: {
      'type': PaymentType.qr,
      'transactionId': transactionId,
      'productItems': productItems,
      'dpToken': dpToken,
    });
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
      ProductItem updatedItem = ProductItem(
        id: product.id,
        name: product.name,
        price: product.price,
        amount: productItems[index].amount + 1,
      );
      productItems[index] = updatedItem;
    } else {
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
      Get.offAndToNamed(Routes.ONBOARDING);
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

  void qrPayment() {
    Get.toNamed(
      Routes.PAYMENT,
      arguments: {
        'transactionId': transactionId,
        'productItems': productItems,
      },
    );
  }

  void clearProductItems() {
    productItems.clear();
    checkAndNavigateBack();
  }

  void updateSelectedPaymentMethod(Method newMethod) {
    selectedPaymentMethod.value = newMethod;
  }

  String getLogoImagePath(String cardCode) {
    const url = 'assets/images/cards/';
    final companyCodeToImagePath = {
      'BC': 'BC.svg',
      'Kb': 'Kb.svg',
      'Hana': 'Hana.svg',
      'Samsung': 'Samsung.svg',
      'Shinhan': 'Shinhan.svg',
      'Hyundai': 'Hyundai.svg',
      'Lotte': 'Lotte.svg',
      'Citi': 'Citi.svg',
      'NH': 'NH.svg',
      'Suhyup': 'Suhyup.svg',
      'NACUFOK': 'Shinhyup.svg',
      'Woori': 'Woori.svg',
      'KJB': 'KJB.svg',
      'VISA': 'VISA.svg',
      'Mastercard': 'Mastercard.svg',
      'Post': 'Post.svg',
      'MG': 'MG.svg',
      'KDB': 'KDB.svg',
      'Kakaobank': 'Kakaobank.svg',
      'Kbank': 'Kbank.svg',
      'AMEX': 'AMEX.svg',
      'Unionpay': 'Unionpay.svg',
      'Tossbank': 'Tossbank.svg',
      'Naverpay': 'Naverpay.svg',
    };
    return url + (companyCodeToImagePath[cardCode] ?? 'Unknown.svg');
  }
}
