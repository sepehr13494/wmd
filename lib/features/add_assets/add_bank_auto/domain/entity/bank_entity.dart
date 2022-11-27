import 'package:equatable/equatable.dart';

class BankEntity extends Equatable {
  final String code;
  final String name;
  final String? commonName;
  final String? provider;
  final String? providerCode;
  final String? logo;
  final String? homeUrl;
  final String? loginUrl;
  final String? countryCode;
  final bool? automaticFetch;
  final int? sortOrder;

  const BankEntity({
    required this.code,
    required this.name,
    this.commonName,
    this.provider,
    this.providerCode,
    this.logo,
    this.homeUrl,
    this.loginUrl,
    this.countryCode,
    this.automaticFetch,
    this.sortOrder,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['code'] = code;
    data['name'] = name;
    data['commonName'] = commonName;
    data['provider'] = provider;
    data['providerCode'] = providerCode;
    data['logo'] = logo;
    data['homeUrl'] = homeUrl;
    data['loginUrl'] = loginUrl;
    data['countryCode'] = countryCode;
    data['automaticFetch'] = automaticFetch;
    data['sortOrder'] = sortOrder;
    return data;
  }

  @override
  List<Object?> get props => [
        code,
        name,
        commonName,
        provider,
        providerCode,
        logo,
        homeUrl,
        loginUrl,
        countryCode,
        automaticFetch,
        sortOrder,
      ];
}

//create entitiy for with tojson