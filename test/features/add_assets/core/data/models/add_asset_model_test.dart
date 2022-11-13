import 'package:flutter_test/flutter_test.dart';
import 'package:wmd/features/add_assets/core/data/models/add_asset_model.dart';
import 'package:wmd/features/add_assets/core/domain/entities/add_asset_response.dart';

void main() {
  const tBankSaveModel = AddAssetModel(
      currencyCode: "TRY",
      currencyRate: 1.5,
      startingBalance: 500.00,
      totalNetWorthChange: 750.00,
      totalNetWorth: 0.00);

  test(
    'should be a subclass of AddAsset Entity',
    () async {
      // assert
      expect(tBankSaveModel, isA<AddAsset>());
    },
  );

  test(
    'should return a valid model from json',
    () async {
      // arrange
      final jsonMap = AddAssetModel.tAddAssetResponse;
      // act
      final result = AddAssetModel.fromJson(jsonMap);
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
    final result = AddAssetModel.tAddAssetResponse;
    // assert
    expect(result, equals(exceptedJson));
  });
}
