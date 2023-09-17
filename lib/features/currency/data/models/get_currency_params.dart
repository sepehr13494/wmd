import 'package:equatable/equatable.dart';

class GetCurrencyConversionParams extends Equatable {
  const GetCurrencyConversionParams({
    required this.fromCurrency,
    required this.toCurrency,
  });

  final String fromCurrency;
  final String toCurrency;

  factory GetCurrencyConversionParams.fromJson(Map<String, dynamic> json) =>
      GetCurrencyConversionParams(
        fromCurrency: json["fromCurrency"],
        toCurrency: json["toCurrency"],
      );

  Map<String, dynamic> toJson() => {
        "FromCurrency": fromCurrency,
        "ToCurrency": toCurrency,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [fromCurrency, toCurrency];

  static const tParams =
      GetCurrencyConversionParams(fromCurrency: "INR", toCurrency: "USD");
}
