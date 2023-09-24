import '../../domain/entities/get_currency_entity.dart';

class GetCurrencyConversionResponse extends GetCurrencyConversionEntity {
  const GetCurrencyConversionResponse({
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

  factory GetCurrencyConversionResponse.fromJson(Map<String, dynamic> json) =>
      GetCurrencyConversionResponse(
        date: DateTime.tryParse(json["date"]) ?? DateTime.now(),
        currencyName: json["currencyName"],
        conversionRate: double.tryParse(json["conversionRate"].toString()) ?? 1,
        conversionInfo: json["conversionInfo"] ?? '',
      );

  static final tResponse = GetCurrencyConversionResponse(
      date: DateTime.parse('2022-10-05T21:00:00.000Z'),
      currencyName: "INR",
      conversionRate: 0.02,
      conversionInfo: null);
}
