import '../network/error_handler_middleware.dart';

class AppServerDataSource {
  final ErrorHandlerMiddleware errorHandlerMiddleware;

  AppServerDataSource(this.errorHandlerMiddleware);
}
