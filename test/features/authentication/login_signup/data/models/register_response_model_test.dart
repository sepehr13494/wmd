import 'package:flutter_test/flutter_test.dart';
import 'package:wmd/features/authentication/login_signup/data/models/register_response_model.dart';

void main() {
  const RegisterResponse tRegisterModel = RegisterResponse.tRegisterResponse;

  test('should return a valid model from json', () {
    // arrange
    final Map<String, dynamic> jsonMap = RegisterResponse.tRegisterResponse.toJson();
    // act
    final result = RegisterResponse.fromJson(jsonMap);
    // assert
    expect(result, equals(tRegisterModel));
  });

  test('should return a json map containing proper data', () {
    // arrange
    final exceptedJson = RegisterResponse.tRegisterResponse.toJson();

    // act
    final result = tRegisterModel.toJson();
    // assert
    expect(result, equals(exceptedJson));
  });
}
