import 'package:flutter_test/flutter_test.dart';
import 'package:wmd/features/add_assets/add_bank_auto/plaid_integration/data/models/link_token_response.dart';

void main() {
  const tLinkTokenResponseModel = LinkTokenResponse(
      expiration: "2022-11-23T13:20:20Z",
      linkToken: "link-sandbox-5180c00b-478d-430d-a7f0-b11835e099e5",
      requestId: "qsNAI33QvnsUqRF");

  test('should return valid model from json', () async {});
}
