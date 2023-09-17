import '../../domain/entities/get_currency_entity.dart';

class GetCurrencyResponse extends GetCurrencyEntity {
  GetCurrencyResponse({
    required DateTime date,
    required String currencyName,
    required double conversionRate,
    String? conversionInfo,
  }) : super(
          date: date,
          currencyName: currencyName,
          conversionRate: conversionRate,
          conversionInfo: conversionInfo,
        );

  factory GetCurrencyResponse.fromJson(Map<String, dynamic> json) =>
      GetCurrencyResponse(
        date: DateTime.tryParse(json["date"]) ?? DateTime.now(),
        currencyName: json["currencyName"],
        conversionRate: json["conversionRate"],
        conversionInfo: json["conversionInfo"],
      );

  static final tResponse = GetCurrencyResponse(
      date: DateTime.parse('2022-10-05T21:00:00.000Z'),
      currencyName: "INR",
      conversionRate: 0.02,
      conversionInfo: null);
}
