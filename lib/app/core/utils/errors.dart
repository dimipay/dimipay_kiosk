class OnboardingTokenException implements Exception {
  final String message;
  OnboardingTokenException(this.message);
}

class NoRefreshTokenException implements Exception {
  final String message;
  NoRefreshTokenException({this.message = ''});
}

class NoAccessTokenException implements Exception {
  final String message;
  NoAccessTokenException(this.message);
}

class IncorrectPinException implements Exception {
  final String message;
  IncorrectPinException(this.message);
}
