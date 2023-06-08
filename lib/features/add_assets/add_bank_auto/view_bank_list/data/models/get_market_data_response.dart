import 'package:wmd/features/add_assets/core/data/models/listed_security_name.dart';
import 'package:wmd/features/valuation/domain/entities/get_valuation_entity.dart';

class GetMarketDataResponse extends ListedSecurityName {
  GetMarketDataResponse({
    required super.category,
    super.currencyCode,
    required super.isin,
    super.label,
    required super.securityName,
    required super.securityShortName,
    required super.tradedExchange,
    super.value,
  });

  factory GetMarketDataResponse.fromJson(Map<String, dynamic> json) =>
      GetMarketDataResponse(
        category: json["assetType"],
        currencyCode: json["currency"],
        isin: json["isinNumber"],
        label: json["companyName"],
        securityName: json["companyName"],
        securityShortName: json["primaryExchangeName"],
        tradedExchange: json["ticker"],
        value: json["companyName"],
      );

  // static final tResponse = [GetAllValuationResponse()];
}
