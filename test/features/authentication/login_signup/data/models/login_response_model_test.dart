import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:wmd/features/authentication/login_signup/data/models/login_response_model.dart';

import '../../../../../fixtures/fixture_reader.dart';

void main() {
  final loginModel = LoginResponse(
    roles: [],
    isSocial: false,
    idToken: "test idToken",
    expiresIn: 86400,
    refreshToken: "test refreshToken",
    accessToken: "test accessToken",
    tokenType: "Bearer",
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
      "roles": [],
      "isSocial": false,
      "idToken": "test idToken",
      "expiresIn": 86400,
      "refreshToken": "test refreshToken",
      "accessToken": "test accessToken",
      "tokenType": "Bearer",
    };

    // act
    final result = loginModel.toJson();
    // assert
    expect(result, equals(exceptedJson));
  });
}
