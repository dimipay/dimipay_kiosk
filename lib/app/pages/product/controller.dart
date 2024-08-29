import 'dart:async';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:convert_native_img_stream/convert_native_img_stream.dart';
import 'package:dimipay_kiosk/app/core/utils/errors.dart';
import 'package:dimipay_kiosk/app/pages/payment/paymeent_pending/controller.dart';
import 'package:dimipay_kiosk/app/pages/pin/controller.dart';
import 'package:dimipay_kiosk/app/pages/product/widgets/timeout_alert.dart';
import 'package:dimipay_kiosk/app/routes/routes.dart';
import 'package:dimipay_kiosk/app/services/face_sign/model.dart';
import 'package:dimipay_kiosk/app/services/face_sign/service.dart';
import 'package:dimipay_kiosk/app/services/kiosk/model.dart';
import 'package:dimipay_kiosk/app/services/kiosk/service.dart';
import 'package:dimipay_kiosk/app/services/timer/service.dart';
import 'package:dimipay_kiosk/app/services/transaction/service.dart';
import 'package:dimipay_kiosk/app/widgets/snackbar.dart';
import 'package:get/get.dart';

enum FaceDetectionStatus { searching, detected, failed }

class ProductPageController extends GetxController {
  final Product? firstProduct = Get.arguments;
  KioskService kioskService = Get.find<KioskService>();
  TransactionService transactionService = Get.find<TransactionService>();
  FaceSignService faceSignService = Get.find<FaceSignService>();
  TimerService timerService = Get.find<TimerService>();

  final RxList<ProductItem> productItems = <ProductItem>[].obs;
  String? transactionId;
  late String dpToken;
  User? user;

  final Rx<FaceDetectionStatus> faceDetectionStatus =
  Rx<FaceDetectionStatus>(FaceDetectionStatus.searching);

  late CameraController _cameraController;
  final ConvertNativeImgStream _convertNative = ConvertNativeImgStream();
  bool _isCameraInitialized = false;

  late Rx<Method?> selectedPaymentMethod = Rx<Method?>(null);

  RxBool get isPaymentMethodSelectable =>
      (faceDetectionStatus.value == FaceDetectionStatus.detected &&
          user != null)
          .obs;

  @override
  void onInit() async {
    super.onInit();
    await _initializeCamera();
    if (firstProduct != null) {
      addOrUpdateProductItem(firstProduct!);
    }
    await generateTransactionId();
    await doFaceSignAction();
    timerService.startTimer();
  }

  @override
  void onClose() {
    timerService.stopTimer();
    _cameraController.dispose();
    if (transactionId != null) {
      deleteTransactionId(transactionId: transactionId!);
    }
    super.onClose();
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

  Future<Uint8List> captureImage() async {
    if (!_isCameraInitialized) {
      throw CameraException('Camera not initialized',
          'Please initialize the camera before capturing an image');
    }

    Completer<Uint8List> completer = Completer<Uint8List>();

    await _cameraController.startImageStream((CameraImage cameraImage) async {
      if (!completer.isCompleted) {
        _cameraController.stopImageStream();

        try {
          final Uint8List? convertedImage =
          await _convertNative.convertImgToBytes(
            cameraImage.planes[0].bytes,
            cameraImage.width,
            cameraImage.height,
          );
          completer.complete(convertedImage);
        } catch (e) {
          completer.completeError('Failed to convert image: $e');
        }
      }
    });

    return completer.future;
  }

  Future<void> doFaceSignAction() async {
    int attempts = 0;
    const int maxAttempts = 5;

    while (faceDetectionStatus.value == FaceDetectionStatus.searching &&
        attempts < maxAttempts) {
      try {
        Uint8List image = await captureImage();

        User detectedUser = await faceSignService.getUserWithFaceSign(
          image: image,
          transactionId: transactionId!,
        );

        faceDetectionStatus.value = FaceDetectionStatus.detected;
        user = detectedUser;
        selectedPaymentMethod.value = user!.paymentMethods.methods.firstWhere(
              (method) => method.id == user!.paymentMethods.mainPaymentMethodId,
        );
        return;
      } on NoMatchedUserException {
        attempts++;
        if (attempts >= maxAttempts) {
          faceDetectionStatus.value = FaceDetectionStatus.failed;
        }
      } on UnknownException catch (e) {
        DPAlertModal.open(e.message);
      }
    }
  }

  Future<void> restartFaceDetection() async {
    faceDetectionStatus.value = FaceDetectionStatus.searching;
    user = null;
    selectedPaymentMethod.value = null;
    await doFaceSignAction();
  }

  Future<void> generateTransactionId() async {
    try {
      transactionId = await transactionService.generateTransactionId();
    } on UnknownException catch (e) {
      DPAlertModal.open(e.message);
    }
  }

  void deleteTransactionId({required String transactionId}) async {
    try {
      await transactionService.deleteTransactionId(
          transactionId: transactionId);
    } on DeletingTransactionIfNotFoundException catch (e) {
      // DPAlertModal.open(e.message);
      return;
    } on NoTransactionIdFoundException catch (e) {
      // DPAlertModal.open(e.message);
      return;
    } on UnknownException catch (e) {
      DPAlertModal.open(e.message);
    }
  }

  void setDPToken({required String barcode}) {
    dpToken = barcode;
    payQR();
  }

  void payQR() {
    timerService.stopTimer();
    Get.toNamed(Routes.PAYMENT_PENDING, arguments: {
      'type': PaymentType.qr,
      'transactionId': transactionId,
      'productItems': productItems,
      'dpToken': dpToken,
    });
  }

  void faceSignPayment() {
    timerService.stopTimer();
    Get.toNamed(Routes.PIN, arguments: {
      'pinPageType': PinPageType.facesign,
      'type': PaymentType.faceSign,
      'transactionId': transactionId,
      'productItems': productItems,
      'paymentPinAuthURL': user!.paymentMethods.paymentPinAuthURL,
      'paymentMethodId': selectedPaymentMethod.value!.id,
    });
    restartFaceDetection();
  }

  Future<Product?> getProduct({required String barcode}) async {
    timerService.resetTimer();
    try {
      Product data = await kioskService.getProduct(barcode: barcode);
      addOrUpdateProductItem(data);
      return data;
    } on ProductNotFoundException catch (e) {
      DPAlertModal.open(e.message);
    } on DisabledProductException catch (e) {
      DPAlertModal.open(e.message);
    } on UnknownException catch (e) {
      DPAlertModal.open(e.message);
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
    timerService.resetTimer();
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
    timerService.resetTimer();
  }

  void qrPayment() {
    timerService.stopTimer();
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
    timerService.resetTimer();
  }

  void updateSelectedPaymentMethod(Method newMethod) {
    selectedPaymentMethod.value = newMethod;
    timerService.resetTimer();
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