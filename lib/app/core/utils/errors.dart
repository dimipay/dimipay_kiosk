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

class ProductNotFoundException implements Exception {
  final String message;

  ProductNotFoundException({this.message = ''});
}

class DisabledProductException implements Exception {
  final String message;

  DisabledProductException({this.message = ''});
}

class DeletingTransactionIfNotFoundException implements Exception {
  final String message;

  DeletingTransactionIfNotFoundException({this.message = ''});
}

class ForbiddenUserException implements Exception {
  final String message;

  ForbiddenUserException({this.message = ''});
}

class WrongPayTokenException implements Exception {
  final String message;

  WrongPayTokenException({this.message = ''});
}

class UnknownProductException implements Exception {
  final String message;

  UnknownProductException({this.message = ''});
}

class FailedToCancelTransactionException implements Exception {
  final String message;

  FailedToCancelTransactionException({this.message = ''});
}

class UnknownException implements Exception {
  final String message;

  UnknownException({this.message = ''});
}

class NoMatchedUserException implements Exception {
  final String message;

  NoMatchedUserException({this.message = ''});
}

class InvalidUserTokenException implements Exception {
  final String message;

  InvalidUserTokenException({this.message = ''});
}

class InvalidOTPException implements Exception {
  final String message;

  InvalidOTPException({this.message = ''});
}

class PaymentPinNotMatchException implements Exception {
  final String message;

  PaymentPinNotMatchException({this.message = ''});
}
