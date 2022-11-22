import 'package:dartz/dartz.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:plaid_flutter/plaid_flutter.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
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
    return 'link-sandbox-33792986-2b9c-4b80-b1f2-518caaac6183';
  }

  @override
  Future<String> postPublicToken(String publicToken) async {
    print(publicToken);
    return publicToken;
  }

  @override
  Future<String> getPublicToken(String linkToken) async {
    print('1');
    LinkConfiguration configuration = LinkTokenConfiguration(
      token: linkToken,
      receivedRedirectUri: 'app://wmd.com/home',
    );
    // // PlaidLink.
    // PlaidLink.onEvent.listen((event) {
    //   print(event);
    // });

    PlaidLink.open(configuration: configuration);

    PlaidLink.onExit.listen((event) {
      PlaidLink.close();
      if (event.error != null) {
        print('5 ${event.error!.message}');
        throw ServerException(message: event.error!.message);
      } else {
        throw Exception(event.metadata.status);
      }
    });

    return (await PlaidLink.onSuccess.first).publicToken;
  }
}
