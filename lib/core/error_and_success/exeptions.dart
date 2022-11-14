class CacheException implements Exception{
  final String message;

  CacheException({required this.message});

  @override
  String toString() {
    return "CacheException : $message";
  }
}

class InputValidationException implements Exception{
  final String message;

  InputValidationException({required this.message});

  @override
  String toString() {
    return "InputValidationException : $message";
  }
}

class ServerException implements Exception{
  final String message;
  final ServerExceptionType type;
  final dynamic data;

  ServerException({required this.message, this.type = ServerExceptionType.normal,this.data});

  @override
  String toString() {
    return "ServerException : $message";
  }
}

enum ServerExceptionType{
  normal,
  auth,
  unExpected,
}