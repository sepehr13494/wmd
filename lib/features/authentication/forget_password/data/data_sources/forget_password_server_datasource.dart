import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/features/authentication/forget_password/domain/use_cases/forget_password_usecase.dart';
import 'package:wmd/features/authentication/verify_email/data/models/verify_email_params.dart';
import 'package:wmd/features/authentication/verify_email/data/models/verify_email_response.dart';

abstract class ForgetPasswordServerDataSource{
  Future<void> forgetPassword(ForgetPasswordParams forgetPasswordParams);
}

class ForgetPasswordServerDataSourceImpl extends AppServerDataSource implements ForgetPasswordServerDataSource{
  ForgetPasswordServerDataSourceImpl(super.errorHandlerMiddleware);

  @override
  Future<void> forgetPassword(ForgetPasswordParams forgetPasswordParams) async {
    final forgetPasswordAppRequestOptions = AppRequestOptions(
      RequestTypes.post,
      AppUrls.forgetPassword,
      forgetPasswordParams.toJson(),
    );
    final response =
        await errorHandlerMiddleware.sendRequest(forgetPasswordAppRequestOptions);
    return ;
  }

}