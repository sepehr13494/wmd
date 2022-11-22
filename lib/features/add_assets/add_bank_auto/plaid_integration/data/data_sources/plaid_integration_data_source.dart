import 'package:wmd/core/data/repository/app_data_source.dart';

abstract class PlaidIntegrationRemoteDataSource {
  Future<String> getLinkToken(String redirectUrl);
  Future<String> postPublicToken(String linkToken);
}

class PlaidIntegrationRemoteDataSourceImpl extends AppServerDataSource
    implements PlaidIntegrationRemoteDataSource {
  PlaidIntegrationRemoteDataSourceImpl(super.errorHandlerMiddleware);

  @override
  Future<String> getLinkToken(String redirectUrl) async {
    return 'mockLinkToken';
  }

  @override
  Future<String> postPublicToken(String publicToken) async {
    print(publicToken);
    return publicToken;
  }
}
