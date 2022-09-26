import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:wmd/features/authentication/data/models/login_response_model.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final loginModel = LoginResponse(
    accessToken: 'test accessToken',
    refreshToken: 'test refreshToken',
    idToken: 'test idToken',
    tokenType: 'test tokenType',
  );

  test('should return a valid model from json', () {
    // arrange
    final jsonMap = jsonDecode(fixture('login_success_response.json'));
    // act
    final result = LoginResponse.fromJson(jsonMap);
    // assert
    expect(result, equals(loginModel));
  });

  test('should return a json map containing proper data', () {
    // arrange
    final exceptedJson = {
      "access_token": 'test accessToken',
      "refresh_token": 'test refreshToken',
      'id_token': 'test idToken',
      'token_type': 'test tokenType',
    };

    // act
    final result = loginModel.toJson();
    // assert
    expect(result, equals(exceptedJson));
  });
}
