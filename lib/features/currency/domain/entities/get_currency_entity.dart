import 'package:equatable/equatable.dart';

class GetCurrencyConversionEntity extends Equatable {
  const GetCurrencyConversionEntity({
    required this.date,
    required this.currencyName,
    required this.conversionRate,
    required this.conversionInfo,
  });

  final DateTime date;
  final String currencyName;
  final double conversionRate;
  final String? conversionInfo;

  Map<String, dynamic> toJson() => {
        "date": date,
        "currencyName": currencyName,
        "conversionRate": conversionRate,
        "conversionInfo": conversionInfo,
      };

  @override
  // TODO: implement props
  List<Object?> get props =>
      [date, currencyName, conversionRate, conversionInfo];
}
