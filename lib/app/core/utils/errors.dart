class NoRefreshTokenException implements Exception {
  final String message;

  NoRefreshTokenException({this.message = ''});
}

class PasscodeNotFoundException implements Exception {
  final String message;

  PasscodeNotFoundException({this.message = ''});
}

class WrongTransactionIdException implements Exception {
  final String message;

  WrongTransactionIdException({this.message = ''});
}

class ClientDisabledException implements Exception {
  final String message;

  ClientDisabledException({this.message = ''});
}

class WrongClientTypeException implements Exception {
  final String message;

  WrongClientTypeException({this.message = ''});
}

class ClientNotFoundException implements Exception {
  final String message;

  ClientNotFoundException({this.message = ''});
}
