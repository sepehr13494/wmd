enum ExceptionType {
  normal,
  auth,
  unExpected,
  format,
}

class CacheException implements Exception {
  final String message;

  CacheException({required this.message});

  @override
  String toString() {
    return "CacheException : $message";
  }
}

class InputValidationException implements Exception {
  final String message;
  InputValidationException({required this.message});

  @override
  String toString() {
    return "InputValidationException : $message";
  }
}

class ServerException implements Exception {
  final String message;
  final ExceptionType type;
  final dynamic data;

  const ServerException(
      {required this.message, this.type = ExceptionType.normal, this.data});

  @override
  String toString() {
    return "ServerException : $message";
  }

  static const tServerException = ServerException(message: 'exception message',data: {"test":"testData"});
}

class AppException implements Exception {
  final String message;
  final ExceptionType type;
  final dynamic data;

  AppException(
      {required this.message, this.type = ExceptionType.normal, this.data});

  @override
  String toString() {
    return "AppException : $message";
  }
}
