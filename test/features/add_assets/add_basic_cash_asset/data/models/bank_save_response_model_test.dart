import 'package:wmd/features/add_assets/add_basic_cash_asset/data/models/bank_save_response_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/domain/entities/bank_save_response.dart';

void main() {
  const tBankSaveModel = BankSaveResponseModel(
      currencyCode: "TRY",
      currencyRate: 1.5,
      startingBalance: 500,
      totalNetWorthChange: 750,
      totalNetWorth: 0);

  test(
    'should be a subclass of BankSaveResponse Entity',
    () async {
      // assert
      expect(tBankSaveModel, isA<BankSaveResponse>());
    },
  );

  test(
    'should return a valid model from json',
    () async {
      // arrange
      final jsonMap = BankSaveResponseModel.tBankSaveResponse;
      // act
      final result = BankSaveResponseModel.fromJson(jsonMap);
      // assert
      expect(result, tBankSaveModel);
    },
  );

  test('should return a json map containing proper data', () {
    // arrange
    final exceptedJson = {
      "currencyCode": "TRY",
      "currencyRate": 1.5,
      "startingBalance": 500,
      "totalNetWorthChange": 750,
      "totalNetWorth": 0
    };

    // act
    final result = BankSaveResponseModel.tBankSaveResponse;
    // assert
    expect(result, equals(exceptedJson));
  });
}
