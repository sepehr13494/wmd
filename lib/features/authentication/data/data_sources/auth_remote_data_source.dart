import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/features/authentication/data/models/register_response_model.dart';
import 'package:wmd/features/authentication/domain/use_cases/post_register_usecase.dart';
import '../../../../core/data/network/server_request_manager.dart';
import '../../../../core/data/repository/app_data_source.dart';
import '../../../../core/models/app_request_options.dart';
import '../models/login_response_model.dart';
import '../../domain/use_cases/post_login_usecase.dart';

abstract class AuthRemoteDataSource {
  /// Calls the login api endpoint in the TFO - WMD services
  Future<LoginResponse> login(LoginParams loginParams);
  Future<RegisterResponse> register(RegisterParams loginParams);
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
  Future<RegisterResponse> register(RegisterParams registerParams) async {
    final loginAppRequestOptions = AppRequestOptions(
      RequestTypes.post,
      AppUrls.registerUser,
      registerParams.toJson(),
    );
    final response =
        await errorHandlerMiddleware.sendRequest(loginAppRequestOptions);
    final result = RegisterResponse.fromJson(response);
    return result;
  }
}
