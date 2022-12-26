import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/features/help/support/data/models/support_status.dart';
import 'package:wmd/features/help/support/domain/use_cases/post_general_inquiry_usecase.dart';

abstract class GeneralInquiryRemoteDataSource {
  Future<SupportStatus> postGeneralInquiry(GeneralInquiryParams params);
}

class GeneralInquiryRemoteDataSourceImpl extends AppServerDataSource
    implements GeneralInquiryRemoteDataSource {
  GeneralInquiryRemoteDataSourceImpl(super.errorHandlerMiddleware);

  @override
  Future<SupportStatus> postGeneralInquiry(GeneralInquiryParams params) async {
    final getUserStatusRequestOptions = AppRequestOptions(
        RequestTypes.post, AppUrls.postInquiry, params.toJson());
    final response =
        await errorHandlerMiddleware.sendRequest(getUserStatusRequestOptions);
    final result = SupportStatus.fromJson(response);
    return result;
  }
}
