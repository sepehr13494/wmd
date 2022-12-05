import 'package:flutter_test/flutter_test.dart';
import 'package:wmd/features/asset_detail/bank_account/data/models/bank_account_response.dart';

void main() {
  const tBankAccountResponseModel = BankAccountResponse(
      "Isbank",
      "Softtech",
      "CurrentAccount",
      1071.0,
      false,
      0,
      0.0,
      0.0,
      null,
      null,
      "6e2bd58f-6d3f-46f1-9480-46a0f96cbeff",
      "BankAccount",
      true,
      "TR",
      "Asia",
      "USD");

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
