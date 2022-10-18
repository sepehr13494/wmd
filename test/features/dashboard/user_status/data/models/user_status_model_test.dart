import 'package:flutter_test/flutter_test.dart';
import 'package:wmd/core/extentions/date_time_ext.dart';
import 'package:wmd/features/dashboard/user_status/data/models/user_status.dart';

void main() {
  final userModel = UserStatus(
      email: 'test@yopmail.com', loginAt: CustomizableDateTime.currentDate);
  test('should return a valid model from json', () {
    // arrange
    final jsonMap = {
      "email": "test@yopmail.com",
      "loginAt": CustomizableDateTime.currentDate
    };
    // act
    final result = UserStatus.fromJson(jsonMap);
    // assert
    expect(result, equals(userModel));
  });

  test('should return a json map containing proper data', () {
    // arrange
    final exceptedJson = {
      "email": "test@yopmail.com",
      "loginAt": CustomizableDateTime.currentDate
    };

    // act
    final result = UserStatus.tUserStatusResponse;
    // assert
    expect(result, equals(exceptedJson));
  });
}
