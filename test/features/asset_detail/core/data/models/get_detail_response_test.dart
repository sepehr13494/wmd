import 'package:flutter_test/flutter_test.dart';
import 'package:wmd/features/asset_detail/bank_account/data/models/bank_account_response.dart';

void main() {
  final tBankAccountResponseModel =
      BankAccountResponse.fromJson(BankAccountResponse.tBankAccountResponse);

  test(
    'should return a valid model from json',
    () async {
      // arrange
      final jsonMap = BankAccountResponse.tBankAccountResponse;
      // act
      final result = BankAccountResponse.fromJson(jsonMap);
      // assert
      expect(result, equals(tBankAccountResponseModel));
    },
  );

  test('should return a json map containing proper data', () {
    // arrange
    final exceptedJson = {
      "bankName": "Isbank",
      "description": "Softtech",
      "accountType": "CurrentAccount",
      "currentBalance": 1071.0,
      "isJointAccount": false,
      "noOfCoOwners": 0,
      "ownershipPercentage": 0.0,
      "interestRate": 0.0,
      "startDate": null,
      "endDate": null,
      "id": "6e2bd58f-6d3f-46f1-9480-46a0f96cbeff",
      "type": "BankAccount",
      "isActive": true,
      "country": "TR",
      "region": "Asia",
      "currencyCode": "USD"
    };

    // act
    final result =
        BankAccountResponse.fromJson(BankAccountResponse.tBankAccountResponse);
    // assert
    expect(result.toJson(), equals(exceptedJson));
  });
}
