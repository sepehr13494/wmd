import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:plaid_flutter/plaid_flutter.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/features/add_assets/add_bank_auto/plaid_integration/data/models/link_token_response.dart';

abstract class PlaidLinkRemoteDataSource {
  Future<LinkTokenResponse> getLinkToken(String redirectUrl, String provider);
  Future<Stream<LinkEvent>> getPublicToken(String linkToken);
  Future<String> postPublicToken(String publicToken);
}

class PlaidLinkRemoteDataSourceImpl extends AppServerDataSource
    implements PlaidLinkRemoteDataSource {
  PlaidLinkRemoteDataSourceImpl(super.errorHandlerMiddleware);

  @override
  Future<LinkTokenResponse> getLinkToken(
      String redirectUrl, String provider) async {
    final getBankListRequestOptions = AppRequestOptions(
        RequestTypes.post, AppUrls.linkToken, null,
        additionalHeaders: {'Provider': provider});
    final Map<String, dynamic> response =
        await errorHandlerMiddleware.sendRequest(getBankListRequestOptions);
    final linkToken = LinkTokenResponse.fromJson(response);
    if (linkToken.linkToken == null) {
      throw ServerException(
          message: 'Link token not found', type: ExceptionType.format);
    }
    return linkToken;
  }

  @override
  Future<String> postPublicToken(String publicToken) async {
    //TODO post publicToken to backend
    return publicToken;
  }

  @override
  Future<Stream<LinkEvent>> getPublicToken(String linkToken) async {
    LinkConfiguration configuration = LinkTokenConfiguration(
      token: linkToken,
      // receivedRedirectUri: 'app://wmd.com/home',
    );
    PlaidLink.open(configuration: configuration);
    return PlaidLink.onEvent;
  }
}
