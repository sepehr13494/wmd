import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppUrls {
  AppUrls._();

  static const int wrongTokenCode = 401;
  static String baseUrl = dotenv.env['BASE_URL']!;
  static const String refreshUrl = "";

  //other urls
  static const String registerUser = "auth/client/sign-up";
  static const String resendEmail = "auth/send-verification-email";
  static const String loginUser = "auth/client/token";
  static const String getUserStatus = "wmo-user/user";
  static const String verifyEmail = "auth/verify-email";
}
