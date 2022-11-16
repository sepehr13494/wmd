import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/models/app_request_options.dart';
import '../../domain/use_cases/post_register_usecase.dart';
import '../../domain/use_cases/resend_email_usecase.dart';
import '../models/login_response_model.dart';
import '../../domain/use_cases/post_login_usecase.dart';
import '../models/register_response_model.dart';

abstract class LoginSignUpRemoteDataSource {
  /// Calls the login api endpoint in the TFO - WMD services
  Future<LoginResponse> login(LoginParams loginParams);
  Future<RegisterResponse> register(RegisterParams registerParams);
  Future<Map<String, dynamic>> resendEmail(ResendEmailParams resendEmailParams);
}

class LoginSignUpRemoteDataSourceImpl extends AppServerDataSource
    implements LoginSignUpRemoteDataSource {
  LoginSignUpRemoteDataSourceImpl(super.errorHandlerMiddleware);
  @override
  Future<LoginResponse> login(LoginParams loginParams) async {
    final loginAppRequestOptions = AppRequestOptions(
      RequestTypes.post,
      AppUrls.loginUser,
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

  @override
  Future<Map<String, dynamic>> resendEmail(
      ResendEmailParams resendEmailParams) async {
    final loginAppRequestOptions = AppRequestOptions(
      RequestTypes.post,
      AppUrls.resendEmail,
      resendEmailParams.toJson(),
    );
    final response =
        await errorHandlerMiddleware.sendRequest(loginAppRequestOptions);
    return response;
  }
}
