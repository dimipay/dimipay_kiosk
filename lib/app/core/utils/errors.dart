import 'package:dimipay_kiosk/app/widgets/alert_modal.dart';

class OnboardingTokenException implements Exception {
  final String message;
  OnboardingTokenException(this.message) {
    AlertModal.to.show(message);
  }
}

class NoRefreshTokenException implements Exception {
  final String message;
  NoRefreshTokenException({this.message = ''});
}

class NoAccessTokenException implements Exception {
  final String message;
  NoAccessTokenException(this.message) {
    AlertModal.to.show(message);
  }
}

class NoProductException implements Exception {
  final String message;
  NoProductException(this.message) {
    AlertModal.to.show(message);
  }
}

class IncorrectPinException implements Exception {
  final String message;
  IncorrectPinException(this.message) {
    AlertModal.to.show(message);
  }
}

class NoUserFoundException implements Exception {
  final String message;
  NoUserFoundException({this.message = ''});
}

class PaymentApproveFailedException implements Exception {
  final String message;
  PaymentApproveFailedException(this.message) {
    AlertModal.to.show(message);
  }
}
