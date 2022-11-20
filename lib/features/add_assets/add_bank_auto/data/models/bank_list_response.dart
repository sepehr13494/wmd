import 'package:wmd/features/add_assets/add_bank_auto/domain/entity/bank_entity.dart';

class BankResponse extends BankEntity {
  const BankResponse({
    required String code,
    required String name,
    String? commonName,
    String? provider,
    String? providerCode,
    String? logo,
    String? homeUrl,
    String? loginUrl,
    String? countryCode,
    bool? automaticFetch,
    int? sortOrder,
  }) : super(
          name: name,
          code: code,
          commonName: commonName,
          provider: provider,
          providerCode: providerCode,
          logo: logo,
          homeUrl: homeUrl,
          loginUrl: loginUrl,
          countryCode: countryCode,
          automaticFetch: automaticFetch,
          sortOrder: sortOrder,
        );

  factory BankResponse.fromJson(Map<String, dynamic> json) {
    final code = json['code'].toString();
    final name = json['name'].toString();
    final commonName = json['commonName']?.toString();
    final provider = json['provider']?.toString();
    final providerCode = json['providerCode']?.toString();
    final logo = json['logo']?.toString();
    final homeUrl = json['homeUrl']?.toString();
    final loginUrl = json['loginUrl']?.toString();
    final countryCode = json['countryCode']?.toString();
    final automaticFetch = json['automaticFetch'];
    final sortOrder = json['sortOrder']?.toInt();
    return BankResponse(
        code: code,
        name: name,
        automaticFetch: automaticFetch,
        commonName: commonName,
        countryCode: countryCode,
        homeUrl: homeUrl,
        loginUrl: loginUrl,
        logo: logo,
        provider: provider,
        providerCode: providerCode,
        sortOrder: sortOrder);
  }

  static final tBankResponse = {
    "code": "bank-code-1",
    "name": "Red Platypus Bank",
    "commonName": "Red Platypus Bank",
    "provider": "Plaid",
    "providerCode": "ins_118923",
    "logo": "https://cdn.leantech.me/img/banks/white-lean.png",
    "homeUrl": "https://www.test.com",
    "loginUrl": "https://www.test.com",
    "countryCode": "USA",
    "automaticFetch": true,
    "sortOrder": 15
  };
}
