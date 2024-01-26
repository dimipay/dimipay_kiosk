class OnboardingTokenException implements Exception {
  final String message;
  OnboardingTokenException(this.message);
}

class IncorrectPinException implements Exception {
  final String message;
  IncorrectPinException(this.message);
}
