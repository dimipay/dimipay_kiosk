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

class TokenErrorException implements Exception {
  final String message;

  TokenErrorException({this.message = ''});
}

class TokenExpiredException implements Exception {
  final String message;

  TokenExpiredException({this.message = ''});
}

class TokenNotFoundException implements Exception {
  final String message;

  TokenNotFoundException({this.message = ''});
}

class UnauthenticatedException implements Exception {
  final String message;

  UnauthenticatedException({this.message = ''});
}

class WrongTokenTypeException implements Exception {
  final String message;

  WrongTokenTypeException({this.message = ''});
}

class NoTransactionIdFoundException implements Exception {
  final String message;

  NoTransactionIdFoundException({this.message = ''});
}
