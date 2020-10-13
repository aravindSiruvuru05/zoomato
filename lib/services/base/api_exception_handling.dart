class ApiException implements Exception {
  final _message;
  final _prefix;
  final _statusCode;

  ApiException([this._message, this._statusCode, this._prefix]);

  String toString() {
    return "$_statusCode $_prefix $_message";
  }
}

class FetchDataException extends ApiException {
  FetchDataException(int statusCode, String message) :
      super(message, "Error During Communication:");
}

class BadRequestException extends ApiException {
  BadRequestException(int statusCode, message) : super(message,statusCode,"Invalid Request: ");
}

class UnauthorisedException extends ApiException {
  UnauthorisedException(int statusCode, message) : super(message, statusCode, "Unauthorised: ");
}

class InvalidInputException extends ApiException {
  InvalidInputException(int statusCode, String message) : super(message, statusCode, "Invalid Input: ");
}

class NotFoundException extends ApiException {
  NotFoundException(int statusCode, String message) : super(message, statusCode, "Not Found:");
}