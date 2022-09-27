import '../../../../core/data/network/server_request_manager.dart';
import '../../../../core/data/repository/app_data_source.dart';
import '../../../../core/models/app_request_options.dart';
import '../models/login_response_model.dart';
import '../../usecases/post_login_usecase.dart';

abstract class AuthRemoteDataSource {
  /// Calls the login api endpoint in the TFO - WMD services
  Future<LoginResponse> login(LoginParams loginParams);
  Future<LoginResponse> register(LoginParams loginParams);
}

class AuthRemoteDataSourceImpl extends AppServerDataSource
    implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(super.errorHandlerMiddleware);
  @override
  Future<LoginResponse> login(LoginParams loginParams) async {
    final loginAppRequestOptions = AppRequestOptions(
      RequestTypes.post,
      'https://tfo.mocklab.io/login',
      loginParams.toJson(),
    );
    final response =
        await errorHandlerMiddleware.sendRequest(loginAppRequestOptions);
    final result = LoginResponse.fromJson(response);
    return result;
  }

  @override
  Future<LoginResponse> register(LoginParams loginParams) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
