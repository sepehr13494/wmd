import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/features/authentication/verify_email/data/models/verify_email_params.dart';
import 'package:wmd/features/authentication/verify_email/data/models/verify_email_response.dart';

abstract class VerifyEmailServerDataSource{
  Future<VerifyEmailResponse> verifyEmail(VerifyEmailParams verifyEmailParams);
}

class VerifyEmailServerDataSourceImpl extends AppServerDataSource implements VerifyEmailServerDataSource{
  VerifyEmailServerDataSourceImpl(super.errorHandlerMiddleware);

  @override
  Future<VerifyEmailResponse> verifyEmail(VerifyEmailParams verifyEmailParams) async {
    final verifyEmailAppRequestOptions = AppRequestOptions(
      RequestTypes.post,
      AppUrls.verifyEmail,
      verifyEmailParams.toJson(),
    );
    final response =
        await errorHandlerMiddleware.sendRequest(verifyEmailAppRequestOptions);
    final result = VerifyEmailResponse.fromJson(response);
    return result;
  }

}