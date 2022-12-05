import 'package:flutter_test/flutter_test.dart';
import 'package:wmd/features/asset_detail/core/data/models/get_detail_params.dart';

void main() {
  const tGetDetailParams =
      GetDetailParams(assetId: 'assetId', type: 'BankAccount');

  test(
    'should return a valid model from json',
    () async {
      // arrange
      final jsonMap = GetDetailParams.tGetDetailsJson;
      // act
      final result = GetDetailParams.fromJson(jsonMap);
      // assert
      expect(result, equals(tGetDetailParams));
    },
  );

  test('should return a json map containing proper data', () {
    // arrange
    final exceptedJson = {
      'assetId': 'assetId',
      'type': 'BankAccount',
    };

    // act
    final result = GetDetailParams.fromJson(GetDetailParams.tGetDetailsJson);
    // assert
    expect(result.toJson(), equals(exceptedJson));
  });
}
