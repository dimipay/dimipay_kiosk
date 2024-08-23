class NoRefreshTokenException implements Exception {
  final String message;

  NoRefreshTokenException({this.message = ''});
}

class PasscodeNotFoundException implements Exception {
  final String message;

  PasscodeNotFoundException({this.message = ''});
}
