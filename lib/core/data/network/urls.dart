import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppUrls {
  AppUrls._();

  static const int wrongTokenCode = 401;
  static String baseUrl = dotenv.env['BASE_URL']!;
  static const String refreshUrl = "";

  // Base Paths
  static String authBase = dotenv.env['BASE_URL_AUTH']!;
  static String userBase = dotenv.env['BASE_URL_USER']!;
  static String wealthBase = dotenv.env['BASE_URL_WEALTH']!;

  //other urls
  static String registerUser = "${authBase}client/sign-up";
  static String resendEmail = "${authBase}send-verification-email";
  static String loginUser = "${authBase}client/token";
  static String verifyEmail = "${authBase}verify-email";
  static String forgetPassword = "${authBase}client/reset-password";
  static String resetPassword = "${authBase}client/update-password";
  static String getUserStatus = "${userBase}user";
  static String postBankDetails = "${wealthBase}BankAccount";
  static String getUserNetWorth = "${wealthBase}Wealth/totalnetworth";
}
