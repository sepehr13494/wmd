import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/features/help/faq/data/models/faq.dart';

abstract class FaqRemoteDataSource {
  Future<List<Faq>> getFAQs(NoParams noParams);
}

class FaqRemoteDataSourceImpl extends AppServerDataSource
    implements FaqRemoteDataSource {
  FaqRemoteDataSourceImpl(super.errorHandlerMiddleware);

  @override
  Future<List<Faq>> getFAQs(NoParams noParams) async {
    final getUserStatusRequestOptions =
        AppRequestOptions(RequestTypes.get, AppUrls.faqsContent, null);
    final List<dynamic> response =
        await errorHandlerMiddleware.sendRequest(getUserStatusRequestOptions);
    final result = faqFromJson(response);
    return result;
  }
}
