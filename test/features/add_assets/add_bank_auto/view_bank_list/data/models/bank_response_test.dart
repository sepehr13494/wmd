import 'package:wmd/features/add_assets/add_bank_auto/view_bank_list/data/models/bank_list_response.dart';
import 'package:wmd/features/add_assets/add_bank_auto/view_bank_list/domain/entity/bank_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tBankSaveModel = BankResponse(
      code: "bank-code-1",
      name: "Red Platypus Bank",
      commonName: "Red Platypus Bank",
      provider: "Plaid",
      providerCode: "ins_118923",
      logo: "https://cdn.leantech.me/img/banks/white-lean.png",
      homeUrl: "https://www.test.com",
      loginUrl: "https://www.test.com",
      countryCode: "USA",
      automaticFetch: true,
      sortOrder: 15);

  test(
    'should be a subclass of BankResponse Entity',
    () async {
      // assert
      expect(tBankSaveModel, isA<BankEntity>());
    },
  );

  test(
    'should return a valid model from json',
    () async {
      // arrange
      final jsonMap = BankResponse.tBankResponse;
      // act
      final result = BankResponse.fromJson(jsonMap);
      // assert
      expect(result, tBankSaveModel);
    },
  );

  test('should return a json map containing proper data', () {
    // arrange
    final exceptedJson = {
      "code": "bank-code-1",
      "name": "Red Platypus Bank",
      "commonName": "Red Platypus Bank",
      "provider": "Plaid",
      "providerCode": "ins_118923",
      "logo": "https://cdn.leantech.me/img/banks/white-lean.png",
      "homeUrl": "https://www.test.com",
      "loginUrl": "https://www.test.com",
      "countryCode": "USA",
      "automaticFetch": true,
      "sortOrder": 15
    };

    // act
    final result = BankResponse.tBankResponse;
    // assert
    expect(result, equals(exceptedJson));
  });
}
