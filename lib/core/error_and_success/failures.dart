import 'package:equatable/equatable.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';

abstract class Failure extends Equatable {
  final String message;
  final ExceptionType type;
  final dynamic data;

  const Failure(
      {required this.message, this.type = ExceptionType.normal, this.data});

  @override
  List<Object?> get props => [message];
}

class CacheFailure extends Failure {
  const CacheFailure({required String message}) : super(message: message);
}

class ServerFailure extends Failure {
  const ServerFailure(
      {required String message,
      ExceptionType type = ExceptionType.normal,
      dynamic data})
      : super(message: message, data: data, type: type);

  @override
  List<Object?> get props => [message, type, data];

  factory ServerFailure.fromServerException(ServerException exception) =>
      ServerFailure(
          message: exception.message,
          data: exception.data,
          type: exception.type);

  static const tServerFailure = ServerFailure(message: "test message");
}

class AppFailure extends Failure {
  const AppFailure(
      {required String message,
      ExceptionType type = ExceptionType.normal,
      dynamic data})
      : super(message: message, data: data, type: type);

  factory AppFailure.fromAppException(AppException exception) =>
      AppFailure(
          message: exception.message,
          data: exception.data,
          type: exception.type);

  static const tAppFailure = AppFailure(message: "test message");
}
