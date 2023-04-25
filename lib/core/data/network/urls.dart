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
  static String banking = dotenv.env['BASE_URL_BANKING']!;
  static String contentBase = dotenv.env['BASE_URL_CONTENT']!;

  //other urls
  static String registerUser = "${authBase}client/sign-up";
  static String resendEmail = "${authBase}send-verification-email";
  static String loginUser = "${authBase}client/token";
  static String verifyEmail = "${authBase}verify-email";
  static String forgetPassword = "${authBase}client/reset-password";
  static String resetPassword = "${authBase}client/update-password";
  static String reset = "${authBase}update-password";
  static String getUserStatus = "${userBase}user";
  static String getName = "${userBase}user/identity";
  static String setName = "${userBase}user/personal-info";
  static String setNumber = "${userBase}user/phone-number";
  static String faqsContent = "${contentBase}faqs";
  static String postInquiry = "${wealthBase}Inquiry";
  static String postScheduleCall = "portfolio/meetings/schedule";
  static String postVerifyPhone = "${userBase}Otp/verify";
  static String postMobileVerification = "${userBase}Otp/phone-number/verify";
  static String postResendVerifyPhone = "${userBase}Otp";
  static String postResendOtp = "${userBase}User/send-otp";

  //add assets
  static String postBankDetails = "${wealthBase}BankAccount";
  static String postPrivateEquity = "${wealthBase}PrivateEquity";
  static String postPrivateDebt = "${wealthBase}PrivateDebt";
  static String postRealEstate = "${wealthBase}RealEstate";
  static String postOtherAsset = "${wealthBase}OtherAsset";
  static String postListedAsset = "${wealthBase}ListedAsset";
  static String getListedSecurity = "${wealthBase}search-security";
  static String postLoanLiability = "${wealthBase}Loans";

  //edit delete assets
  static String putRealEstate = "${wealthBase}RealEstate";
  static String deleteRealEstate = "${wealthBase}RealEstate";
  static String putBankManual = "${wealthBase}BankAccount";
  static String deleteBankManual = "${wealthBase}BankAccount";
  static String putOtherAssets = "${wealthBase}OtherAsset";
  static String deleteOtherAssets = "${wealthBase}OtherAsset";
  static String putPrivateEquity = "${wealthBase}PrivateEquity";
  static String deletePrivateEquity = "${wealthBase}PrivateEquity";
  static String putPrivateDebt = "${wealthBase}PrivateDebt";
  static String deletePrivateDebt = "${wealthBase}PrivateDebt";
  static String putListedAsset = "${wealthBase}ListedAsset";
  static String deleteListedAsset = "${wealthBase}ListedAsset";

  static String getUserNetWorth = "${wealthBase}Wealth/totalnetworth";
  static String getAllocation = "${wealthBase}wealth/";
  static String getGeographic = "${wealthBase}Assets/GeographicAllocation";
  static String getChart = "${wealthBase}Assets";
  static String getCurrency = "${wealthBase}assets/";
  static String getAssetsGeography = "${wealthBase}Assets/GeographicalOverview";
  static String getPie = "${wealthBase}Assets";
  static String getAssetsOverview = "${wealthBase}Assets/All";
  static String getBankList = "${banking}Bank";
  static String getPopularBankList = "${banking}Bank/Popular";

  //get asset details
  static String getBankAccount = "${wealthBase}BankAccount";
  static String getPrivateDebt = "${wealthBase}PrivateDebt";
  static String getPrivateEquity = "${wealthBase}PrivateEquity";
  static String getListedAsset = "${wealthBase}ListedAsset";
  static String getOtherAsset = "${wealthBase}OtherAsset";
  static String getRealEstate = "${wealthBase}RealEstate";
  static String getSeeMore(String type) {
    switch (type){
      case "OtherAssets":
        return "${wealthBase}OtherAsset";
      case "ListedAsset":
      case "ListedAssetEquity":
      case "ListedAssetFixedIncome":
      case "ListedAssetOther":
      return "${wealthBase}ListedAsset";
      default:
        return "$wealthBase$type";
    }
  }
  static String getAssetSummary(String id) => "${wealthBase}Assets/$id/summary";

  static String linkToken = "${banking}openbanking/link-token";

  //CustodianBankList
  static String getCustodianBankList = "${wealthBase}CustodianBank/list";
  static String getCustodianStatusList =
      "${wealthBase}CustodianBank/status-list";
  static String custodianBank = "${wealthBase}custodianbank";

  //valuation
  static String getAllValuation = "${wealthBase}Valuation/All";
  static String postValuation = "${wealthBase}Valuation";
  static String postAddValuation = "${wealthBase}valuation";
  static String getValuationPerformance(String id) =>
      "${wealthBase}Valuation/$id/performance";

  static String settings = "${userBase}Setting";

  static String getForceUpdate = "wmo/version";

  //performance table
  static String getAssetClass = "${wealthBase}Performance/assetclass";
  static String getBenchmark = "${wealthBase}Performance/benchmark";
  static String getCustodianPerformance = "${wealthBase}Performance/custodian";

  //glossary
  static String getGlossaries = "${contentBase}glossary";

  static String getMandate = "${userBase}User/mandate";
  static String postMandates = "${userBase}User/mandates";
}
