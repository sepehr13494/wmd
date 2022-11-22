import 'package:dartz/dartz.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:plaid_flutter/plaid_flutter.dart';
import 'package:wmd/core/error_and_success/failures.dart';

abstract class PlaidIntegrationRemoteDataSource {
  Future<String> getLinkToken(String redirectUrl);
  Future<String> getPublicToken(String linkToken);
  Future<String> postPublicToken(String publicToken);
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

  @override
  Future<String> getPublicToken(String linkToken) async {
    LinkConfiguration configuration = LinkTokenConfiguration(
      token: linkToken,
    );
    await PlaidLink.open(configuration: configuration);

    PlaidLink.onEvent.listen((event) {
      print(event);
    });
    return (await PlaidLink.onSuccess.first).publicToken;
  }
}
