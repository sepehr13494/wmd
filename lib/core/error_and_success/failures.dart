import 'package:equatable/equatable.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});

  @override
  List<Object?> get props => [message];
}

class CacheFailure extends Failure {
  const CacheFailure({required String message}) : super(message: message);
}

class ServerFailure extends Failure {
  final ServerExceptionType type;
  final dynamic data;

  const ServerFailure(
      {required String message,
      this.type = ServerExceptionType.normal,
      this.data})
      : super(message: message);

  @override
  List<Object?> get props => [message, type, data];

  factory ServerFailure.fromServerException(ServerException exception) =>
      ServerFailure(message: exception.message,data: exception.data,type: exception.type);
}

class AppFailure extends Failure {
  const AppFailure({required String message}) : super(message: message);
}
